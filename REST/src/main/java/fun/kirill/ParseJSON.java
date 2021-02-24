package fun.kirill;

import fun.kirill.simpleRestClient.SimpleRestClient;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.net.ssl.SSLHandshakeException;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.cert.CertificateException;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;


/**
 * Class for fetching fun.kirill.RestAPI resource via SimpleRestClient class
 * (https://github.com/devcon5io/simple-rest-client)
 * and transforming it to the data structure using JSONObject class.
 *
 * @author Kirill Kuklin
 * @version 2020 -12-16
 */
public final class ParseJSON {

    private ParseJSON() {
    }

    /**
     * Gets json object.
     *
     * @param bearerAuthToken the bearer auth token
     * @param url             the url
     * @return the json object
     * @throws IllegalArgumentException if Bearer token is empty
     */
    public static JSONObject getCleanJsonObject(final String bearerAuthToken,
                                                final String url) throws IOException, GeneralSecurityException, CertificateException {
        if (bearerAuthToken.length() == 0) {
            throw new IllegalArgumentException("Bearer authentication token is empty");
        }
        SimpleRestClient.Response response = null;
        response = RestAPI.getResponse(bearerAuthToken, url);

        String jsonStringRaw;
        try {
            jsonStringRaw = response.asString();
            if (response.getStatusCode() == -1) {
                throw new SSLHandshakeException("Response code was -1");
            }
        } catch (SSLHandshakeException e) {
            throw (SSLHandshakeException) new SSLHandshakeException(
                    "Could not generate secret").initCause(e);
        }

        String jsonStringWithNoCurlyBrackets =
                jsonStringRaw.substring(1, jsonStringRaw.length() - 1);
        return new JSONObject(jsonStringWithNoCurlyBrackets);
    }

    /**
     * Prints map objects.
     *
     * @param jsonObjectMap the json object map
     */
    public static void printMapObjects(final Map<String, Object> jsonObjectMap) {
        for (Map.Entry<String, Object> entry: jsonObjectMap.entrySet()) {
            String k = entry.getKey();
            Object v = entry.getValue();
            if (v.getClass().getSimpleName().equals("ArrayList")) {
                System.out.println("Array of " + k + ", Value: ");
                List<?> list = new ArrayList<>((Collection<?>) v);
                for (Object itemInList: list) {
                    System.out.println(itemInList);
                }
                System.out.println("");
            } else {
                System.out.println("Key: " + k + ", Value: " + v + "\n");
            }
        }
    }

    /**
     * Json to map map.
     *
     * @param json the json
     * @return the map
     * @throws JSONException the json exception
     * @throws IllegalArgumentException if the json object passed is null
     */
    public static Map<String, Object> jsonToMap(final JSONObject json) throws JSONException {
        if (json == JSONObject.NULL) {
            throw new IllegalArgumentException("JSON object cannot be null!");
        }
        Map<String, Object> retMap;
        retMap = toMap(json);
        return retMap;
    }

    private static Map<String, Object> toMap(final JSONObject object) throws JSONException {
        Map<String, Object> map = new HashMap<>();
        Iterator<String> keysItr = object.keys();
        while (keysItr.hasNext()) {
            String key = keysItr.next();
            Object value = object.get(key);

            if (value instanceof JSONArray) {
                value = toList((JSONArray) value);
            } else if (value instanceof JSONObject) {
                value = toMap((JSONObject) value);
            }
            map.put(key, value);
        }
        return map;
    }

    private static List<Object> toList(final JSONArray array) throws JSONException {
        List<Object> list = new ArrayList<>();
        for (int i = 0; i < array.length(); i++) {
            Object value = array.get(i);
            if (value instanceof JSONArray) {
                value = toList((JSONArray) value);
            } else if (value instanceof JSONObject) {
                value = toMap((JSONObject) value);
            }
            list.add(value);
        }
        return list;
    }
}
