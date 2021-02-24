package fun.kirill;

import fun.kirill.simpleRestClient.SimpleRestClient;

import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.TrustManager;
import javax.net.ssl.SSLContext;
import javax.net.ssl.X509TrustManager;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLSession;

import java.io.IOException;

import java.net.URI;
import java.net.URISyntaxException;
import java.net.Socket;
import java.net.ConnectException;
import java.net.UnknownHostException;

import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;


/**
 * Class for establishing connection and fetching data over RestAPI.
 *
 * @author Kirill Kuklin
 * @version 2020 -12-21
 */
public final class RestAPI {
    private RestAPI() {
    }
    // TODO
    private static void requestHTTP() throws URISyntaxException {
        URI uri = new URIBuilder()
                .setScheme("http")
                .setHost("www.google.com")
                .setPath("/search")
                .setParameter("q", "httpclient")
                .setParameter("btnG", "Google Search")
                .setParameter("aq", "f")
                .setParameter("oq", "")
                .build();
        HttpGet httpget = new HttpGet(uri);
        System.out.println(httpget.getURI());
    }

    /**
     * Gets response (GET method).
     *
     * @param url             the url
     * @return the response
     */
    public static SimpleRestClient.Response getResponseBasicAuth(final String username,
                                                                 final String password,
                                                                 final String url) {
        return SimpleRestClient.requestTo(url)
                .basicAuth(username, password)
                .acceptJson() //accept header
                .get();
    }

    /**
     * Gets response (GET method).
     *
     * @param bearerAuthToken the bearer auth token
     * @param url             the url
     * @return the response
     */
    public static SimpleRestClient.Response getResponse(final String bearerAuthToken,
                                                        final String url) {
        return SimpleRestClient.requestTo(url)
                .auth(bearerAuthToken)
                .acceptJson() //accept header
                .get();
    }

    /**
     * Turn off certificate validation.
     *
     * @throws NoSuchAlgorithmException the no such algorithm exception
     * @throws KeyManagementException   the key management exception
     */
    public static void turnOffCertificateValidation()
            throws NoSuchAlgorithmException, KeyManagementException {
        TrustManager[] trustAllCerts = new TrustManager[] {new X509TrustManager() {
            public X509Certificate[] getAcceptedIssuers() {
                return null;
            }
            public void checkClientTrusted(final X509Certificate[] certs, final String authType) {
            }
            public void checkServerTrusted(final X509Certificate[] certs, final String authType) {
            }
        }
        };

        // Install the all-trusting trust manager
        SSLContext sc = SSLContext.getInstance("SSL");
        sc.init(null, trustAllCerts, new java.security.SecureRandom());
        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

        // Create all-trusting host name verifier
        HostnameVerifier allHostsValid = new HostnameVerifier() {
            public boolean verify(final String hostname, final SSLSession session) {
                return true;
            }
        };

        // Install the all-trusting host verifier
        HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
    }

    /**
     * Probe connection.
     *
     * @param serverName the server name
     * @param port       the port
     * @throws ConnectException the connect exception
     */
    protected static void probeConnection(final String serverName, final String port)
            throws ConnectException {
        try {
            new Socket(serverName, Integer.parseInt(port));
        } catch (ConnectException | UnknownHostException m) {
            throw new ConnectException("Server returned 401 Unauthorized");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
