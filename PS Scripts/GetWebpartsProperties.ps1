#The below function will read the web part properties from a given SharePoint page which will take siteURL, PageRelativeURL, UserName and Password as paramaters.
#Load SharePoint CSOM Assemblies
#Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
#Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
cls

$fileName = "WebPart_Properties_Report"

$enddate = (Get-Date).tostring("yyyyMMddhhmmss")
#$filename = $enddate + '_VMReport.doc'
$logFileName = $fileName +"_"+ $enddate+"_Log.txt"
$invocation = (Get-Variable MyInvocation).Value
$directoryPath = Split-Path $invocation.MyCommand.Path

$directoryPathForLog=$directoryPath+"\"+"LogFiles"
if(!(Test-Path -path $directoryPathForLog))
{
New-Item -ItemType directory -Path $directoryPathForLog
#Write-Host "Please Provide Proper Log Path" -ForegroundColor Red
}
#$logPath = $directoryPath + "\" + $logFileName

$logPath = $directoryPathForLog + "\" + $logFileName

$isLogFileCreated = $False

#DLL location

$directoryPathForDLL=$directoryPath+"\"+"Dependency Files"
if(!(Test-Path -path $directoryPathForDLL))
{
New-Item -ItemType directory -Path $directoryPathForDLL
#Write-Host "Please Provide Proper Log Path" -ForegroundColor Red
}

#DLL location
$clientDLL=$directoryPathForDLL+"\"+"Microsoft.SharePoint.Client.dll"
$clientDLLRuntime=$directoryPathForDLL+"\"+"Microsoft.SharePoint.Client.dll"

Add-Type -Path $clientDLL
Add-Type -Path $clientDLLRuntime
#File Download location

$directoryPathForFileDownloadLocation=$directoryPath+"\"+"Downloaded Files"
if(!(Test-Path -path $directoryPathForFileDownloadLocation))
{
New-Item -ItemType directory -Path $directoryPathForFileDownloadLocation
#Write-Host "Please Provide Proper Log Path" -ForegroundColor Red
}

#File Download location

function Write-Log([string]$logMsg)
{
if(!$isLogFileCreated){
Write-Host "Creating Log File..."
if(!(Test-Path -path $directoryPath))
{
Write-Host "Please Provide Proper Log Path" -ForegroundColor Red
}
else
{
$script:isLogFileCreated = $True
Write-Host "Log File ($logFileName) Created..."
[string]$logMessage = [System.String]::Format("[$(Get-Date)] - {0}", $logMsg)
Add-Content -Path $logPath -Value $logMessage
}
}
else
{
[string]$logMessage = [System.String]::Format("[$(Get-Date)] - {0}", $logMsg)
Add-Content -Path $logPath -Value $logMessage
}
}

#The below function will read the web part properties from a given SharePoint page which will take siteURL, PageRelativeURL, UserName and Password as paramaters.
Function GetWebPartPropertyDetails()
{
param
(
[Parameter(Mandatory=$true)] [string] $SPOSiteURL,
[Parameter(Mandatory=$true)] [string] $pageRelativeURL,
[Parameter(Mandatory=$true)] [string] $UserName,
[Parameter(Mandatory=$true)] [string] $Password
)

Try
{

$securePassword= $Password | ConvertTo-SecureString -AsPlainText -Force
#Setup the Context
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SPOSiteURL)
$ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $securePassword)

$fileByServerRelativeUrl=$pageRelativeURL

#Getting the page details
$file = $ctx.Web.GetFileByServerRelativeUrl($fileByServerRelativeUrl)
$ctx.Load($file)
$ctx.ExecuteQuery()

#Extract all the webparts from the given page.
Write-Host "Extracting all webparts from the given page."
$wpManager = $file.GetLimitedWebPartManager([Microsoft.SharePoint.Client.WebParts.PersonalizationScope]::Shared)
$webpartColls = $wpManager.Webparts
$ctx.Load($webpartColls)
$ctx.ExecuteQuery()

if($webpartColls.Count -gt 0)
{
Write-Host "Looping through all webparts in the page."

$webPartCount=1
foreach($oneWebpart in $webpartColls)
{
$ctx.Load($oneWebpart.WebPart.Properties)
$ctx.ExecuteQuery()
$wpPropValues = $oneWebpart.WebPart.Properties.FieldValues
Write-Host "Webpart ID: " $oneWebpart.ID

Write-Host $webPartCount

Write-Host "##########################" -f Green

foreach($oneProperty in $wpPropValues)
{

Write-Host "Title: " $oneProperty.Title
Write-Host "Description: " $oneProperty.Description
Write-Host "Chrome Type: " $oneProperty.ChromeType
Write-Host "Back Ground Color: "$oneProperty.BackgroundColor
Write-Host "Allow Edit: "$oneProperty.AllowEdit
Write-Host "Allow Hide: "$oneProperty.AllowHide

}
Write-Host "##########################" -f Green
$webPartCount++
}
}

Write-host -f Green "The web part details successfully have been extracted."
}
Catch
{

$ErrorMessage = $_.Exception.Message +"in reading web part properties!:"
Write-Host $ErrorMessage -BackgroundColor Red
Write-Log $ErrorMessage

}
}
#Parameters value
$siteURL="https://globalsharepoint2020.sharepoint.com/sites/CustomSearchRND"

#$PageRelativeURL="/SitePages/TestWPPage.aspx"
$PageRelativeURL="/sites/CustomSearchRND/SitePages/TestWPPage.aspx"
$downloadLocation=$directoryPathForFileDownloadLocation;
$userName = "YourSPOUsername"
$passWord = "YourSPOPassword"
#Parameters ends here.

#Calling the GetWebPartPropertyDetails function and passing the parameters.
GetWebPartPropertyDetails $siteURL $PageRelativeURL $userName $passWord