function Get-BrowserHistoryData {
<#
    .SYNOPSIS
        Dumps Browser Information
        Author: @424f424f
        License: BSD 3-Clause
        Required Dependencies: None
        Optional Dependencies: None
        
    .DESCRIPTION
        Enumerates browser history or bookmarks for a Chrome, Internet Explorer,
        and/or Firefox browsers on Windows machines.
        
    .PARAMETER Browser
        The type of browser to enumerate, 'Chrome', 'IE', 'Firefox' or 'All'
        
    .PARAMETER Datatype
        Type of data to enumerate, 'History' 
        
    .PARAMETER UserName
        Specific username to search browser information for.
    .PARAMETER Search
        Term to search for
    .EXAMPLE
        PS C:\> Get-BrowserData
        Enumerates browser information for all supported browsers for all current users.
    .EXAMPLE
        PS C:\> Get-BrowserData -Browser IE -Datatype Bookmarks -UserName user1
        Enumerates bookmarks for Internet Explorer for the user 'user1'.
    .EXAMPLE
        PS C:\> Get-BrowserData -Browser All -Datatype History -UserName user1 -Search 'github'
        Enumerates bookmarks for Internet Explorer for the user 'user1' and only returns
        results matching the search term 'github'.
#>

    [CmdletBinding()]
    Param
    (
        [Parameter(Position = 0)]
        [String[]]
        [ValidateSet('Chrome','IE','FireFox', 'All')]
        $Browser = 'All',
        [Parameter(Position = 1)]
        [String[]]
        [ValidateSet('History','All')]
        $DataType = 'All',
        [Parameter(Position = 2)]
        [String]
        $UserName = '',
        [Parameter(Position = 3)]
        [String]
        $Search = ''
    )
    function ConvertFrom-Json20([object] $item){
        #http://stackoverflow.com/a/29689642
        Add-Type -AssemblyName System.Web.Extensions
        $ps_js = New-Object System.Web.Script.Serialization.JavaScriptSerializer
        return ,$ps_js.DeserializeObject($item)
        
    }
    function Get-ChromeHistory {
        $Path = "$Env:systemdrive\Users\$UserName\AppData\Local\Google\Chrome\User Data\Default\History"
        if (-not (Test-Path -Path $Path)) {
            Write-Verbose "[!] Could not find Chrome History for username: $UserName"
        }
        $Regex = '(htt(p|s))://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?'
        $Value = Get-Content -Path "$Env:systemdrive\Users\$UserName\AppData\Local\Google\Chrome\User Data\Default\History"|Select-String -AllMatches $regex |% {($_.Matches).Value} |Sort -Unique
        $Value | ForEach-Object {
            $Key = $_
            if ($Key -match $Search){
                New-Object -TypeName PSObject -Property @{
                    User = $UserName
                    Browser = 'Chrome'
                    DataType = 'History'
                    Data = $_
                }
            }
        }        
    }
    function Get-InternetExplorerHistory {
        #https://crucialsecurityblog.harris.com/2011/03/14/typedurls-part-1/
        $Null = New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
        $Paths = Get-ChildItem 'HKU:\' -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]+$' }
        ForEach($Path in $Paths) {
            $User = ([System.Security.Principal.SecurityIdentifier] $Path.PSChildName).Translate( [System.Security.Principal.NTAccount]) | Select -ExpandProperty Value
            $Path = $Path | Select-Object -ExpandProperty PSPath
            $UserPath = "$Path\Software\Microsoft\Internet Explorer\TypedURLs"
            if (-not (Test-Path -Path $UserPath)) {
                Write-Verbose "[!] Could not find IE History for SID: $Path"
            }
            else {
                Get-Item -Path $UserPath -ErrorAction SilentlyContinue | ForEach-Object {
                    $Key = $_
                    $Key.GetValueNames() | ForEach-Object {
                        $Value = $Key.GetValue($_)
                        if ($Value -match $Search) {
                            New-Object -TypeName PSObject -Property @{
                                User = $UserName
                                Browser = 'IE'
                                DataType = 'History'
                                Data = $Value
                            }
                        }
                    }
                }
            }
        }
    }
    function Get-FireFoxHistory {
        $Path = "$Env:systemdrive\Users\$UserName\AppData\Roaming\Mozilla\Firefox\Profiles\"
        if (-not (Test-Path -Path $Path)) {
            Write-Verbose "[!] Could not find FireFox History for username: $UserName"
        }
        else {
            $Profiles = Get-ChildItem -Path "$Path\*.default\" -ErrorAction SilentlyContinue
            $Regex = '(htt(p|s))://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?'
            $Value = Get-Content $Profiles\places.sqlite | Select-String -Pattern $Regex -AllMatches |Select-Object -ExpandProperty Matches |Sort -Unique
            $Value.Value |ForEach-Object {
                if ($_ -match $Search) {
                    ForEach-Object {
                    New-Object -TypeName PSObject -Property @{
                        User = $UserName
                        Browser = 'Firefox'
                        DataType = 'History'
                        Data = $_
                        }    
                    }
                }
            }
        }
    }
    if (!$UserName) {
        $UserName = "$ENV:USERNAME"
    }
    if(($Browser -Contains 'All') -or ($Browser -Contains 'Chrome')) {
        if (($DataType -Contains 'All') -or ($DataType -Contains 'History')) {
            Get-ChromeHistory
        }
    }
    if(($Browser -Contains 'All') -or ($Browser -Contains 'IE')) {
        if (($DataType -Contains 'All') -or ($DataType -Contains 'History')) {
            Get-InternetExplorerHistory
        }
    }
    if(($Browser -Contains 'All') -or ($Browser -Contains 'FireFox')) {
        if (($DataType -Contains 'All') -or ($DataType -Contains 'History')) {
            Get-FireFoxHistory
        }
    }
}
