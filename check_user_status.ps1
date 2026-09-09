<#
.SYNOPSIS
Check localuser

.DESCRIPTION
This is a simple PowerShell script to Check localuser using WMI

.PARAMETER name
username

.PARAMETER ad
ad (boolean)

.NOTES
version : 2026/09/09

.LINK
https://github.com/hytcloud/naemon-user-status.git
#>

param (
	[Parameter(Mandatory = $true, Position = 0)]
	[string]$name,
	[Parameter(Mandatory = $false, Position = 1)]
	[bool]$ad = $false
)

if ($ad) {
	$filter = "Name = '$name' AND LocalAccount = 'False'"
	$type = "Domain"
}
else {
	$filter = "Name = '$name' AND LocalAccount = 'True'"
	$type = "Local"
}

try {
	$userStatus = Get-WmiObject -Class Win32_UserAccount -Filter $filter -ErrorAction Stop | Select-Object -First 1
}
catch {
	Write-Host "UNKNOWN: Error querying $type user '$name'. Error: $($_.Exception.Message)"
	exit 3
}

if ($null -eq $userStatus) {
	Write-Host "UNKNOWN: $type User '$name' not found. | user=0;;;;"
	exit 3
}

if ($userStatus.Disabled -eq $true) {
	Write-Host "CRITICAL: $type Account '$name' is Disabled | user=0;;;;"
	exit 2
}

if ($userStatus.Lockout -eq $true) {
	Write-Host "WARNING: $type Account '$name' is Locked Out | user=0;;;;"
	exit 1
}

Write-Host "OK: $type Account '$name' is Active  | user=1;;;;"
exit 0