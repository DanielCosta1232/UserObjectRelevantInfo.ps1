<#

This script returns general commonly referenced information. 

Here is the full list of attributes returned (in the order listed):

Displayname
UserPrincipalName
ProxyAddresses
AccountEnabled
DirSyncEnabled
PasswordPolicies
RefreshTokensValidFromDateTime
DeletionTimestamp
UsageLocation
ObjectType
ObjectID

#>


# Functions 

function CheckModule {
    Write-Host "`nChecking for AzureAD module..."
    if (Get-Module -ListAvailable | ? {$_.name -eq "AzureAD"})
    {
        Write-Host "AzureAD Module is already installed. Importing..." 
        Import-Module AzureAD
        Write-Host "Done!"
    }
    else
    {
        Write-Host "Azure AD Module is not installed. Installing..."
        Install-Module AzureAD -Scope CurrentUser
        Import-Module AzureAD
        Write-Host "Done!"
    }
}

function ConnectAzureAD {
    CheckModule
    Write-Host "When prompted, please enter credentials for your AzureAD Admin account..."
    Connect-AzureAD
}

function PullObjectValue {
    $requestuser = Read-Host "`nPlease enter the user's email address"
    $requestobject = Get-AzureADUser -objectid $requestuser | Select-Object Displayname,UserPrincipalName,ProxyAddresses,AccountEnabled,DirSyncEnabled,PasswordPolicies,RefreshTokensValidFromDateTime,DeletionTimestamp,UsageLocation,ObjectType,ObjectID | FL
    $requestobject
}

# Script starts here
$WindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$WindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($WindowsID)
$AdminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

if ($WindowsPrincipal.IsInRole($AdminRole)) {
    ConnectAzureAD | Out-Null # to keep the terminal clean
    Write-Host "Connected."
    $i = 1
    while ($i -eq 1) {
        PullObjectValue
        $i = Read-Host "Please select one of the following options:`n1. Pull info for another user.`n2. Remain connected to AzureAD and exit script.`n3. Kill the session and exit script.`n"
        }    
        if ($i -eq 2) {
                Write-Host "You have chosen to exit the script, however the connection to AzureAD is still active allowing you to run any AzureAD cmdlets.`n"
                }
        elseif ($i -eq 3) {
                Write-Host "`nKilling active AzureAD session.."
                Disconnect-AzureAD
                Write-Host "Done.`n"
                }
        else {
            Write-Host "Error. Exiting script..."
    }
}
else {
    Write-Host "`nPlease run this script in an elevated PowerShell window."
}