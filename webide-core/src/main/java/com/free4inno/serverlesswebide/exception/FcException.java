package com.free4inno.serverlesswebide.exception;

public class FcException extends Exception {

    private String message;

    public FcException(String message){
        super(message);
    }
}
