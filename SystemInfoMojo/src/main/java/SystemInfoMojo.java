import org.apache.commons.lang3.SystemUtils;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugin.MojoFailureException;
import org.apache.maven.plugins.annotations.Mojo;

/**
 * SystemInfoPlugin that displays system information such as Java version,
 * operating system, and the like, on the console running Maven command.
 * This goal uses Maven Old Java Object (MOJO).
 * @author Kirill Kuklin
 * @version 2020-12-23
 */
@Mojo(name = "systeminfo")
public final class SystemInfoMojo extends AbstractMojo {
    @Override
    public void execute() throws MojoExecutionException, MojoFailureException {
        getLog().info("Java Home: " + SystemUtils.JAVA_HOME);
        getLog().info("Java Version: " + SystemUtils.JAVA_VERSION);
        getLog().info("OS Name: " + SystemUtils.OS_NAME);
        getLog().info("OS Version: " + SystemUtils.OS_VERSION);
        getLog().info("User Name: " + SystemUtils.USER_NAME);
    }
}
