# Create e-mail message
$msg = new-object Net.Mail.MailMessage

# Set e-mail properties
$msg.subject = "My PowerShell e-mail"

# Set e-mail body
$msg.body = "Body"

# SMTP server
$smtpServer = "smtp.office365.com"

# Creating SMTP server object
$smtp = new-object Net.Mail.SmtpClient($smtpServer)

# Email structure
$msg.From = "me@domain.com"
$msg.ReplyTo = "me@domain.com"
$msg.To.Add("you@domain.com")

# Sending email
$smtp.Send($msg)
