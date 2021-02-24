package fun.kirill.plugins;

import org.apache.commons.lang3.SystemUtils;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugin.MojoFailureException;
import org.apache.maven.plugins.annotations.Mojo;


@Mojo(name = "systeminfo")
public class SystemInfoMojo extends AbstractMojo {

    @Override
    public void execute() throws MojoExecutionException, MojoFailureException {
        getLog().info("Java home: " + SystemUtils.JAVA_HOME);
        getLog().info("Java version: " + SystemUtils.JAVA_VERSION);
        getLog().info("OS name: " + SystemUtils.OS_NAME);
        getLog().info("OS version: " + SystemUtils.OS_VERSION);
        getLog().info("User name: " + SystemUtils.USER_NAME);
    }
}
