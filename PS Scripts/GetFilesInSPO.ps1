<#
    .SYNOPSIS
    .
    .DESCRIPTION
    .
    .PARAMETER Site
    The site name in format: https://tenant.sharepoint.com/sites/Site
    .EXAMPLE
    C:\PS>
    <Description of example>
    .NOTES
    Author: Kirill Kuklin
    Date:   2020-08-18
#>
try {
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Ssl3 -bor [System.Net.SecurityProtocolType]::Tls -bor [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12
} catch {
    Write-Host "The requested security protocol is not supported."
    return;
}
$PNPModule = "SharePointPnPPowerShellOnline"

# checking if PNP module is installed
if (Get-Module -ListAvailable -Name $PNPModule) {
    Write-Host "$PNPModule module exists."
} else {
    Write-Host "$PNPModule module does not exist. Installing ..."
    Install-Module $PNPModule
}

# checking if PNP module is imported
if (Get-Module -Name $PNPModule) {
    Write-Host "$PNPModule module imported."
} else {
    Write-Host "$PNPModule module is not loaded. Loading ..."
    Import-Module $PNPModule -DisableNameChecking
}

$Site = Read-Host "Enter site URL (e.g. https://tenant.sharepoint.com/sites/MySite)"

if ($null -eq $Site) {
    Write-Output "Empty site URL supplied, unable to continue."
    return
}
Connect-PnPOnline -Url $Site -Credentials (Get-Credential)

#Store in variable all the document libraries in the site
$DocLibs = Get-PnPList | Where-Object {$_.BaseTemplate -eq 101}

#Loop thrugh each document library & folders
$results = @()
foreach ($DocLib in $DocLibs)
{
    $AllItems = Get-PnPListItem -List $DocLib -Fields "FileRef", "File_x0020_Type", "FileLeafRef"
    #Loop through each item
    foreach ($Item in $AllItems)
    {
        Write-Host "File found. Path:" $Item["FileRef"] -ForegroundColor Green

        #Creating new object to export in .csv file
        $results += New-Object PSObject -Property @{
            Path          = $Item["FileRef"]
            FileName      = $Item["FileLeafRef"]
            FileExtension = $Item["File_x0020_Type"]
        }
    }
    $results | Export-Csv C:\Temp\SPoFiles.csv -NoTypeInformation
}
Disconnect-PnPOnline