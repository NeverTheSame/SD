# Enter-PSSession 172.16.224.195
# Invoke-Command get-service -ComputerName 172.16.224.195

#New-PSSession -ComputerName 172.16.224.195 -Credential .\administrator -Password 642362kkK!

$pw = convertto-securestring -AsPlainText -Force -String 642362kkK!
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist ".\Administrator",$pw
$session = new-pssession -computername 172.16.224.195 -credential $cred
# Invoke-Command -Session $s -ScriptBlock {Get-Culture}