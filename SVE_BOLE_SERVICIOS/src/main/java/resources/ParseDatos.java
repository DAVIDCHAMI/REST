package resources;


import net.minidev.json.JSONArray;

public class ParseDatos {

    public static String devolverContrasena(String encriptada) {
        return encriptada.replaceAll("\n", "");
    }

    public static String devolverSALT(JSONArray entrada) {
        final String[] salt = {""};
        JSONArray json = entrada;
        json.stream().forEach(s -> {
            if (s.toString().contains("SALT")) {
                salt[0] = s.toString().replace("{name=SALT, value=", "").replace("}", "");
            }
        });
        return salt[0];
    }
}
