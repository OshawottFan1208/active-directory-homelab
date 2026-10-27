<#
.SYNOPSIS
    Creates Active Directory users (and their department OUs) from a CSV file.

.DESCRIPTION
    Expected CSV columns: FirstName, LastName, SamAccountName, Department, Title, Phone
    - Reads the domain name and DN from Active Directory (no hard-coded domain).
    - Creates the department OU if it does not exist.
    - Skips users that already exist.
    - Sets a temporary password and forces a change at first logon.
    - Reports real failures with the actual error message.

.EXAMPLE
    .\New-BulkUsers.ps1 -CsvPath .\users.csv

.NOTES
    Run on the domain controller in an elevated PowerShell window.
    The default password is a FAKE lab password. Never reuse real passwords.
#>

param(
    [string]$CsvPath         = ".\users.csv",
    [string]$DefaultPassword = "ChangeMe!2026"
)

$ErrorActionPreference = "Stop"
Import-Module ActiveDirectory

$domain    = Get-ADDomain
$DomainDN  = $domain.DistinguishedName
$UpnSuffix = $domain.DNSRoot
Write-Host "Target domain: $UpnSuffix ($DomainDN)"

$securePw = ConvertTo-SecureString $DefaultPassword -AsPlainText -Force
$created  = 0
$skipped  = 0
$failed   = 0

foreach ($u in Import-Csv -Path $CsvPath) {
    $dept   = $u.Department.Trim()
    $sam    = $u.SamAccountName.Trim()
    $ouPath = "OU=$dept,$DomainDN"

    try {
        # Create the OU if needed
        if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$dept'")) {
            New-ADOrganizationalUnit -Name $dept -Path $DomainDN
            Write-Host "Created OU: $dept"
        }

        # Skip existing users
        if (Get-ADUser -Filter "SamAccountName -eq '$sam'") {
            Write-Warning "Skipping ${sam}: already exists"
            $skipped++
            continue
        }

        New-ADUser `
            -Name                  "$($u.FirstName) $($u.LastName)" `
            -GivenName             $u.FirstName `
            -Surname               $u.LastName `
            -SamAccountName        $sam `
            -UserPrincipalName     "$sam@$UpnSuffix" `
            -EmailAddress          "$sam@$UpnSuffix" `
            -Department            $dept `
            -Title                 $u.Title `
            -OfficePhone           $u.Phone `
            -Path                  $ouPath `
            -AccountPassword       $securePw `
            -ChangePasswordAtLogon $true `
            -Enabled               $true

        Write-Host "Created user: $sam ($dept)"
        $created++
    }
    catch {
        Write-Host "FAILED ${sam}: $($_.Exception.Message)" -ForegroundColor Red
        $failed++
    }
}

Write-Host "`nDone. Created: $created  Skipped: $skipped  Failed: $failed"

