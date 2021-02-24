$isGlobalNotificationsEnabled = (Get-VBOEmailSettings).EnableNotification

if(!$isGlobalNotificationsEnabled) {
    "Global notifications are disabled. Stopping."
    return
}

$from = (Get-VBOEmailSettings).From
$to = (Get-VBOEmailSettings).To
$subject = (Get-VBOEmailSettings).Subject
$smtpServer = (Get-VBOEmailSettings).SMTPServer

$isUseAuthenticationEnabled = (Get-VBOEmailSettings).UseAuthentication

if($isUseAuthenticationEnabled) {
    $userName = (Get-VBOEmailSettings).Username
    if(!($null -eq $userName)) {
    $credential = Get-Credential -Message "Enter credential for $userName" -User $userName
        $useSSLEnabled = (Get-VBOEmailSettings).UseSSL
        if($useSSLEnabled) {
            $port = (Get-VBOEmailSettings).Port
            Send-MailMessage –From $from –To $to –Subject $subject –Body "Test SMTP Relay Service" -SmtpServer $smtpServer -Credential $credential -UseSsl -Port $port
        } else {
            Write-Host "SSL is disabled. Sending unsecured notification."
            Send-MailMessage –From $from –To $to –Subject $subject –Body "Test SMTP Relay Service" -SmtpServer $smtpServer -Credential $credential -Port $port
        }
    }
} else {
    Write-Host "The SMPT server does not require authentication. Sending generic notification."
    Send-MailMessage –From $from –To $to –Subject $subject –Body "Test SMTP Relay Service" -SmtpServer $smtpServer
}
