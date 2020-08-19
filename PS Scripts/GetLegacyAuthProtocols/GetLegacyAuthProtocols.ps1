param
(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)] 
    [string]$TenantAdminUrl,

    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)] 
    [PSCredential]$Credential
)

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Ssl3 -bor [System.Net.SecurityProtocolType]::Tls -bor [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12

$scriptDirectory = Split-Path -Parent $PSCommandPath

$clientAssembly = [System.Reflection.Assembly]::LoadFile($scriptDirectory + "\Microsoft.SharePoint.Client.dll")
$clientRuntimeAssembly = [System.Reflection.Assembly]::LoadFile($scriptDirectory + "\Microsoft.SharePoint.Client.Runtime.dll")
$spoClientAssembly = [System.Reflection.Assembly]::LoadFile($scriptDirectory + "\Microsoft.Online.SharePoint.Client.Tenant.dll")

$assemblies = @($clientAssembly.FullName, $clientRuntimeAssembly.FullName, $spoClientAssembly.FullName)

Add-Type -Language CSharp -ReferencedAssemblies $assemblies -TypeDefinition @"
using System; 
using System.Collections.Generic;
using Microsoft.Online.SharePoint.TenantAdministration;

public static class SharePointTenantLoader
{
    public static bool LoadLegacyAuthValue(Tenant tenant)
    {
        tenant.Context.Load(tenant, t => t.LegacyAuthProtocolsEnabled);
        tenant.Context.ExecuteQuery();
        return tenant.LegacyAuthProtocolsEnabled;
    }
}
"@ 

$clientContext = New-Object Microsoft.SharePoint.Client.ClientContext($TenantAdminUrl)
try 
{
    $clientContext.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Credential.UserName, $Credential.Password)
    $tenant = New-Object Microsoft.Online.SharePoint.TenantAdministration.Tenant($clientContext)
    
    $legacyAuth = [SharePointTenantLoader]::LoadLegacyAuthValue($tenant)

    Write-Host "Legacy authentication protocols enabled: $($legacyAuth)"
    
}
finally 
{
    $clientContext.Dispose()
}