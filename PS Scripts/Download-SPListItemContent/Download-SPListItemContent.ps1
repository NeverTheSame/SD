<#
Usage:
Download-SPListItemContent.ps1 [-HostUrl] <uri> [-SiteId] <string> [-WebId] <guid> [-ListId] <guid> [-UniqueId] <guid> [-OutFile] <string> [<CommonParameters>]

Examle
HostUrl: foo-my.sharepoint.com
SiteId: 01abefaa-6cdc-4612-b0b3-a70bf49b4ede
WebId: 839566c1-dcd4-4863-8e3c-cf6b69d55ed1
ListId: 13125bf8-32f2-48ce-976d-c57c32e9c7d6
UniqueId: 9277655C-4AFD-46AE-AA0F-E9B3EF2EFA93

22-10-2020 18:29:28   67 (3572) Processing https://foo-my.sharepoint.com/personal/hjac_ewii_com OneDrive items
# (ID: 13125bf8-32f2-48ce-976d-c57c32e9c7d6, site ID: 01abefaa-6cdc-4612-b0b3-a70bf49b4ede,
# web ID: 839566c1-dcd4-4863-8e3c-cf6b69d55ed1)...
...
22-10-2020 18:29:45   67 (3572)   Downloading item content:
# /personal/bar_com/Documents/bar @ bar/bar bar.one (length: 2481828021, position: 0,
# ETag: "{9277655C-4AFD-46AE-AA0F-E9B3EF2EFA93},1754")...
#>

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