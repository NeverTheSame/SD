package fun.kirill;

import org.json.JSONObject;

import javax.net.ssl.SSLHandshakeException;
import java.io.IOException;
import java.net.ConnectException;
import java.security.GeneralSecurityException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.Map;

import static fun.kirill.ParseJSON.getCleanJsonObject;

/**
 * The type Driver.
 * @author Kirill Kuklin
 * @version 2020-12-29
 */
public final class Driver {

    private Driver() {
    }

    /**
     * Main method.
     *
     * @param args the args
     * @throws NoSuchAlgorithmException the no such algorithm exception
     * @throws IllegalArgumentException the illegal argument exception
     * @throws ConnectException         the connect exception
     */
    public static void main(final String[] args)
            throws NoSuchAlgorithmException,
            IOException, CertificateException, GeneralSecurityException {
        if (args.length == 0) {
            throw new IllegalArgumentException("No arguments passed");
        }
        String url;
        final String bearerAuthToken = args[0];
        final String serverName = args[1];
        JSONObject jsonObject = null;
        if (args.length == 4) {
            final String environmentUUID = args[2];
            final String machineName = args[3];
            url = CustomURL.composeURL(serverName, environmentUUID, machineName);
            jsonObject = getCleanJsonObject(bearerAuthToken, url);
        } else {
             RestAPI.turnOffCertificateValidation();
            final String port = args[2];
            final String version = args[3];
            final String endpoint = args[4];
            url = CustomURL.composeURL(serverName, port, version, endpoint);
            RestAPI.probeConnection(serverName, port);
        }
        jsonObject = getCleanJsonObject(bearerAuthToken, url);
        Map<String, Object> jsonObjectMap = ParseJSON.jsonToMap(jsonObject);
        ParseJSON.printMapObjects(jsonObjectMap);
    }
}
