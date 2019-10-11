Get-Command | set -Name ary_cmd
Get-Verb | select Verb | foreach {$_.Verb}|set -Name ary_verb
$nouns = @(
  "Acl","Alias","Certificate","ChildItem","Clipboard",
  "Clixml","Command","Computer","ComputerInfo","Console",
  "Content","ControlPanelItem","Counter","Credential",
  "Csv","Culture","Custom","Date","Debug","Debugger",
  "DedupProperties","Default","Error","Event","EventLog",
  "ExecutionPolicy","Expression","File","FormatData","GridView",
  "Guid","Help","Hex","History","Host","HotFix","Html","Information",
  "InstalledModule","InstalledScript","IseSnippet","Item",
  "ItemProperty","ItemPropertyValue","Job","JobTrigger","Json",
  "List","LocalizedData","Location","MailMessage","Member",
  "Mock","Module","ModuleManifest","ModuleMember","Null","Object",
  "ObjectEvent","OdbcDriver","OdbcDsn","OdbcPerfCounter","Output",
  "PSBreakpoint","PSCallStack","PSDebug","PSDrive","PSSnapin",
  "Package","PackageProvider","PackageSource","Path","Pester","
  PesterOption","Process","Progress","Random","RecycleBin",
  "RestMethod","Script","ScriptFileInfo","SecureString",
  "Service","Sleep","String","StringData","Table","TemporaryFile",
  "TimeSpan","TimeZone","Trace","TraceSource","Transaction",
  "Transcript","TroubleshootingPack","Type","TypeData",
  "UICulture","Unique","Variable","Verb","Verbose","Warning",
  "WebRequest","WebServiceProxy","Wide","WinEvent",
  "WinHomeLocation","WindowsEdition","WmiEvent","WmiInstance",
  "WmiMethod","WmiObject","Xml"
)


$ary = @()
$dic = @{}
$arylist = New-Object System.Collections.ArrayList
$arylist.Clear()

foreach($ar in $ary_cmd)
{
  $buf = $ar -split '-' 
  if($buf[0] -in $ary_verb)
  {
    $null = $arylist.Add(@($buf[0], $buf[1]))
    # $buf[0] + ' : ' + $buf[1]
  }
}


$i = 0
foreach($a in $arylist)
{
  if($a[1] -in $nouns){
  
    if($a[1] -in $dic.Keys)
    {
      $dic[$a[1]] += $a[0]
    }else{
      $dic[$a[1]] = @()
      $dic[$a[1]] += $a[0]
    }
    $i++
    # if($i -gt 100){break}
  }
}

$dic.GetEnumerator() | 
    Sort-Object { $_.key } | 
    select key, value | set -Name ordered

$ordered[0..20]

