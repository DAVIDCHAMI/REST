package com.todo1.certificacion.sve.main;


import com.google.gson.Gson;

public class mainKarate {

    public static String replaceAllKarate(String value) {
        String newkey = value.replaceAll("\n", "");
        Gson gson = new Gson();
        BodyEncryptedPassword bodyEncryptedPassword = new BodyEncryptedPassword(newkey);
        String JSON = gson.toJson(bodyEncryptedPassword);
        return JSON;
    }
}
