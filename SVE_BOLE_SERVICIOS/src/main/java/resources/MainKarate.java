package resources;

import com.google.gson.Gson;

public class MainKarate {

    public static String replaceAllKarate(String value) {
        String newkey = value.replaceAll("\n", "");

        Gson gson = new Gson();
        BodyEncryptedPassword bodyEncryptedPassword = new BodyEncryptedPassword(newkey);
        String JSON = gson.toJson(bodyEncryptedPassword);
        return JSON;
    }
}