### UserObjectRelevantInfo.ps1
This script returns general commonly referenced information for a specified user object. The script will then loop back to a menu allowing for useful information to be returned for other users or to remain connected to AzureAD. 

Here is the full list of attributes returned (data is printed in the order listed):

- Displayname
- UserPrincipalName
- ProxyAddresses
- AccountEnabled
- DirSyncEnabled
- PasswordPolicies
- RefreshTokensValidFromDateTime
- DeletionTimestamp
- UsageLocation
- ObjectType
- ObjectID
