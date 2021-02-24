Import-Module -Name SharePointPnPPowerShellOnline -DisableNameChecking

Connect-PnPOnline -Url 'https://tenant-admin.sharepoint.com/' -Credentials (Get-Credential)

$DenyAddAndCustomizePagesStatusEnum = [Microsoft.Online.SharePoint.TenantAdministration.DenyAddAndCustomizePagesStatus]

$context = Get-PnPContext
$site = Get-PnPTenantSite -Detailed -Url 'https://tenant.sharepoint.com/blog-site'

$site.DenyAddAndCustomizePages = $DenyAddAndCustomizePagesStatusEnum::Disabled

$site.Update()
$context.ExecuteQuery()

# This row should output list of your sites' URLs and the status of their custom scripting (disabled or not)
Get-PnPTenantSite -Detailed -Url 'https://tenant.sharepoint.com/' | select url,DenyAddAndCustomizePages

Disconnect-PnPOnline