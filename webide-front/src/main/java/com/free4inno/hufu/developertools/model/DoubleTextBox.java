package com.free4inno.hufu.developertools.model;

import lombok.Data;

@Data
public class DoubleTextBox {
    private TextBox box1;
    private TextBox box2;
    public DoubleTextBox(TextBox box1, TextBox box2){
        this.box1 = box1;
        this.box2 = box2;
    }
}
