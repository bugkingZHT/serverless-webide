package main

import (
	"aliyun/serverless/webide-server/pkg/context"
	"aliyun/serverless/webide-server/pkg/vscode"
	"flag"
	"fmt"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
	"path/filepath"
	"strings"
	"time"

	"github.com/golang/glog"
	"github.com/spf13/viper"
)

type ServerManager struct {
	VscodeServer *vscode.Server         // backend vscode server
	Proxy        *httputil.ReverseProxy // frontend reverse proxy
	proxyHandler string
}

// init implements the FC initializer instance lifecycle callback, called by FC runtime before processing the request.
func (sm *ServerManager) init() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		glog.Infof("Starting server manager init ...")

		// Get contextSource option from config file.
		// contextSource indicates where to get the context.
		// In FC runtime, context should be parsed from the request headers.
		// In VM or container, the context should be parsed from the environment variables.
		viper.SetDefault("contextSource", "fc")
		ctxSource := viper.GetString("contextSource")

		var err error
		var ctx *context.Context
		if ctxSource == "env" {
			ctx, err = context.NewFromEnvVars()
		} else {
			ctx, err = context.New(r)
		}
		if err != nil {
			glog.Errorf("Get context from %s failed. Error: %v", ctxSource, err)
			// Context failed because of invalid ak id, ak secret and security token, then return 403 Forbidden error.
			w.WriteHeader(http.StatusForbidden)
			fmt.Fprint(w, err.Error())
			return
		}

		// Create the vscode server.
		sm.VscodeServer, err = vscode.NewServer(ctx)
		if err != nil {
			glog.Errorf("Create vscode server failed. Error: %v", err)
			// Create vscode server failed because of invalid ak id, ak secret and security token, then return 403 Forbidden error.
			w.WriteHeader(http.StatusForbidden)
			fmt.Fprint(w, err.Error())
			return
		}

		// Create the reverse proxy.
		url, err := url.Parse("http://" + sm.VscodeServer.Host + ":" + sm.VscodeServer.Port)
		if err != nil {
			glog.Errorf("Create websocket proxy failed!")
			w.WriteHeader(http.StatusInternalServerError)
			fmt.Fprint(w, err.Error())
			return
		}
		sm.Proxy = httputil.NewSingleHostReverseProxy(url)
		glog.Infof("Create reverse proxy succeeded. Url: %s", url)

		w.WriteHeader(http.StatusOK)
		fmt.Fprint(w, "init handler success")
		glog.Infof("Server manager init success.")
	}
}

func (sm *ServerManager) shutdown() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		glog.Infof("Starting server manager shutdown ...")

		sm.VscodeServer.Shutdown()

		w.WriteHeader(http.StatusOK)
		fmt.Fprint(w, "pre-stop handler success")
		glog.Infof("Server manager shutdown success.")
	}
}

func (sm *ServerManager) process() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		if r != nil {
			glog.Infof("handled by process...")
			// 1. http reverse proxy
			// uniCode length is final '8' and '/' length is '1', so index start from '9'
			if strings.Index(r.RequestURI, sm.proxyHandler) != -1 {
				r.RequestURI = r.RequestURI[9:]
				r.URL.Path = r.URL.Path[9:]
				glog.Infof("get sub URL: " + r.URL.Path)
			}
			sm.Proxy.ServeHTTP(w, r)
		} else {
			glog.Errorf("The input request parameter is nil!")
		}
	}
}

func (sm *ServerManager) static() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		if r != nil {
			glog.Infof("handled by static...")
			// 1. http reverse proxy
			sm.Proxy.ServeHTTP(w, r)
		} else {
			glog.Errorf("The input request parameter is nil!")
		}
	}
}

func main() {
	flag.Parse()
	defer glog.Flush()

	// Get the directory of current running process.
	ex, err := os.Executable()
	if err != nil {
		glog.Fatalf("Failed to get the directory of current running process. Error: %v", err)
	}
	configDir := filepath.Dir(ex)
	configFile := filepath.Join(configDir, "config.yaml")
	serverBinFile := filepath.Join(configDir, "vscode-server", "bin", "openvscode-server")

	// config from ENV
	dataOssPath := os.Getenv("DATA_OSS_PATH")
	workspaceOssPath := os.Getenv("WORKSPACE_OSS_PATH")

	// Setup the config file.
	viper.SetConfigFile(configFile)
	// set some default
	viper.SetDefault("vscode.binaryFilePath", serverBinFile)
	viper.SetDefault("oss.dataPath", dataOssPath)
	viper.SetDefault("oss.workspacePath", workspaceOssPath)

	// Read the configurations from the specified file.
	err = viper.ReadInConfig()
	if err != nil {
		glog.Fatalf("Failed to read ide server config file. Error: %v", err)
	}
	glog.Infof("Reverse proxy read config file from directory: %s", configDir)

	sm := &ServerManager{}

	sm.proxyHandler = os.Getenv("PROXY_HANDLER")

	// Register the initializer handler.
	http.HandleFunc("/initialize", sm.init())

	// Register the shutdown handler.
	http.HandleFunc("/pre-stop", sm.shutdown())

	// Handle all other requests to your server using the proxy.
	glog.Infof("proxyHandler: " + sm.proxyHandler)
	http.HandleFunc("/", sm.static())

	// handle static
	//http.HandleFunc("/static/", sm.static())

	// Start the proxy server.
	proxyServer := &http.Server{
		Addr:        ":9000",
		IdleTimeout: 5 * time.Minute,
	}

	glog.Infof("Reverse proxy listen at %s ...", proxyServer.Addr)
	glog.Fatalf("Reverse proxy run failed. Error: %v", proxyServer.ListenAndServe())
}
