package com.free4inno.hufu.developertools.model;

import lombok.Data;

@Data
public class ComponentOrderItem {
    private String type;
    private String divId;
    private int index;

    public ComponentOrderItem(String type, String divId, int index)
    {
        this.type = type;
        this.divId = divId;
        this.index = index;
    }
}
