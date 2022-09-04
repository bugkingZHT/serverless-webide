;(function () {
  if (window.AppUrl == undefined) {
    window.AppUrl = {
        free4lab: 'http://www.free4inno.com/',
        account: 'http://account.free4inno.com/users/',
        iaas: 'http://iaas.free4inno.com/',
        paas: 'http://paas.free4inno.com/',
        freeshare: 'http://freeshare.free4inno.com/',
        freeproject: 'http://freeproject.free4inno.com/',
        newfront: 'http://newfront.free4inno.com/',
        about: 'http://www.free4inno.com/?boardId=2'
    };
  }
})();
/**
 * bootbox.js [v4.4.0]
 *
 * http://bootboxjs.com/license.txt
 */

// @see https://github.com/makeusabrew/bootbox/issues/180
// @see https://github.com/makeusabrew/bootbox/issues/186
(function (root, factory) {

  "use strict";
  if (typeof define === "function" && define.amd) {
    // AMD. Register as an anonymous module.
    define(["jquery.ztree.core-3.5"], factory);
  } else if (typeof exports === "object") {
    // Node. Does not work with strict CommonJS, but
    // only CommonJS-like environments that support module.exports,
    // like Node.
    module.exports = factory(require("jquery"));
  } else {
    // Browser globals (root is window)
    root.bootbox = factory(root.jQuery);
  }

}(this, function init($, undefined) {

  "use strict";

  // the base DOM structure needed to create a modal
  var templates = {
    dialog:
      "<div class='bootbox modal' tabindex='-1' role='dialog'>" +
        "<div class='modal-dialog'>" +
          "<div id='bootbox' class='modal-content'>" +
            "<div class='modal-body'><div class='bootbox-body'></div></div>" +
          "</div>" +
        "</div>" +
      "</div>",
    header:
      "<div class='modal-header'>" +
        "<h4 class='modal-title'></h4>" +
      "</div>",
    footer:
      "<div class='modal-footer'></div>",
    closeButton:
      "<button type='button' class='bootbox-close-button close' data-dismiss='modal' aria-hidden='true'>&times;</button>",
    form:
      "<form class='bootbox-form'></form>",
    inputs: {
      text:
        "<input class='bootbox-input bootbox-input-text form-control' autocomplete=off type=text />",
      textarea:
        "<textarea class='bootbox-input bootbox-input-textarea form-control'></textarea>",
      email:
        "<input class='bootbox-input bootbox-input-email form-control' autocomplete='off' type='email' />",
      select:
        "<select class='bootbox-input bootbox-input-select form-control'></select>",
      checkbox:
        "<div class='checkbox'><label><input class='bootbox-input bootbox-input-checkbox' type='checkbox' /></label></div>",
      date:
        "<input class='bootbox-input bootbox-input-date form-control' autocomplete=off type='date' />",
      time:
        "<input class='bootbox-input bootbox-input-time form-control' autocomplete=off type='time' />",
      number:
        "<input class='bootbox-input bootbox-input-number form-control' autocomplete=off type='number' />",
      password:
        "<input class='bootbox-input bootbox-input-password form-control' autocomplete='off' type='password' />"
    }
  };

  var defaults = {
    // default language
    locale: "en",
    // show backdrop or not. Default to static so user has to interact with dialog
    backdrop: "static",
    // animate the modal in/out
    animate: true,
    // additional class string applied to the top level dialog
    className: null,
    // whether or not to include a close button
    closeButton: true,
    // show the dialog immediately by default
    show: true,
    // dialog container
    container: "body"
  };

  // our public object; augmented after our private API
  var exports = {};

  /**
   * @private
   */
  function _t(key) {
    var locale = locales[defaults.locale];
    return locale ? locale[key] : locales.en[key];
  }

  function processCallback(e, dialog, callback) {
    e.stopPropagation();
    e.preventDefault();

    // by default we assume a callback will get rid of the dialog,
    // although it is given the opportunity to override this

    // so, if the callback can be invoked and it *explicitly returns false*
    // then we'll set a flag to keep the dialog active...
    var preserveDialog = $.isFunction(callback) && callback.call(dialog, e) === false;

    // ... otherwise we'll bin it
    if (!preserveDialog) {
      dialog.modal("hide");
    }
  }

  function getKeyLength(obj) {
    // @TODO defer to Object.keys(x).length if available?
    var k, t = 0;
    for (k in obj) {
      t ++;
    }
    return t;
  }

  function each(collection, iterator) {
    var index = 0;
    $.each(collection, function(key, value) {
      iterator(key, value, index++);
    });
  }

  function sanitize(options) {
    var buttons;
    var total;

    if (typeof options !== "object") {
      throw new Error("Please supply an object of options");
    }

    if (!options.message) {
      throw new Error("Please specify a message");
    }

    // make sure any supplied options take precedence over defaults
    options = $.extend({}, defaults, options);

    if (!options.buttons) {
      options.buttons = {};
    }

    buttons = options.buttons;

    total = getKeyLength(buttons);

    each(buttons, function(key, button, index) {

      if ($.isFunction(button)) {
        // short form, assume value is our callback. Since button
        // isn't an object it isn't a reference either so re-assign it
        button = buttons[key] = {
          callback: button
        };
      }

      // before any further checks make sure by now button is the correct type
      if ($.type(button) !== "object") {
        throw new Error("button with key " + key + " must be an object");
      }

      if (!button.label) {
        // the lack of an explicit label means we'll assume the key is good enough
        button.label = key;
      }

      if (!button.className) {
        if (total <= 2 && index === total-1) {
          // always add a primary to the main option in a two-button dialog
          button.className = "btn-primary";
        } else {
          button.className = "btn-default";
        }
      }
    });

    return options;
  }

  /**
   * map a flexible set of arguments into a single returned object
   * if args.length is already one just return it, otherwise
   * use the properties argument to map the unnamed args to
   * object properties
   * so in the latter case:
   * mapArguments(["foo", $.noop], ["message", "callback"])
   * -> { message: "foo", callback: $.noop }
   */
  function mapArguments(args, properties) {
    var argn = args.length;
    var options = {};

    if (argn < 1 || argn > 2) {
      throw new Error("Invalid argument length");
    }

    if (argn === 2 || typeof args[0] === "string") {
      options[properties[0]] = args[0];
      options[properties[1]] = args[1];
    } else {
      options = args[0];
    }

    return options;
  }

  /**
   * merge a set of default dialog options with user supplied arguments
   */
  function mergeArguments(defaults, args, properties) {
    return $.extend(
      // deep merge
      true,
      // ensure the target is an empty, unreferenced object
      {},
      // the base options object for this type of dialog (often just buttons)
      defaults,
      // args could be an object or array; if it's an array properties will
      // map it to a proper options object
      mapArguments(
        args,
        properties
      )
    );
  }

  /**
   * this entry-level method makes heavy use of composition to take a simple
   * range of inputs and return valid options suitable for passing to bootbox.dialog
   */
  function mergeDialogOptions(className, labels, properties, args) {
    //  build up a base set of dialog properties
    var baseOptions = {
      className: "bootbox-" + className,
      buttons: createLabels.apply(null, labels)
    };

    // ensure the buttons properties generated, *after* merging
    // with user args are still valid against the supplied labels
    return validateButtons(
      // merge the generated base properties with user supplied arguments
      mergeArguments(
        baseOptions,
        args,
        // if args.length > 1, properties specify how each arg maps to an object key
        properties
      ),
      labels
    );
  }

  /**
   * from a given list of arguments return a suitable object of button labels
   * all this does is normalise the given labels and translate them where possible
   * e.g. "ok", "confirm" -> { ok: "OK, cancel: "Annuleren" }
   */
  function createLabels() {
    var buttons = {};

    for (var i = 0, j = arguments.length; i < j; i++) {
      var argument = arguments[i];
      var key = argument.toLowerCase();
      var value = argument.toUpperCase();

      buttons[key] = {
        label: _t(value)
      };
    }

    return buttons;
  }

  function validateButtons(options, buttons) {
    var allowedButtons = {};
    each(buttons, function(key, value) {
      allowedButtons[value] = true;
    });

    each(options.buttons, function(key) {
      if (allowedButtons[key] === undefined) {
        throw new Error("button key " + key + " is not allowed (options are " + buttons.join("\n") + ")");
      }
    });

    return options;
  }

  exports.alert = function() {
    var options;

    options = mergeDialogOptions("alert", ["ok"], ["message", "callback"], arguments);

    if (options.callback && !$.isFunction(options.callback)) {
      throw new Error("alert requires callback property to be a function when provided");
    }

    /**
     * overrides
     */
    options.buttons.ok.callback = options.onEscape = function() {
      if ($.isFunction(options.callback)) {
        return options.callback.call(this);
      }
      return true;
    };

    return exports.dialog(options);
  };

  exports.confirm = function() {
    var options;

    options = mergeDialogOptions("confirm", ["cancel", "confirm"], ["message", "callback"], arguments);

    /**
     * overrides; undo anything the user tried to set they shouldn't have
     */
    options.buttons.cancel.callback = options.onEscape = function() {
      return options.callback.call(this, false);
    };

    options.buttons.confirm.callback = function() {
      return options.callback.call(this, true);
    };

    // confirm specific validation
    if (!$.isFunction(options.callback)) {
      throw new Error("confirm requires a callback");
    }

    return exports.dialog(options);
  };

  exports.prompt = function() {
    var options;
    var defaults;
    var dialog;
    var form;
    var input;
    var shouldShow;
    var inputOptions;

    // we have to create our form first otherwise
    // its value is undefined when gearing up our options
    // @TODO this could be solved by allowing message to
    // be a function instead...
    form = $(templates.form);

    // prompt defaults are more complex than others in that
    // users can override more defaults
    // @TODO I don't like that prompt has to do a lot of heavy
    // lifting which mergeDialogOptions can *almost* support already
    // just because of 'value' and 'inputType' - can we refactor?
    defaults = {
      className: "bootbox-prompt",
      buttons: createLabels("cancel", "confirm"),
      value: "",
      inputType: "text"
    };

    options = validateButtons(
      mergeArguments(defaults, arguments, ["title", "callback"]),
      ["cancel", "confirm"]
    );

    // capture the user's show value; we always set this to false before
    // spawning the dialog to give us a chance to attach some handlers to
    // it, but we need to make sure we respect a preference not to show it
    shouldShow = (options.show === undefined) ? true : options.show;

    /**
     * overrides; undo anything the user tried to set they shouldn't have
     */
    options.message = form;

    options.buttons.cancel.callback = options.onEscape = function() {
      return options.callback.call(this, null);
    };

    options.buttons.confirm.callback = function() {
      var value;

      switch (options.inputType) {
        case "text":
        case "textarea":
        case "email":
        case "select":
        case "date":
        case "time":
        case "number":
        case "password":
          value = input.val();
          break;

        case "checkbox":
          var checkedItems = input.find("input:checked");

          // we assume that checkboxes are always multiple,
          // hence we default to an empty array
          value = [];

          each(checkedItems, function(_, item) {
            value.push($(item).val());
          });
          break;
      }

      return options.callback.call(this, value);
    };

    options.show = false;

    // prompt specific validation
    if (!options.title) {
      throw new Error("prompt requires a title");
    }

    if (!$.isFunction(options.callback)) {
      throw new Error("prompt requires a callback");
    }

    if (!templates.inputs[options.inputType]) {
      throw new Error("invalid prompt type");
    }

    // create the input based on the supplied type
    input = $(templates.inputs[options.inputType]);

    switch (options.inputType) {
      case "text":
      case "textarea":
      case "email":
      case "date":
      case "time":
      case "number":
      case "password":
        input.val(options.value);
        break;

      case "select":
        var groups = {};
        inputOptions = options.inputOptions || [];

        if (!$.isArray(inputOptions)) {
          throw new Error("Please pass an array of input options");
        }

        if (!inputOptions.length) {
          throw new Error("prompt with select requires options");
        }

        each(inputOptions, function(_, option) {

          // assume the element to attach to is the input...
          var elem = input;

          if (option.value === undefined || option.text === undefined) {
            throw new Error("given options in wrong format");
          }

          // ... but override that element if this option sits in a group

          if (option.group) {
            // initialise group if necessary
            if (!groups[option.group]) {
              groups[option.group] = $("<optgroup/>").attr("label", option.group);
            }

            elem = groups[option.group];
          }

          elem.append("<option value='" + option.value + "'>" + option.text + "</option>");
        });

        each(groups, function(_, group) {
          input.append(group);
        });

        // safe to set a select's value as per a normal input
        input.val(options.value);
        break;

      case "checkbox":
        var values   = $.isArray(options.value) ? options.value : [options.value];
        inputOptions = options.inputOptions || [];

        if (!inputOptions.length) {
          throw new Error("prompt with checkbox requires options");
        }

        if (!inputOptions[0].value || !inputOptions[0].text) {
          throw new Error("given options in wrong format");
        }

        // checkboxes have to nest within a containing element, so
        // they break the rules a bit and we end up re-assigning
        // our 'input' element to this container instead
        input = $("<div/>");

        each(inputOptions, function(_, option) {
          var checkbox = $(templates.inputs[options.inputType]);

          checkbox.find("input").attr("value", option.value);
          checkbox.find("label").append(option.text);

          // we've ensured values is an array so we can always iterate over it
          each(values, function(_, value) {
            if (value === option.value) {
              checkbox.find("input").prop("checked", true);
            }
          });

          input.append(checkbox);
        });
        break;
    }

    // @TODO provide an attributes option instead
    // and simply map that as keys: vals
    if (options.placeholder) {
      input.attr("placeholder", options.placeholder);
    }

    if (options.pattern) {
      input.attr("pattern", options.pattern);
    }

    if (options.maxlength) {
      input.attr("maxlength", options.maxlength);
    }

    // now place it in our form
    form.append(input);

    form.on("submit", function(e) {
      e.preventDefault();
      // Fix for SammyJS (or similar JS routing library) hijacking the form post.
      e.stopPropagation();
      // @TODO can we actually click *the* button object instead?
      // e.g. buttons.confirm.click() or similar
      dialog.find(".btn-primary").click();
    });

    dialog = exports.dialog(options);

    // clear the existing handler focusing the submit button...
    dialog.off("shown.bs.modal");

    // ...and replace it with one focusing our input, if possible
    dialog.on("shown.bs.modal", function() {
      // need the closure here since input isn't
      // an object otherwise
      input.focus();
    });

    if (shouldShow === true) {
      dialog.modal("show");
    }

    return dialog;
  };

  exports.dialog = function(options) {
    options = sanitize(options);

    var dialog = $(templates.dialog);
    var innerDialog = dialog.find(".modal-dialog");
    var body = dialog.find(".modal-body");
    var buttons = options.buttons;
    var buttonStr = "";
    var callbacks = {
      onEscape: options.onEscape
    };

    if ($.fn.modal === undefined) {
      throw new Error(
        "$.fn.modal is not defined; please double check you have included " +
        "the Bootstrap JavaScript library. See http://getbootstrap.com/javascript/ " +
        "for more details."
      );
    }

    each(buttons, function(key, button) {

      // @TODO I don't like this string appending to itself; bit dirty. Needs reworking
      // can we just build up button elements instead? slower but neater. Then button
      // can just become a template too
      buttonStr += "<button data-bb-handler='" + key + "' type='button' class='btn " + button.className + "'>" + button.label + "</button>";
      callbacks[key] = button.callback;
    });

    body.find(".bootbox-body").html(options.message);

    if (options.animate === true) {
      dialog.addClass("fade");
    }

    if (options.className) {
      dialog.addClass(options.className);
    }

    if (options.size === "large") {
      innerDialog.addClass("modal-lg");
    } else if (options.size === "small") {
      innerDialog.addClass("modal-sm");
    }

    if (options.title) {
      body.before(templates.header);
    }

    if (options.closeButton) {
      var closeButton = $(templates.closeButton);

      if (options.title) {
        dialog.find(".modal-header").prepend(closeButton);
      } else {
        closeButton.css("margin-top", "-10px").prependTo(body);
      }
    }

    if (options.title) {
      dialog.find(".modal-title").html(options.title);
    }

    if (buttonStr.length) {
      body.after(templates.footer);
      dialog.find(".modal-footer").html(buttonStr);
    }


    /**
     * Bootstrap event listeners; used handle extra
     * setup & teardown required after the underlying
     * modal has performed certain actions
     */

    dialog.on("hidden.bs.modal", function(e) {
      // ensure we don't accidentally intercept hidden events triggered
      // by children of the current dialog. We shouldn't anymore now BS
      // namespaces its events; but still worth doing
      if (e.target === this) {
        dialog.remove();
      }
    });

    /*
    dialog.on("show.bs.modal", function() {
      // sadly this doesn't work; show is called *just* before
      // the backdrop is added so we'd need a setTimeout hack or
      // otherwise... leaving in as would be nice
      if (options.backdrop) {
        dialog.next(".modal-backdrop").addClass("bootbox-backdrop");
      }
    });
    */

    dialog.on("shown.bs.modal", function() {
      dialog.find(".btn-primary:first").focus();
    });

    /**
     * Bootbox event listeners; experimental and may not last
     * just an attempt to decouple some behaviours from their
     * respective triggers
     */

    if (options.backdrop !== "static") {
      // A boolean true/false according to the Bootstrap docs
      // should show a dialog the user can dismiss by clicking on
      // the background.
      // We always only ever pass static/false to the actual
      // $.modal function because with `true` we can't trap
      // this event (the .modal-backdrop swallows it)
      // However, we still want to sort of respect true
      // and invoke the escape mechanism instead
      dialog.on("click.dismiss.bs.modal", function(e) {
        // @NOTE: the target varies in >= 3.3.x releases since the modal backdrop
        // moved *inside* the outer dialog rather than *alongside* it
        if (dialog.children(".modal-backdrop").length) {
          e.currentTarget = dialog.children(".modal-backdrop").get(0);
        }

        if (e.target !== e.currentTarget) {
          return;
        }

        dialog.trigger("escape.close.bb");
      });
    }

    dialog.on("escape.close.bb", function(e) {
      if (callbacks.onEscape) {
        processCallback(e, dialog, callbacks.onEscape);
      }
    });

    /**
     * Standard jQuery event listeners; used to handle user
     * interaction with our dialog
     */

    dialog.on("click", ".modal-footer button", function(e) {
      var callbackKey = $(this).data("bb-handler");

      processCallback(e, dialog, callbacks[callbackKey]);
    });

    dialog.on("click", ".bootbox-close-button", function(e) {
      // onEscape might be falsy but that's fine; the fact is
      // if the user has managed to click the close button we
      // have to close the dialog, callback or not
      processCallback(e, dialog, callbacks.onEscape);
    });

    dialog.on("keyup", function(e) {
      if (e.which === 27) {
        dialog.trigger("escape.close.bb");
      }
    });

    // the remainder of this method simply deals with adding our
    // dialogent to the DOM, augmenting it with Bootstrap's modal
    // functionality and then giving the resulting object back
    // to our caller

    $(options.container).append(dialog);

    dialog.modal({
      backdrop: options.backdrop ? "static": false,
      keyboard: false,
      show: false
    });

    if (options.show) {
      dialog.modal("show");
    }

    // @TODO should we return the raw element here or should
    // we wrap it in an object on which we can expose some neater
    // methods, e.g. var d = bootbox.alert(); d.hide(); instead
    // of d.modal("hide");

   /*
    function BBDialog(elem) {
      this.elem = elem;
    }

    BBDialog.prototype = {
      hide: function() {
        return this.elem.modal("hide");
      },
      show: function() {
        return this.elem.modal("show");
      }
    };
    */

    return dialog;

  };

  exports.setDefaults = function() {
    var values = {};

    if (arguments.length === 2) {
      // allow passing of single key/value...
      values[arguments[0]] = arguments[1];
    } else {
      // ... and as an object too
      values = arguments[0];
    }

    $.extend(defaults, values);
  };

  exports.hideAll = function() {
    $(".bootbox").modal("hide");

    return exports;
  };


  /**
   * standard locales. Please add more according to ISO 639-1 standard. Multiple language variants are
   * unlikely to be required. If this gets too large it can be split out into separate JS files.
   */
  var locales = {
    bg_BG : {
      OK      : "Ок",
      CANCEL  : "Отказ",
      CONFIRM : "Потвърждавам"
    },
    br : {
      OK      : "OK",
      CANCEL  : "Cancelar",
      CONFIRM : "Sim"
    },
    cs : {
      OK      : "OK",
      CANCEL  : "Zrušit",
      CONFIRM : "Potvrdit"
    },
    da : {
      OK      : "OK",
      CANCEL  : "Annuller",
      CONFIRM : "Accepter"
    },
    de : {
      OK      : "OK",
      CANCEL  : "Abbrechen",
      CONFIRM : "Akzeptieren"
    },
    el : {
      OK      : "Εντάξει",
      CANCEL  : "Ακύρωση",
      CONFIRM : "Επιβεβαίωση"
    },
    en : {
      OK      : "OK",
      CANCEL  : "Cancel",
      CONFIRM : "OK"
    },
    es : {
      OK      : "OK",
      CANCEL  : "Cancelar",
      CONFIRM : "Aceptar"
    },
    et : {
      OK      : "OK",
      CANCEL  : "Katkesta",
      CONFIRM : "OK"
    },
    fa : {
      OK      : "قبول",
      CANCEL  : "لغو",
      CONFIRM : "تایید"
    },
    fi : {
      OK      : "OK",
      CANCEL  : "Peruuta",
      CONFIRM : "OK"
    },
    fr : {
      OK      : "OK",
      CANCEL  : "Annuler",
      CONFIRM : "D'accord"
    },
    he : {
      OK      : "אישור",
      CANCEL  : "ביטול",
      CONFIRM : "אישור"
    },
    hu : {
      OK      : "OK",
      CANCEL  : "Mégsem",
      CONFIRM : "Megerősít"
    },
    hr : {
      OK      : "OK",
      CANCEL  : "Odustani",
      CONFIRM : "Potvrdi"
    },
    id : {
      OK      : "OK",
      CANCEL  : "Batal",
      CONFIRM : "OK"
    },
    it : {
      OK      : "OK",
      CANCEL  : "Annulla",
      CONFIRM : "Conferma"
    },
    ja : {
      OK      : "OK",
      CANCEL  : "キャンセル",
      CONFIRM : "確認"
    },
    lt : {
      OK      : "Gerai",
      CANCEL  : "Atšaukti",
      CONFIRM : "Patvirtinti"
    },
    lv : {
      OK      : "Labi",
      CANCEL  : "Atcelt",
      CONFIRM : "Apstiprināt"
    },
    nl : {
      OK      : "OK",
      CANCEL  : "Annuleren",
      CONFIRM : "Accepteren"
    },
    no : {
      OK      : "OK",
      CANCEL  : "Avbryt",
      CONFIRM : "OK"
    },
    pl : {
      OK      : "OK",
      CANCEL  : "Anuluj",
      CONFIRM : "Potwierdź"
    },
    pt : {
      OK      : "OK",
      CANCEL  : "Cancelar",
      CONFIRM : "Confirmar"
    },
    ru : {
      OK      : "OK",
      CANCEL  : "Отмена",
      CONFIRM : "Применить"
    },
    sq : {
      OK : "OK",
      CANCEL : "Anulo",
      CONFIRM : "Prano"
    },
    sv : {
      OK      : "OK",
      CANCEL  : "Avbryt",
      CONFIRM : "OK"
    },
    th : {
      OK      : "ตกลง",
      CANCEL  : "ยกเลิก",
      CONFIRM : "ยืนยัน"
    },
    tr : {
      OK      : "Tamam",
      CANCEL  : "İptal",
      CONFIRM : "Onayla"
    },
    zh_CN : {
      OK      : "确定",
      CANCEL  : "取消",
      CONFIRM : "确定"
    },
    zh_TW : {
      OK      : "OK",
      CANCEL  : "取消",
      CONFIRM : "確認"
    }
  };

  exports.addLocale = function(name, values) {
    $.each(["OK", "CANCEL", "CONFIRM"], function(_, v) {
      if (!values[v]) {
        throw new Error("Please supply a translation for '" + v + "'");
      }
    });

    locales[name] = {
      OK: values.OK,
      CANCEL: values.CANCEL,
      CONFIRM: values.CONFIRM
    };

    return exports;
  };

  exports.removeLocale = function(name) {
    delete locales[name];

    return exports;
  };

  exports.setLocale = function(name) {
    return exports.setDefaults("locale", name);
  };

  exports.init = function(_$) {
    return init(_$ || $);
  };

  return exports;
}));

(function($){
    jQuery.getDivPageHtml=function(curPage, endPage, funcName){

        /*
         * creates pagination
         * @ author zxy
         * @ return pageHtml
         * curPage 当前页数
         * endPage 最终页数
         * funcName 异步加载的方法名 异步方法包括两个参数funcName(page)
         *
         */

        var pageHtml = "";
        var showPage = 6;

        pageHtml += '<div class="text-center"><ul class="pagination">';

        if (endPage == 1) {
            pageHtml += "<li class=\"disabled\"><a aria-label=\"Previous\">&laquo;</a></li>" +
                        "<li class=\"active\"><a>1</a></li>" +
                        "<li class=\"disabled\"><a aria-label=\"Next\">&raquo;</a></li></ul></div>";

            return pageHtml;
        }

        if (curPage == 1) {
            pageHtml += "<li class=\"disabled\"><a aria-label=\"Previous\">&laquo;</a></li>";
        } else {
            pageHtml += "<li><a href=\"javascript:" + funcName + "(" + (curPage - 1) + ");\" aria-label=\"Previous\">&laquo;</a></li>";
        }

        var tmpBegin = 1;
        var tmpEnd = 1;
        var tmpSum = (endPage - endPage % showPage) / showPage;

        /*for (var k = 0; k < tmpSum; k++) {
            tmpBegin = showPage * k + 1;
            tmpEnd = showPage * k + showPage;
            if (curPage >= tmpBegin && curPage < tmpEnd) {
                break;
            }
        }*/
        // 以下部分为计算分页显示多少中间页
        if (endPage <= showPage) {
            tmpBegin = 1;
            tmpEnd = endPage;
        } else {
            if (curPage < showPage) {
                tmpBegin = 1;
                tmpEnd = showPage
            } else if (curPage > endPage - showPage + 1) {
                tmpBegin = endPage - showPage + 1;
                tmpEnd = endPage;
            } else {
                tmpBegin = curPage - Math.ceil(showPage / 2) + 1;
                tmpEnd = parseInt(curPage) + parseInt(Math.floor(showPage / 2));
            }
        }

        // 首页 & 省略号
        if (tmpBegin > 2) {
            pageHtml += "<li><a href=\"javascript:" + funcName + "(1);\" aria-label=\"First\">1</a></li>";
            pageHtml += "<li><a aria-label=\"PreMore\">...</a></li>"
        } else if (tmpBegin == 2) {
            pageHtml += "<li><a href=\"javascript:" + funcName + "(1);\" aria-label=\"First\">1</a></li>";
        }

        for (var i = tmpBegin; i <= tmpEnd; i++) {
            if (i == curPage) {
                pageHtml += "<li class=\"active\"><a>" + i + "</a>";
                continue;
            }
            pageHtml += "<li><a href=\"javascript:"+ funcName + "(" + i + ");\">" + i + "</a>";
        }

        // 省略号 & 尾页
        if (tmpEnd < endPage - 1) {
            pageHtml += "<li><a aria-label=\"AfterMore\">...</a></li>"
            pageHtml += "<li><a href=\"javascript:" + funcName + "(" + endPage + ");\" aria-label=\"Last\">" + endPage + "</a></li>"
        } else if (tmpEnd == endPage - 1) {
            pageHtml += "<li><a href=\"javascript:" + funcName + "(" + endPage + ");\" aria-label=\"Last\">" + endPage + "</a></li>"
        }

        if (curPage != endPage) {
            pageHtml += "<li><a href=\"javascript:" + funcName + "(" + (parseInt(curPage) + 1) + ");\" aria-label=\"Next\">&raquo;</a></li></ul></div>";
        } else {
            pageHtml += "<li class=\"disabled\"><a aria-label=\"Next\">&raquo;</a></li></ul></div>";
        }

        return pageHtml;
    }
})(jQuery);
$.fn.frFileUpload = function (option) {
    var $this = $(this);

    var $trigger = $this.find('[data-trigger]');
    var $inputFile = $this.find('input[type="file"]');
    var $uploadTable = $this.find('table[data-file-info]')

    $this['default'] = {
        dismissTime: 3000,
        maxFileSize: 30 * 1024,
        uploadCallback: function(data) {
            return true;
        }
    }

    $this['config'] = $.extend($this['default'], option)

    $inputFile.width($trigger.outerWidth());
    $inputFile.height($trigger.outerHeight());

    $this.fileUploadUIReady({
        autoUpload: false,
        maxChunkSize: 20 * 1024 * 1024,
        namespace: 'fr_file_' + (new Date()).getTime(), // namespace 在同一页面是否必须唯一？
        fileInputFilter: $inputFile,
        dropZone: $trigger,
        uploadTable: $uploadTable,
        downloadTable: $uploadTable,
        acceptFileTypes: $this['config']['acceptFileTypes'],

        buildUploadRow: function (files, index) {
            $uploadTable.html('')

            return $("<table><tr>" + "<td><font color=\"red\">" + files[index].name + "</font></td>" +
                "<td class=\"file_upload_progress\"><div></div></td></table>");
        },

        beforeSend: function (event, files, index, xhr, handler, callBack) {
            //test the type of file
            var regexp = $this.config.acceptFileTypes;
            var area = handler.uploadRow.find('.file_upload_progress').html('');

            if (regexp != undefined && !regexp.test(files[index].name)) {
                area.html($this['config']['fileTypeHint']);

                setTimeout(function () {
                    handler.removeNode(handler.uploadRow);
                }, $this['config']['dismissTime']);

                return;
            }

            //test the size of file
            if (files[index].size > $this.config.maxFileSize) {

                area.html('文件必须小于' + ($this.config.maxFileSize >> 10) + 'KB!');

                setTimeout(function () {
                    handler.removeNode(handler.uploadRow);
                }, $this['config']['dismissTime']);

                return;
            }

            callBack();
        },

        buildDownloadRow: function (data) {
            var status = $this['config'].uploadCallback(data);

            if (status == false) {
                return $('<tr><td style="color: red;">文件上传失败，请重传！</td></tr>');
            }
        }
    })

    return $this;
}

//js unicode和gb2312之间的转码
var GB2312UnicodeConverter = {
    ToUnicode: function (str) {
        return str != null ? escape(str).toLocaleLowerCase().replace(/%u/gi, '\\u') : null;
    }
    , ToGB2312: function (str) {
        return str != null ? unescape(str.replace(/\\u/gi, '%u')) : null;
    }
};

//写cookies
function nSetCookie(name,value,time)
{
    var strsec = getsec(time);
    var exp = new Date();
    exp.setTime(exp.getTime() + strsec*1);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function getsec(str)
{
    var str1=str.substring(1,str.length)*1;
    var str2=str.substring(0,1);
    if (str2=="s"){
        return str1*1000;
    }else if (str2=="h"){
        return str1*60*60*1000;
    }else if (str2=="d"){
        return str1*24*60*60*1000;
    }
}

//读取cookies
function nGetCookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");

    if(arr=document.cookie.match(reg))
        return (arr[2]);
    else
        return null;
}

//删除cookies
function delCookie(name){
  //获取当前时间 
  var date=new Date(); 
  //将date设置为过去的时间 
  date.setTime(date.getTime() - 10000);
  var v = nGetCookie(name);
  //将userId这个cookie删除 
  if (v != null) {
    document.cookie = name + "=" + v + "; expires=" + date.toGMTString();
  }
}

// 新手指南
function primer() {
  // check cookie is it a fresh
  // assume cookie fresh key value is
  var freshFlag = nGetCookie('fresh')
  if (freshFlag == null || freshFlag == 'false') {
    nSetCookie('fresh', 'true', 'd120')
  } else {
    return;
  }

  // yes it is
  // full-screen mask
  var $body = $(document.body);
  var $mask = $([
    '<div class="modal-backdrop fade" style="bottom: 0; z-index: 1040;"></div>'
  ].join(''));
  $body.append($mask)
  $mask.addClass('in');

  // ok you need to write a 'next' function
  // with the help of data-intro element array
  // it can make it

  // so the first thing i need to do is check out what the type of $('[data-intro]') return

  // select data-intro
  var introElement = $('[data-intro]'); // actually object
  var rankIntroElement = new Array();

  var i = 0;
  for (; i < introElement.length; ++i) {
    rankIntroElement.push($(introElement[i]));
  }

  // rank these element with data-intro value
  // sort reference
  function sortOrder(a, b) {
    return a.data('intro') - b.data('intro');
  }

  rankIntroElement.sort(sortOrder);

  var templateBottom = [
    '<div class="popover bottom">',
    '<div class="arrow"></div>',
    '<h3 class="popover-title">', 'Title', '</h3>', // 3
    '<div class="popover-content">',
    '<p>', 'Content', '</p>', // 7
    '<div class="text-right">',
    '<button class="btn btn-primary" data-intro-get>', 'get it~', '</button>', // 11
    '</div>',
    '</div>',
    '</div>'
  ];

  var titleIndex = 3;
  var contentIndex = 7;
  var okIndex = 11;

  // generate html code & fill content
  var introPopup = new Array();
  for (i = 0; i < rankIntroElement.length; ++i) {
    var title = rankIntroElement[i].data('intro-title');
    var content = rankIntroElement[i].data('intro-content');

    var popup = templateBottom.slice();
    if (title != undefined && title.trim() != '') {
      popup[titleIndex] = title;
    }
    if (content != undefined && content.trim() != '') {
      popup[contentIndex] = content;
    }

    var $popup = $(popup.join(''));
    introPopup.push($popup);
    $body.append($popup);
    $popup.click(incNext);
  }

  var next = 0;
  function incNext(evt) {
    if ($(evt.target).is('[data-intro-get]')) {
      introPopup[next].removeAttr('style');
      ++next;
      showNext();
    }
  }

  showNext();

  // show the next one
  function showNext() {
    if (next < rankIntroElement.length) {
      // shift position to show
      var offsetLeft = rankIntroElement[next].offset().left - 2 + rankIntroElement[next].width() / 2;
      var centerOffset = offsetLeft - introPopup[next].width() / 2;

      if (centerOffset < 0) { // beyond screen
        centerOffset = offsetLeft - 13; // arrow width 22 border width 1 then 22 / 2 + 2
        if (centerOffset < 0) {
          centerOffset = 0;
        }
        introPopup[next].children('.arrow').css({'left': '0', 'margin-left': centerOffset}); // arrow offset
        centerOffset = 0; // popup offset
      }

      introPopup[next].css('display', 'block')
          .css('top', '54px')
          .css('left', centerOffset)
    } else {
      $mask.remove();
    }
  }
}
(function($, undefined) {
    $.fn.getCursorPosition = function() {
        var el = $(this).get(0);
        var pos = 0;
        if ('selectionStart' in el) {
            pos = el.selectionStart;
        } else if ('selection' in document) {
            el.focus();
            var Sel = document.selection.createRange();
            var SelLength = document.selection.createRange().text.length;
            Sel.moveStart('character', -el.value.length);
            pos = Sel.text.length - SelLength;
        }
        return pos;
    }
})(jQuery);
/**
	@class about browser
 */

var K = {};
K.Browser = (function() {
	var na = window.navigator,
		ua = na.userAgent.toLowerCase(),
		browserTester = /(msie|webkit|gecko|presto|opera|safari|firefox|chrome|maxthon)[ \/]([\d.]+)/ig,
		Browser = {
			platform: na.platform
		};
	ua.replace(browserTester, function(a, b, c) {
		var bLower = b.toLowerCase();
		Browser[bLower] = c;
	});
	if (Browser.opera) { //Opera9.8后版本号位置变化
		ua.replace(/opera.*version\/([\d.]+)/, function(a, b) {
			Browser.opera = b;
		});
	}
	if (Browser.msie) {
		Browser.ie = Browser.msie;
		var v = parseInt(Browser.msie, 10);
		Browser['ie' + v] = true;
	}
	return Browser;
}());

K.isFunction = function(obj) {
	return !!(obj && obj.constructor && obj.call && obj.apply);
};
/**
	@LocalStorage class 
 */
var LocalStorage = (function(){
		var ls = window.localStorage;
		function _onstorage( key, callback ){
			var oldValue = ls[key];

			/*
				IE下即使是当前页面触发的数据变更，当前页面也能收到onstorage事件，其他浏览器则只会在其他页面收到
			 */
			return function( e ){
				//IE下不使用setTimeout尽然获取不到改变后的值?!
				setTimeout( function(){
					e = e || window.storageEvent;

					var tKey = e.key,
						newValue = e.newValue;
					//IE下不支持key属性,因此需要根据storage中的数据判断key中的数据是否变化
					if( !tKey ){
						var nv = ls[key];
						if( nv != oldValue ){
							tKey = key;
							newValue = nv;
						}
						
					}
					
					if( tKey == key ){					
						callback && callback(newValue);

						oldValue = newValue;
					}
				}, 0 );
			}
		}
	return {
		getItem: function( key ){
			return ls.getItem( key );
		},
		setItem: function( key, val ){
			return ls.setItem( key, val );
		},
		removeItem: function( key, val ){
			return ls.removeItem( key );
		},
		clear: function(){
			return ls.clear();
		},
		onstorage: function( key, callback ){
			//IE6/7、Chrome使用interval检查更新，其他使用onchange事件
			/*
			Chrome下(14.0.794.0)重写了document.domain之后会导致onstorage不触发
			鉴于onstorage的兼容性问题暂时不使用onstorage事件，改用传统的轮询方式检查数据变化				
			*/
			var b = K.Browser;

			if( !this.useTimer ){
				//IE注册在document上
				if( document.attachEvent && !K.Browser.opera ) {
					document.attachEvent("onstorage", _onstorage(key,callback));
				}
				//其他注册在window上
				else{
					window.addEventListener("storage", _onstorage(key,callback), false);
				};
			}
			else{
			/*
				新的检查方式
			 */
				var listener = _onstorage( key, callback );
				setInterval(function(){
					listener({});
				}, this.interval);	
			}
		},
		//是否使用timer来check(实际项目中由于设置了Domain故Chrome下也需要使用Timer,简单环境下不需要
		useTimer: ( K.Browser.ie && K.Browser.ie < 8 ),
		//onstorage会响应当前页面对存储数据的修改(IE以及Firefox3.6)
		triggerSelf: K.Browser.ie || ( parseInt( K.Browser.firefox ) < 4 ) ,
		//检查storage是否发生变化的时间间隔
		interval: 500
	};
})();

/**
	@Storage class
 */		
var Storage = {
	_store: null,
	_getStore: function(){
		if( this._store ){
			return this._store;
		}
		/*创建store*/
		//localStorage
		if( !!window.localStorage  ){
			this._store = LocalStorage;
		}
		return this._store;
	},
	isAvailable: function(){
		return !!(this._getStore());
	},
	/**
		写入数据
		@static
		@param {string} key 
		@param {string} val 
	 */
	setItem: function( key, val ){
		var st = this._getStore();
		return st && st.setItem( key, val );
	},
	/**
		读取数据
		@static
		@param {string} key 
	 */
	getItem: function( key ){
		var st = this._getStore();
		return st && st.getItem( key );
	},
	/**
		删除数据
		@static
		@param {string} key 
	 */
	removeItem: function( key ){
		var st = this._getStore();
		return st && st.removeItem( key );
	},
	/**
		清空
		@static
	 */
	clear: function( ){
		var st = this._getStore();
		st && st.clear( );
	},
	/**
		监听某个key的变化
		@param {string} key 需要监听的key
		@param {string} callback 当数据发生变化时的回调（回调中传入的参数为当前key对应的值）
	 */
	onstorage: function( key, callback ){
		var st = this._getStore();
		st && st.onstorage( key, callback );
	},
	isStoreUseTimer: function(){
		return this._getStore().useTimer;
	},
	isStoreTriggerSelf: function(){
		return this._getStore().triggerSelf;
	},
	getStoreInterval: function(){
		return this._getStore().interval;
	}
};

(function ($) {

    function centerModal() {
        $(this).css('display', 'block');
        var $dialog  = $(this).find(".modal-dialog"),
            offset   = ($(window).height() - $dialog.height()) / 2

        $dialog.css("margin-top", offset - 15);
    }

    $.showLoading = function(action) {
        var $loadingModal = $('#loading-modal'),
            html

        if (!$loadingModal.length) {
            html =
                [
                    '<div class="modal fade" data-backdrop="static" data-keyboard="false" id="loading-modal" tabindex="-1">',
                    '<div class="modal-dialog">',
                    '<div class="modal-body">',
                    '<div class="front-loading">',
                    '<div class="front-loading-block"></div>',
                    '<div class="front-loading-block"></div>',
                    '<div class="front-loading-block"></div>',
                    '</div>',
                    '</div>',
                    '</div>',
                    '</div>'
                ].join("");

            $('body').append(html)

            $loadingModal = $('#loading-modal').on('show.bs.modal', centerModal);
        }

        if (action === "show") {
            $loadingModal.modal('show')
        }

        if (action === "reset") {
            $loadingModal.modal('hide')
        }
    }
})(jQuery);

;(function() {
    var $navLeft = $('#nav-left-offcanvas'), // 左侧栏
        $document = $(document), // 文档缓存
        $body = $('body'), // body缓存
        initAddUpHeight = $navLeft.length != 0 ?
                $navLeft.height() + $navLeft.offset().top + 40 - $document.height() : 0 // 初始左侧栏高度，计算防止初始高度就不够

    // 产品导航
    $('[data-gen="nav-pro"]').each(function () {
        var $cur = $(this),
            $target = $($cur.data('target')),
            proCode = $target.data('pro')

        // 生成内容
        $target.addClass('bottom nav-popover nav-popover-media nav-pro').html(
            [
                '<div class="arrow"></div>',
                '<ul>',
                '<li', proCode == 1 ? ' class="nav-cur-pro"' : '',
                '><a href="', AppUrl.free4lab,'" target="_blank"><img src="',
                AppUrl.newfront, 'img/1自邮之翼.png" alt="freewings"/></a></li>',
                '<li', proCode == 2 ? ' class="nav-cur-pro"' : '',
                '><a href="', AppUrl.about,'" target="_blank"><img src="', AppUrl.newfront, 'img/2项目.png" alt="about"/></a></li>',
                '<li', proCode == 3 ? ' class="nav-cur-pro"' : '',
                '><a href="', AppUrl.iaas, '" target="_blank"><img src="', AppUrl.newfront, 'img/3云海IaaS.png" alt="iaas"/></a></li>',
                '<li', proCode == 4 ? ' class="nav-cur-pro"' : '',
                '><a href="', AppUrl.paas, '" target="_blank"><img src="', AppUrl.newfront, 'img/4云海PaaS.png" alt="paas"/></a></li>',
                '<li', proCode == 5 ? ' class="nav-cur-pro"' : '',
                '><a href="', AppUrl.freeshare, '" target="_blank"><img src="', AppUrl.newfront, 'img/5Free分享.png" alt="freeshare"/></a></li>',
                '<li', proCode == 6 ? ' class="nav-cur-pro"' : '',
                '><a href="', AppUrl.freeproject, '" target="_blank"><img src="', AppUrl.newfront, 'img/6轻项目.png" alt="column"/></a></li>',
                '</ul>'
            ].join("")
        )
    })

    // 弹出菜单
    $('[data-toggle="front-popover-bottom"]').each(function() {
        var $cur = $(this),
            $target = $($cur.data('target'))

        // 点击事件
        $cur.click(function(e) {
            e.stopPropagation() // 否则全局收回

            if (!$target.hasClass('in')) {

                $cur.addClass('front-open')

                clearPopover() // 收回其他打开的popover

                $cur.trigger('show.fr.popover') // 显示之前的事件
                $target.fadeIn({queue:false, duration:'fast'}).animate({top:60}, 200).addClass('in')
            } else {
                $target.fadeOut({queue:false, duration:'fast'}).animate({top:50}, 200).removeClass('in')
                $cur.removeClass('front-open')
            }
        })
    })

    function clearPopover() {
        $('[data-toggle="front-popover-bottom"]').each(function () {
            var $cur = $(this),
                $target = $($cur.data('target'))

            // 没显示直接返回
            if (!$target.hasClass('in')) {
                return;
            }

            $cur.removeClass('front-open')

            // 显示则隐藏
            $target.fadeOut({queue:false, duration:'fast'}).animate({top:50}, 200).removeClass('in')
        })
    }

    // 弹出菜单在别处点击，收回
    $document.on('click.fr.popover', function (e) {
        clearPopover(e)
    })

    // 左侧导航栏子菜单触发
    $('[data-toggle="front-nav-left-sub"]').each(function () {
        var $cur = $(this),
            $target = $($cur.data('target')),
            icon = $cur.children('span.glyphicon'),
            addUpHeight = 0 // 页面高度调整增量

        $cur.click(function (event) {
            event.preventDefault()

            if (!$target.hasClass('open')) {
                $target.slideDown(200, function () {
                    $target.addClass('open')
                    icon.removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up')

                    addUpHeight = $navLeft.height() + $navLeft.offset().top + 40 - $document.height()

                    if (addUpHeight > 0) { // 调整高度
                        $body.height($body.height() + addUpHeight)
                    }
                })
            } else {
                $target.slideUp(200, function () {
                    $target.removeClass('open')
                    icon.removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down')

                    if (addUpHeight > 0) { // 恢复高度
                        $body.height($body.height() - addUpHeight)
                        addUpHeight = 0
                    }
                })
            }
        })
    })

    // 左侧导航栏图片加载
    var $sideBarToggle = $('#front-nav-toggle-left').attr('src', AppUrl.newfront + 'img/sidebar-toggle.png')

    if ($sideBarToggle.length) {
        // 左侧导航栏触发
        $sideBarToggle.click(sidebarToggle)

        // 左侧导航栏中的点击事件停止冒泡
        $navLeft.on('click', function (e) {
            e.stopPropagation()
        })

        // 触发后点击其他地方收回
        if ($sideBarToggle.css('display') == 'block') { // 移动端
            $document.on('click.fr.sidebar', function () {
                var $canvas = $('#front-canvas')

                if ($canvas.hasClass('open')) {
                    $canvas.removeClass('open')
                    $navLeft.removeClass('open')

                    if (initAddUpHeight > 0) { // 恢复高度
                        $body.height($body.height() - initAddUpHeight)
                    }

                    $sideBarToggle.css('display',"");
                }
            })
        }
    }

    function sidebarToggle(e) {
        var $cur = $(this),
            $canvas = $('#front-canvas')

        e.stopPropagation() // 防止左侧栏收回

        if (!$canvas.hasClass('open')) {
            $canvas.addClass('open')
            $navLeft.addClass('open')

            if (initAddUpHeight > 0) { // 调整高度
                $body.height($body.height() + initAddUpHeight)
            }

            $sideBarToggle.css('display', 'none')
        }
    }

    // FIX IOS Safari 点击别处左侧栏不能收回的问题
    // The trick
    // http://stackoverflow.com/questions/10165141/jquery-on-and-delegate-doesnt-work-on-ipad
    if (/ip(hone|od)|ipad/i.test(navigator.userAgent)) {
        $("body").css ("cursor", "pointer");
    }
})();
/*
 * created by cz
 * */
+function($){
	'use strict'

	var category = '.category';
	var categoryItem = '.categoryMain';
	var categoryMenu = '.categoryMenu';
	var menus = '.menus';


	var Category = function(){
		$(categoryItem).on('mouseover.bs.category',this.open);
		$(categoryMenu).on('mouseleave.bs.category',this.close);
	}

	Category.prototype.open = function(e){
		var $this = $(this);

		if($(menus).hasClass('hidden')){
			$(menus).removeClass('hidden');
		}

		$(categoryMenu+$this.data("menu"))
		.removeClass("hidden")
		.siblings().addClass("hidden");

		if(document.documentElement.clientWidth<768){
			$(".as-carousel").css("marginTop","-247px")
		}

	};

	Category.prototype.close = function(){
		if(!$(menus).hasClass("hidden")){
			$(menus).addClass("hidden");
		}
		$(".as-carousel").css("marginTop","0")
	}

	// CATRGORY PLUGIN DEFINITION
  // ==========================

  function Plugin(option) {
    return this.each(function () {
      var $this = $(this)
      var data  = $this.data('bs.category')

      if (!data) $this.data('bs.category', (data = new Category(this)))
      if (typeof option == 'string') data[option].call($this)
    })
  }


  $.fn.category             = Plugin;
  $.fn.category.Constructor = Category;

  $( document )
  	.on('mouseover.bs.category', categoryItem, Category.prototype.open )
  	.on('mouseleave.bs.category', category, Category.prototype.close)

}(jQuery);
/**
 * Created by cz on 2015/12/8.
 */
$(document).ready(function () {
  // Cache the Window object
  $window = $(window);

  $('section[data-title="pic"]').each(function () {
    var $bgobj = $(this); // assigning the object

    $(window).scroll(function () {

      // Scroll the background at var speed
      // the yPos is a negative value because we're scrolling it UP!

      var yPos = -($window.scrollTop() / $bgobj.attr('data-speed')) + $window.scrollTop();
      if ($bgobj.data('height')) {
        yPos -= $bgobj.data('height');
      }
      // Put together our final background position
      var coords = '50% ' + yPos + 'px';

      // Move the background
      $bgobj.css({
        backgroundPosition: coords
      });
    }); // window scroll Ends
  });
});


;(function () {
    // bootstrap modal 封装
    function createModal(size, title, href) {
    	var template;
    	var $this = $(this);
        size = (size != undefined ? size : '');
        template = [
                        '<div class="modal fade" id="front-modal" tabindex="-1" role="dialog" aria-labelledby="front-modal-label">',
                        '<div class="modal-dialog ', size ,'" role="document">',
                        '<div class="modal-content">',
                        '</div>',
                        '</div>',
                        '</div>'
                    ].join("");
        var titleFlag = (title != undefined && title.trim() != ''),
            $modal = $(template),
            $modalContent = $modal.find('.modal-content')

        if (titleFlag) {
            $modalContent.html(
                ['<div class="modal-header">',
                '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>',
                '<h4 class="modal-title" aria-label="front-modal-label">', title, '</h4>', // modal title
                '</div>'].join('')
            )
        }

        $.get(href, function(data) { // get modal content from server

            if (titleFlag) {
                $(data).insertAfter($modal.find('.modal-header'))
            } else {
                $modalContent.html(data)
            }

            // show modal
            $modal.modal()

            // Actually I mean to on show.bs.modal event
            // but it doesn't trigger
            $modal.on('shown.bs.modal', function () {
                $this.trigger('shown.fr.modal', $modal) // btn trigger shown.fr.modal event
            })
        })

        $modal.on('hidden.bs.modal', function () { // when the modal close remove it
            $modal.remove()
        })

        return $modal;
    }
   
    // modal api
    $('body').on('click', 'a[data-toggle="front-modal"]', function (e) {
        e.preventDefault();
        createModal.call(this, $(this).data('size'), $(this).data('title'), $(this).data('href'));
    });

    // jquery common
    $.frontModal = function (option) {
        var preSetParams = {
            size: '',
            title: '',
            href: ''
        };

        var params = $.extend(preSetParams, option);

        return createModal(params.size, params.title, params.href);
    };
})();

/**
 * function: slient model
 * autor: songpengwei
 * mail: songpengwei40@gamil.com
 * last modify date: 2014/9/18
 */
;(function($){
	$.slientModel = function(){};
	$.extend($.slientModel,{
		isExist:false,
		//配置
		settings:{
			opacity		: 0.95,
			contentWidth: 960,
			closeImage	: 'css/images/b_closelabel.png',
			slientTitle	: '现在进入到静阅模式。',
			slientHtml	: '现在进入到静阅模式。',
			layerHtml	: [
			    '<div id="slientModel" style="display:none;">',
            '<a href="javascript:void(0)" class="layerclose"><img src="#" border="0" /></a>',
            '<div class="slientBox">',
              '<div class="body">',
                '<div class="layertitle"></div>',
                '<div class="layercontent"></div>',
              '</div>',
            '</div>',
			    '</div>'].join(''),
			 layerCss	:{
				 'position'		: 'absolute',
				 'left'			: '0px',
				 'top'			: '0px',
				 'width'		: '100%',
			     'height'		: '100%',
			     'padding'		: '40px 0',
				 'zIndex'		: '9999'
			 },
			 boxCss		:{
				 'margin'		: '0 auto',
				 'width'		: '960px',
				 'box-sizing'	: 'border-box',
				 'background'	: '#fff',
				 'padding'		: '1px',
				 'box-shadow'	: '0 1px 3px rgba(34,25,25,.4)',
			 },
			 bodyCss	:{
				 'margin'		: '20px 40px'
			 },
			 titleCss	:{
				 'height'		: '30px',
				 'margin-bottom': '20px',
				 'font-size'	: '2em',
				 'text-align'	: 'center'
			 },
			 closeImgCss:{
				 'position'		: 'fixed',
				 'top'			: '0px',
				 'right'		: '0px'
			 },
			 overlayCss	:{
				 'position'		: 'fixed',
				 'top'			: '0',
				 'left'			: '0',
				 'background'	: '#E5E5E5',
				 'height'		: '100%',
				 'width'		: '100%',
				 'opacity'		: '0.9',
				 'zIndex'		: '2000'
			 }
		},
		
		loadSettings:function(settings){
			$("#slientModel").css(settings.layerCss);
			$("#slientModel a.layerclose>img").css(settings.closeImgCss);
			$("#slientModel .slientBox").css(settings.boxCss);
			$("#slientModel .slientBox .body").css(settings.bodyCss);
			$("#slientModel .slientBox .layertitle").css(settings.titleCss);
			
			$("#slientModel a.layerclose>img").attr("src", settings.closeImage);
			$("#slientModel .slientBox").css("width", "100%");
			$("#slientModel .slientBox .layertitle").html(settings.slientTitle);
			$("#slientModel .slientBox .layercontent").html(settings.slientHtml);
			$("#slientModel .slientBox img").css("max-width", "100%");
			
			$("#slientModel").show();
		},
		
		close:function(){
			$("#slientModel .slientBox .layercontent").empty();
			$("#slientModel").hide();
		},
		
		showOverlay:function(settings) {
		    if ($('#slientmode_overlay').length == 0){
		    	$("body").append('<div id="slientmode_overlay"></div>');
		    }
		    $('#slientmode_overlay').hide()
		    						.css(settings.overlayCss)
		    						.css('opacity', settings.opacity)
		    						.fadeIn(200);
		    return true;
		},
		
		hideOverlay:function() {
			$('#slientmode_overlay').fadeOut(200);
		}
		
	});
	
	$.fn.slientModel = function(settings, callback){
		
		
		init(settings);
		return this;
		
		//私有函数
		//根据setting初始化框架
		function init(settings){
			
			//加载配置
			if(settings)
				$.extend(true, $.slientModel.settings, settings);
			var docHeight = $(document).height();
			$.extend(true, $.slientModel.settings, {layerCss:{'height':docHeight}});
			//console.log("docHeight="+docHeight);
			//console.log("$.slientModel.settings="+$.slientModel.settings.layerCss.height);
			
			//加载html框架
			if($.slientModel.isExist == false){
				$.slientModel.isExist = true;
				$('body').append($.slientModel.settings.layerHtml);
			}
				
			//装载配置并显示
			$.slientModel.loadSettings($.slientModel.settings);
			$.slientModel.showOverlay($.slientModel.settings);
			
			//绑定关闭事件
			$('#slientModel .layerclose').click(close);
			$(document).keydown(function(event){
		        if (event.keyCode == 27){
		        	close();
		        }
		    });
		}
		
		//关闭
		function close(){
			$.slientModel.close();
			$.slientModel.hideOverlay();
		}
	}
})(jQuery);
/**
 * jQuery TAH Plugin
 * Using for Textarea-Auto-Height
 * @Version: 0.4
 * @Update: December 13, 2011
 * @Author: Phoetry (http://phoetry.me)
 * @Url: http://phoetry.me/archives/tah.html
 **/
~function($){
    $.fn.tahReady=function(opt){
        opt=$.extend({
            moreSpace:25,
            maxHeight:600,
            animateDur:200
        },opt);
        return this.each(function(i,t){
            if(!$.nodeName(t,'textarea'))return;
            var ta=$(t).css({resize:'none',overflowY:'hidden'}),
                _ta=ta.clone().attr({id:'',name:'',tabIndex:-1}).css(function(css){
                    $.each('width0fontSize0fontFamily0lineHeight0wordWrap0wordBreak0whiteSpace0letterSpacing'.split(0),function(i,t){css[t]=ta.css(t)});
                    return $.extend(css,{
                        width:ta.width()*1.5,
                        position:'absolute',
                        left:-9e5,
                        height:0
                    });
                }({})),
                valCur,stCur,stCache,defHeight=ta.outerHeight(),
                autoHeight=function(){
                    (stCur=Math.max(defHeight,_ta.val(valCur=ta.val()).scrollTop(9e5).scrollTop() + 12)+(valCur&&opt.moreSpace))==stCache?0:
                        (stCache=stCur)<opt.maxHeight?ta.stop().animate({height:stCur},opt.animateDur):ta.css('overflowY','auto');
                };
            ta.after(_ta).bind('blur focus input change propertychange keydown',autoHeight);
        });
    };

    //输入框智能拉伸插件的引用
    $.fn.tah = function(opt, type){
        if( type == undefined ){
            type = "id";
        }

        var typeValue = $(this).attr(type);

        $("[" + type + "=" + typeValue + "]").tahReady(opt);
    };
}(jQuery);
;(function($){
    jQuery.fillTipBox = function(option) {
        var defaults = {
                type: '',
                icon: '',
                content: '',
                delay: 1500 //自动关闭的时间设置
            },
            option = $.extend(defaults, option),
            $tipBox

        $('#front-tipbox').remove() // 先删除

        // 再添加TipBox
        $('body').append($tipBox =
                $([
                    '<div id="front-tipbox" class="front-tipbox ', option.type ,'">',
                    '<div class="title">',
                    '<span class="glyphicon glyphicon-remove front-tipbox-close"></span>',
                    '</div>',
                    '<div class="content"><span class="glyphicon ',
                    option.icon, '"></span>', option.content, '</div>',
                    '</div>'
                ].join(""))
        )

        $tipBox.fadeIn({queue:false, duration:'fast'}).animate({top:70}, 200).addClass('in')

        // 关闭事件
        $tipBox.find('.front-tipbox-close').on('click', function () {
            close($tipBox)
        })

        // 自动关闭
        window.setTimeout(close, option.delay, $tipBox);
    }

    function close(ele) {
        ele.fadeOut({queue:false, duration:'fast'}).animate({top:50}, 200).removeClass('in')
    }
})(jQuery);


;(function($) {
    bootbox.setLocale('zh_CN')

    jQuery.tipModal = function (type, iconType, content, callback) {
        var iconClass,
            modalContent

        if (iconType == 'warning') {
            iconClass = 'glyphicon-exclamation-sign front-tipmodal warning'
        } else if (iconType == 'danger') {
            iconClass = 'glyphicon-alert front-tipmodal danger'
        } else if (iconType == 'success') {
            iconClass = 'glyphicon-ok-sign front-tipmodal success'
        } else if (iconType == 'info') {
            iconClass = 'glyphicon-info-sign front-tipmodal info'
        }

        modalContent = '<span class="glyphicon ' + iconClass + '"></span>' + content

        if (type == 'alert') {
            bootbox.alert({
                size : 'small',
                message : modalContent,
                callback : callback
            })
        } else if (type == 'confirm') {
            bootbox.confirm({
                size : 'small',
                message : modalContent,
                callback : callback
            })
        }
    }
})(jQuery);
