package com.free4inno.hufu.developertools.model;

import lombok.Data;

@Data
public class ServiceLabel {
    private String photoPath;
    private String link;
    public ServiceLabel(String path, String link){
        this.photoPath = path;
        this.link = link;
    }
}
