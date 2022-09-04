package com.free4inno.serverlesswebide.service;

import com.free4inno.serverlesswebide.dao.FuncDao;
import com.free4inno.serverlesswebide.dao.UserDao;
import com.free4inno.serverlesswebide.entity.User;
import com.free4inno.serverlesswebide.utils.CodeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


@Slf4j
@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    @Autowired
    private FuncService fs;

    @Autowired
    private FuncDao funcDao;

    @Value("${oss.data.path}")
    private String ossDataPathTemplate;

    // user login by username and password
    public User login(String userName, String password) {
        User user = userDao.findByUsername(userName);
        if (user == null) {
            log.info("cannot find the user by this user name");
            return null;
        }
        if (user.getPassword().equals(password)) {
            log.info("success to login");
            return user;
        } else {
            return null;
        }
    }

    // add new user to system
    public User addUser(String userName, String password) {
        if (userDao.findByUsername(userName) != null) {
            log.warn("exist the same user name");
            return null;
        } else {
           User user = new User();
           // the detailed test of username and password should be assigned in web regex expression
           user.setUsername(userName);
           user.setPassword(password);
           String uniCode = CodeUtils.getRandomString(8);
           user.setCode(uniCode);
           user.setDataOssPath(String.format(ossDataPathTemplate, uniCode));
           userDao.saveAndFlush(user);
           log.info("success to create a user");
           return user;
        }
    }

//    public String applyForFunction(int userId) {
//        return fs.assignFuncForUser(userId);
//    }

}
