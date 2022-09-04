package com.free4inno.serverlesswebide.dao;

import com.free4inno.serverlesswebide.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserDao extends JpaRepository<User, String> {
    User findById(int id);
    User findByUsername(String userName);
}
