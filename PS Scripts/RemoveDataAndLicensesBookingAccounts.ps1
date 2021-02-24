param
(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [PSCredential]$Credential,

    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [string]$OrganizationName,

    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [string]$RepositoryName
)

$ExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid -Credential $credential -Authentication Basic -AllowRedirection
Import-PSSession $ExchangeSession -AllowClobber

(Get-Mailbox -RecipientTypeDetails Scheduling |
Select-Object PrimarySmtpAddress |
ConvertTo-Csv -NoTypeInformation) |
Select-Object -Skip 1 |
Set-Content -Path "C:\$(get-date -f MM-dd-yyyy)_Booking.csv"

$repository = Get-VBORepository -Name $RepositoryName
$org = Get-VBOOrganization -Name $OrganizationName
$file = Get-Content "C:\$(get-date -f MM-dd-yyyy)_Booking.csv"
foreach ($item in $file)
{
    $bookingAccountData = Get-VBOEntityData -Type User -Repository $repository -Name $item
    $bookingAccountData
    if($bookingAccountData -ne $null)
    {
        Remove-VBOEntityData -Repository $repository -User $bookingAccountData -Mailbox -ArchiveMailbox -OneDrive -Sites
        $licensedUser = Get-VBOLicensedUser -Organization $org -Name $item
        Remove-VBOLicensedUser -User $licensedUser
    }
}