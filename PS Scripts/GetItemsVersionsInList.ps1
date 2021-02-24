param
(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)] 
    [string]$siteURL,

    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)] 
    [string]$listName,

    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)] 
    [PSCredential]$Credential,

    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)] 
    [string]$outputPath
)
      
$siteURL = "https://shakudo.sharepoint.com/sites/Recaller"
$Credential = get-credential
$listName = "Documents"

$user = "kirill@shakudo.onmicrosoft.com";
$password = Read-Host -Prompt "Input Password" -AsSecureString

$clientContext = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl) 
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($user, $password) 
$clientContext.Credentials = $credentials


# Connect to SharePoint Online site  
Connect-PnPOnline -Url $siteURL -Credentials $Credential
      
# Get the list_of_ints items
$itemColl=Get-PnPListItem -List $listName  
      
# Get the context  
$context=Get-PnPContext  

$results = @()
# Loop through the items  
foreach($item in $itemColl)  
{     
        # Get the item Versions  
        $versionColl=$item.Versions;  
        $context.Load($versionColl);      
        $context.ExecuteQuery();  
        $results += New-Object PSObject -Property @{
                VersionCount  = $item.Versions.Count
                Path          = $Item["FileRef"]          
                }    

        Write-Host -ForegroundColor Yellow $item["Title"] "Processed"  
    } 
$results | Out-File $outputPath

