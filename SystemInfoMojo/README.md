# System information plugin
SystemInfoPlugin that displays system information such as Java version, operating system, and the like, 
on the console running Maven command.
This goal uses Maven Old Java Object (MOJO).

## Examples:
### Maven install Command
```java
mvn install 
```

### Running the SystemInfoMojo Plug-in
The syntax to run any goal is mvn pluginId:goal-name.

```java
mvn fun.kirill.plugins:sysinfo-maven-plugin:systeminfo
```

