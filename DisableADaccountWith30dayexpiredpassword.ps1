
#$datestamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$MaxDaysOld = (Get-Date).AddDays(-120)
# $MaxDaysOld = {[System.Int32](Get-Date).Day - 90}
$Today = (Get-Date).Date


$usergroup = Get-ADGroupMember finance | select-object samaccountname | foreach {$_.samaccountname}

foreach ($user in $usergroup) {
     Get-ADUser -Identity "$user" -Properties * | FL passwordlastset
     if (($Today - (get-date).AddDays(-90)) -gt $MaxDaysOld)
        {
        '{0} is more than {1} days ago ...' -f $user, $MaxDaysOld
        }
        else
        {
        Write-Warning ('    {0} is less than {1} days ago.' -f $TestDate.Date, $MaxDaysOld)
        }
 }


# foreach ($TestDate in $usergroup)
# #Insted of the array use a varable where you have stored each users "Last password set date"
#     {
#     if (($Today - $TestDate) -gt $MaxDaysOld)
#         {
#         '{0} is more than {1} days ago ...' -f $TestDate.Date, $MaxDaysOld
#         }
#         else
#         {
#         Write-Warning ('    {0} is less than {1} days ago.' -f $TestDate.Date, $MaxDaysOld)
#         }
#     }

