# This script will Clean browsing history from Below Browsers for all machine listed in $slpath file#
####Google Chrome,Internet Explorer,Microsoft Edge######
##Script will check if chrome/IE/Edge is running then it will stop and clean browsing history.##
##If you have list of targeted machine in notepad file,you can use this script##
###Please test on testing machine first,then test on live machine###

$SLpath = "C:\test1\localhost.txt"   #Please change path,where list of targeted machines file(.txt) located#

$serverlist = Get-Content -Path $SLpath -Force 

foreach($eachmachine in $serverlist){


$Msedge = Get-process -Name msedge -ErrorAction SilentlyContinue 

#Checking if Msedge is running on machine or not,if running then it will stop process and clean browser.
if($Msedge.Responding -eq "True"){

      Write-host " MsEdge is running"
      $Msedge | Stop-Process -Verbose

      #Delete Microsoft Edge Cache
      Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -ErrorAction SilentlyContinue -Verbose
      Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cookies" -Recurse -ErrorAction SilentlyContinue -Verbose
      Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\History" -Recurse -ErrorAction SilentlyContinue -Verbose

      }

Else{Write-host "MsEdge is not running" -ForegroundColor Green

         #Delete Microsoft Edge Cache,If alreday stopped.
      Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -ErrorAction SilentlyContinue -Verbose
      Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cookies" -Recurse -ErrorAction SilentlyContinue -Verbose
      Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\History" -Recurse -ErrorAction SilentlyContinue -Verbose
}
           
#Checking if internet explorer is running on machine or not,if running then it will stop process and clean browser
$IE = Get-process -Name iexplore -ErrorAction SilentlyContinue


if($IE.Responding -match "True"){

$IE | Stop-Process -Force 
#Delete Internet Explorer Cache

Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\Temporary Internet Files\*" -Recurse -ErrorAction SilentlyContinue -Verbose
Remove-Item -Path '$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*' -Recurse -ErrorAction SilentlyContinue -Verbose
}

Else{ Write-host "Internet explorer is not working" -ForegroundColor Green
        Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\Temporary Internet Files\*" -Recurse -ErrorAction SilentlyContinue -Verbose
        Remove-Item -Path '$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*' -Recurse -ErrorAction SilentlyContinue -Verbose
        }


#Checking if Chrome is running on machine or not,if running then it will stop process and clean browser
$Chrome = Get-process -Name chrome -ErrorAction SilentlyContinue 

If($Chrome.Responding -match "True"){
    
    $chrome| Stop-Process -Force

    Remove-Item -Path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*" -Recurse -ErrorAction SilentlyContinue -Verbose
    Remove-Item -path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache2\entries\*" -Recurse -Force -EA SilentlyContinue -Verbose
    Remove-Item -path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cookies" -Recurse -Force -EA SilentlyContinue -Verbose
    Remove-Item -path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Media Cache" -Recurse -Force -EA SilentlyContinue -Verbose
    Remove-Item -path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cookies-Journal" -Recurse -Force -EA SilentlyContinue -Verbose

}

Else{ Write-host "Chrome is not running" -ForegroundColor Green

    Remove-Item -Path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*" -Recurse -ErrorAction SilentlyContinue -Verbose
    Remove-Item -path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache2\entries\*" -Recurse -Force -EA SilentlyContinue -Verbose
    Remove-Item -path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cookies" -Recurse -Force -EA SilentlyContinue -Verbose
    Remove-Item -path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Media Cache" -Recurse -Force -EA SilentlyContinue -Verbose
    Remove-Item -path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cookies-Journal" -Recurse -Force -EA SilentlyContinue -Verbose
    }

#Delete User Cache

Remove-Item -Path "$env:LOCALAPPDATA\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

Write-Host -ForegroundColor yellow "User Cache Removal - COMPLETE"

}

