<#
.SYNOPSIS
    .
.DESCRIPTION
    .
.NOTES
    Author: Kirill Kuklin
    Date:   2020-12-16
#>

$webUrl = Read-Host "Enter web URL (e.g. https://tenant.sharepoint.com/sites/MySite)"
if ($null -eq $webUrl) {
    Write-Output "Empty site URL supplied, unable to continue."
    return
}
try {
    Connect-PnPOnline -Url $webUrl -Credentials (Get-Credential)
} catch {
    Write-Warning "Unable to connect. Check URL or credentials."
    return
}

$availableLists = (Get-PNPList).Title -join ', '
$listName = Read-Host "Enter list name (e.g. Documents). Available lists are: $availableLists"
if ($null -eq $listName) {
    Write-Warning "Empty list name supplied, unable to continue."
    return
}
if (!$availableLists.Contains($listName)) {
    Write-Warning "$listName list not found, unable to continue."
    return
}

$docName = Read-Host "Enter document name (e.g. Document.docx)"
if ($null -eq $docName) {
    Write-Warning "Empty document name supplied, unable to continue."
    return
}

if (!((Get-PnPListItem -List $listName).FieldValues).Values.Contains($docName)) {
    Write-Warning "$docName document not found, unable to continue."
    return
}

$file = (Get-PnPListItem -List $listName).FieldValues | Where-Object -Property "FileLeafRef" -eq "$docName"
$file