$pw = convertto-securestring -AsPlainText -Force -String "123"
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist ".\Administrator",$pw
$session = new-pssession -computername "123" -credential $cred