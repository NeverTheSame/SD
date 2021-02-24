$organization = Get-VBOOrganization -Name "tenant.onmicrosoft.com"
Start-VBOExchangeItemRestoreSession -LatestState -Organization $organization
$session = Get-VBOExchangeItemRestoreSession
$database = Get-VEXDatabase -Session $session
$salesmailbox = Get-VEXMailbox -Database $database -Name "User5 User5"
$notes = Get-VEXFolder -Mailbox $salesmailbox -Name "Notes"
$creds = Get-Credential

$file = Get-Content C:\targets.csv  # has only SMTP of the target accounts with no header, separated by newline

foreach ($TargetMailbox in $file)
{
    if($TargetMailbox -ne $null)
    {
        # $notesTarget = Get-VEXFolder -Mailbox $TargetMailbox -Name "Notes"
        Restore-VEXItem -Folder $notes -Server outlook.office365.com -Credential $creds -TargetMailbox $TargetMailbox -RestoreChangedItem -RestoreDeletedItem
        Write-host "Notes restored to $TargetMailbox"
    }
}

Stop-VBOExchangeItemRestoreSession -session $session