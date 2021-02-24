<#
.SYNOPSIS
    .
.DESCRIPTION
    .
.NOTES
    Author: Kirill Kuklin
    Date:   2020-12-17
#>

$availableRepositories = (Get-VBORepository).Name -join ', '
$repoName = Read-Host "Enter repository name (e.g. repository1). Available repositories are: $availableRepositories"
if ($null -eq $repoName) {
    Write-Warning "Empty repository name supplied, unable to continue."
    return
}

$repository = Get-VboRepository -Name $repoName
$users = get-vboentitydata -Repository $repository -Type User
$users | select-object -Property OneDriveUrl, PersonalSiteUrl | ft -AutoSize

$personalSiteURL = Read-Host "Enter the Personal/OneDrive site name of a user you want to remove. See list of available sites above"
if ($null -eq $personalSiteURL) {
    Write-Warning "Empty site URL supplied, unable to continue."
    return
}


$userToDelete = $users | Where-Object {$_.OneDriveUrl -eq $personalSiteURL -or $_.PersonalSiteUrl -eq $personalSiteURL}

$userToDeleteName = $userToDelete.DisplayName
Write-Host "The following user found: "
Out-Host -InputObject $userToDelete | select-object -property *

$permissionToRemove = Read-Host ("Do you want to remove {0} from {1}? Type y or n" -f $userToDeleteName, $repository)

if ("y" -eq $permissionToRemove) {
    Write-Warning "Removing $userToDeleteName from $repository"
    Remove-VBOEntityData -Repository $repository -User $userToDelete
}
elseif ("n" -eq $permissionToRemove) {
    Write-Output "Stopping"
    return
}


$availableOrganizations = (Get-VBOOrganization).Name -join ', '
$orgName = Read-Host "Enter organization name (e.g. organization.onmicrosoft.com). Available organizations are: $availableOrganizations"
if ($null -eq $orgName) {
    Write-Warning "Empty organization name supplied, unable to continue."
    return
}
$org = Get-VBOOrganization -Name $orgName


$availableLicensedUsers = (Get-VBOLicensedUser).UserName -join ', '
$licensedUserName = Read-Host "Enter email of a user that you want to remove. Available emails are: $availableLicensedUsers"
if ($null -eq $orgName) {
    Write-Warning "Empty email supplied, unable to continue."
    return
}
$licensedUser = Get-VBOLicensedUser -Organization $org -Name $licensedUserName
Remove-VBOLicensedUser -User $licensedUser