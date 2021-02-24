$webUrl = "https://foo.sharepoint.com/sites/bulletins/"
$relativePageUrl = "/sites/bulletins/Shared Documents/Forms/SharedWithUs.aspx"

Connect-PnPOnline $webUrl -UseWebLogin
$webParts = Get-PnPWebPart -ServerRelativePageUrl $relativePageUrl
foreach ($webPart in $webParts)
{
       if ($webPart.WebPart.ExportMode -ne [Microsoft.SharePoint.Client.WebParts.WebPartExportMode]::None) {continue}
       $webPart.WebPart.ExportMode = [Microsoft.SharePoint.Client.WebParts.WebPartExportMode]::All
       $webPart.SaveWebPartChanges()
       $webPart.Context.ExecuteQuery()
}

$updatedWebParts = Get-PnPWebPart -ServerRelativePageUrl $relativePageUrl
foreach ($updatedWebPart in $updatedWebParts)
{
    if ($updatedWebPart.WebPart.ExportMode -ne [Microsoft.SharePoint.Client.WebParts.WebPartExportMode]::None) {continue}
    Write-Host Web part export mode was not updated: $updatedWebPart.Id
}