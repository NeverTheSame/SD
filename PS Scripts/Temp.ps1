$scriptDirectory = Split-Path -Parent $PSCommandPath
$scriptDirectory

$env:Path
$p = [Environment]::GetEnvironmentVariable('Path')
$p
Join-Path -Path $p -ChildPath 'GetLegacyAuthProtocols'

#$clientAssembly = [System.Reflection.Assembly]::LoadFile($scriptDirectory + "\Microsoft.SharePoint.Client.dll")
#$clientRuntimeAssembly = [System.Reflection.Assembly]::LoadFile($scriptDirectory + "\Microsoft.SharePoint.Client.Runtime.dll")
#$spoClientAssembly = [System.Reflection.Assembly]::LoadFile($scriptDirectory + "\Microsoft.Online.SharePoint.Client.Tenant.dll")