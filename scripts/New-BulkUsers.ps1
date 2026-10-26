<#
.SYNOPSIS
    Creates Active Directory users (and their department OUs) from a CSV file.

.DESCRIPTION
    Expected CSV columns: FirstName, LastName, SamAccountName, Department, Title, Phone
    - Creates the department OU if it does not exist.
    - Skips users that already exist.
    - Sets a temporary password and forces a change at first logon.

.EXAMPLE
    .\New-BulkUsers.ps1 -CsvPath .\users.csv

.NOTES
    Run on the domain controller in an elevated PowerShell window.
    The default password is a FAKE lab password. Never reuse real passwords.
#>

param(
    [string]$CsvPath         = ".\users.csv",
    [string]$DomainDN        = "DC=lab,DC=local",
    [string]$UpnSuffix       = "lab.local",
    [string]$DefaultPassword = "ChangeMe!2026"
)

Import-Module ActiveDirectory

$securePw = ConvertTo-SecureString $DefaultPassword -AsPlainText -Force
$created  = 0
$skipped  = 0

Import-Csv -Path $CsvPath | ForEach-Object {
    $dept   = $_.Department
    $ouPath = "OU=$dept,$DomainDN"

    # Create the OU if needed
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$dept'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $dept -Path $DomainDN
        Write-Host "Created OU: $dept"
    }

    # Skip existing users
    if (Get-ADUser -Filter "SamAccountName -eq '$($_.SamAccountName)'" -ErrorAction SilentlyContinue) {
        Write-Warning "Skipping $($_.SamAccountName): already exists"
        $script:skipped++
        return
    }

    New-ADUser `
        -Name                  "$($_.FirstName) $($_.LastName)" `
        -GivenName             $_.FirstName `
        -Surname               $_.LastName `
        -SamAccountName        $_.SamAccountName `
        -UserPrincipalName     "$($_.SamAccountName)@$UpnSuffix" `
        -EmailAddress          "$($_.SamAccountName)@$UpnSuffix" `
        -Department            $dept `
        -Title                 $_.Title `
        -OfficePhone           $_.Phone `
        -Path                  $ouPath `
        -AccountPassword       $securePw `
        -ChangePasswordAtLogon $true `
        -Enabled               $true

    Write-Host "Created user: $($_.SamAccountName) ($dept)"
    $script:created++
}

Write-Host "`nDone. Created: $created  Skipped: $skipped"
