package com.free4inno.serverlesswebide.dao;

import com.free4inno.serverlesswebide.entity.Workspace;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WorkspaceDao extends JpaRepository<Workspace, String> {
    Workspace findById(int id);
    List<Workspace> findAllByUserId(int userId);
    List<Workspace> findAllByUserIdAndIsActive(int userId, int isActive);
}
