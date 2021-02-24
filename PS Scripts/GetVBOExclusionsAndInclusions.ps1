param
(
  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)] 
  [string]$JobName,

  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)] 
  [PSCredential]$Credential
)

$groupsInExclusions = (Get-VBOExcludedBackupItem -Job (Get-VBOJob -Name $JobName) | Where-Object Type -eq "O365Group").Group

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential -Authentication Basic -AllowRedirection 
Import-PSSession $Session -DisableNameChecking -AllowClobber

$countOfUsersInExcludedGroup = 0
$countOfUsersInAllGroupsInExclusion = 0

Foreach ($excludedGroup in $groupsInExclusions)
{
  $grEx = Get-UnifiedGroup -Identity $excludedGroup.GroupName
  $countOfUsersInExcludedGroup = ($grEx | Get-UnifiedGroupLinks -LinkType Member).Count
  Write-host "$grEx has $countOfUsersInExcludedGroup members."
  $countOfUsersInAllGroupsInExclusion += $countOfUsersInExcludedGroup
}
Write-host "There are $countOfUsersInAllGroupsInExclusion members in all excluded groups." -ForegroundColor Yellow

$countOfUsersInincludedGroup = 0
$countOfUsersInAllGroupsInJob = 0

$groupsInJob = ((Get-VBOJob -Name ShGroups).SelectedItems | Where-Object Type -eq "O365Group").Group





  $grIn = Get-UnifiedGroup -Identity $groupinBackup.GroupName
  $countOfUsersInincludedGroup = ($grIn | Get-UnifiedGroupLinks -LinkType Member).Count
  Write-host "$grIn has $countOfUsersInincludedGroup members."
  $countOfUsersInAllGroupsInJob += $countOfUsersInincludedGroup
}
Write-host "There are $countOfUsersInAllGroupsInJob members in all groups in backup job." -ForegroundColor Yellow

Remove-PSSession $Session