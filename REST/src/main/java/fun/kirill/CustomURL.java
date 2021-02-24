package fun.kirill;

/**
 * The class that is constructing fun.kirill.CustomURL.
 *
 * @author Kirill Kuklin
 * @version 2020 -12-21
 */
public final class CustomURL {
    /**
     * The constant SECURED_PROTOCOL.
     */
    public static final String SECURED_PROTOCOL = "https";
    /**
     * The constant COLON.
     */
    public static final String COLON = ":";
    /**
     * The constant FORWARD_SLASH.
     */
    public static final String FORWARD_SLASH = "/";

    /**
     * The constant START_OF_QUERY_STRING.
     */
    public static final String START_OF_QUERY_STRING = "?";
    /**
     * The constant LIMIT.
     */
    public static final String LIMIT = "limit=";
    /**
     * The constant KEY_VALUE_SEPARATOR.
     */
    public static final String KEY_VALUE_SEPARATOR = "&";
    /**
     * The constant ROLE.
     */
    public static final String ROLE = "role=";
    /**
     * The constant MACHINE.
     */
    public static final String MACHINE = "machine=";
    /**
     * The constant PULSE.
     */
    public static final String PULSE = "pulse";
    /**
     * The constant DEFAULT_LIMIT.
     */
    public static final String DEFAULT_LIMIT = "1000";

    private CustomURL() {
    }

    /**
     * Compose url string.
     *
     * @param logsServiceURL  the logs service url
     * @param environmentUUID the environment uuid
     * @param machineName     the machine name
     * @return the string
     */
    public static String composeURL(final String logsServiceURL,
                                    final String environmentUUID,
                                    final String machineName) {
        return SECURED_PROTOCOL + COLON + FORWARD_SLASH + FORWARD_SLASH + logsServiceURL
                + environmentUUID + START_OF_QUERY_STRING + LIMIT + DEFAULT_LIMIT
                + KEY_VALUE_SEPARATOR + ROLE + PULSE + KEY_VALUE_SEPARATOR + MACHINE + machineName;
    }

    /**
     * Compose url string.
     *
     * @param serverName the server name
     * @param port       the port
     * @param version    the version
     * @param endpoint   the endpoint
     * @return the string
     */
    public static String composeURL(final String serverName, final String port,
                                    final String version, final String endpoint) {
        return SECURED_PROTOCOL + COLON + FORWARD_SLASH + FORWARD_SLASH + serverName
                + COLON + port + FORWARD_SLASH + version
                + FORWARD_SLASH + endpoint;
    }
}
