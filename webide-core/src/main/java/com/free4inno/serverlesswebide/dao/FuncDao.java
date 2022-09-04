package com.free4inno.serverlesswebide.dao;

import com.free4inno.serverlesswebide.entity.Func;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FuncDao extends JpaRepository<Func, String> {
    Func findById(int id);
    Func findByName(String name);
    List<Func> findByIsAvailable(int isAvailable);
    Func findByWorkspaceId(int id);
}
