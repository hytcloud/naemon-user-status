# naemon-user-status
A lightweight PowerShell script for monitoring Windows account status (Enabled/Locked Out), designed for integration with Naemon/Nagios monitoring systems.

## Installation
Clone the repository and navigate to the script directory:
```bash
git clone https://github.com/hytcloud/naemon-user-status.git
cd naemon-user-status
```
Ensure the following prerequisites are met on the target Windows host:
- Windows PowerShell (recommended version: 5.1 or later)

## check_user_status.ps1
**Usage**
```powershell
.\check_user_status.ps1 -name <AccountName> -ad <$true|$false>
```

**Options**
- -name  Target Windows account name to monitor
- -ad   (Boolean) Set to $true for Domain Account, $false for Local Account (Default: $false)

**Notes**
- Returns OK if account is active and not locked
- Returns WARNING if the account is Locked Out (system triggered)
- Returns CRITICAL if the account is Disabled (manually by admin)
- Exit codes follow Nagios plugin standards: 0=OK, 1=WARNING, 2=CRITICAL, 3=UNKNOWN
- Version: 2026/09/09
- [GitHub Repo](https://github.com/hytcloud/naemon-user-status.git)