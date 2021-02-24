param
(   
         
    [Parameter(Mandatory = $true)] 
    [string]$TenantId,

    [Parameter(Mandatory = $true)] 
    [System.Uri]$HostUrl,
         
    [Parameter(Mandatory = $true)] 
    [string]$SiteId,
         
    [Parameter(Mandatory = $true)] 
    [guid]$WebId,
         
    [Parameter(Mandatory = $true)] 
    [guid]$ListId,
         
    [Parameter(Mandatory = $true)] 
    [guid]$UniqueId,    
         
    [Parameter(Mandatory = $true)] 
    [string]$OutFile
)


if (Get-Module -ListAvailable Microsoft.Graph*)
{
    Import-Module -Name Microsoft.Graph.Authentication, Microsoft.Graph.Sites
}
else
{
    Write-Host "Installing Microsoft Graph PowerShell SDK..."
    Install-Module -Name Microsoft.Graph -Force -SkipPublisherCheck
    Import-Module -Name Microsoft.Graph.Authentication, Microsoft.Graph.Sites
}

Connect-MgGraph -Scopes "Sites.FullControl.All" -TenantId $TenantId -ForceRefresh

Get-MgSiteListItemDriveItemContent -ListId $ListId -ListItemId $UniqueId -SiteId "$($HostUrl.DnsSafeHost),$SiteId,$WebId" -OutFile $OutFile

Disconnect-MgGraph