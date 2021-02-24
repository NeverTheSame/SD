Connect-SPOService -Url https://tenant-admin.sharepoint.com
Set-SPOSite -Identity https://tenant.sharepoint.com/sites/contoso -DenyAddAndCustomizePages 0
