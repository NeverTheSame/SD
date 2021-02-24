param
(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [string]$AdminCenterURL,

    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [string]$PersonalSiteURL
)
#Connect to SharePoint Online
Connect-SPOService -url $AdminCenterURL -Credential (Get-Credential)

#sharepoint online powershell get site owner
Get-SPOSite $SiteURL | Select-Object Owner