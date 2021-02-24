Import-Module 'C:\Program Files\Microsoft\Exchange\Web Services\2.2\Microsoft.Exchange.WebServices.dll'

$creds = get-credential
$email = Read-Host -Prompt 'Mailbox SMTP address'

$service = [Microsoft.Exchange.WebServices.Data.ExchangeService]::new()
$service.Credentials = $creds.GetNetworkCredential()
$service.Url = "https://outlook.office365.com/EWS/Exchange.asmx"

$impersonation = [Microsoft.Exchange.WebServices.Data.ImpersonatedUserId]::new([Microsoft.Exchange.WebServices.Data.ConnectingIdType]::SmtpAddress, $email)
$service.ImpersonatedUserId = $impersonation

$mailbox = [Microsoft.Exchange.WebServices.Data.Mailbox]::new($email)
$folderId = [Microsoft.Exchange.WebServices.Data.FolderId]::new([Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::PublicFoldersRoot, $mailbox)
$folder = [Microsoft.Exchange.WebServices.Data.Folder]::Bind($service, $folderId)
Write-Host 'Root folder: ' $folder.DisplayName
