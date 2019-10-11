#===============================================================================
# Get-Calendar: 指定した年月のカレンダーを表示する
#
# パラメータ:
#       $Year: 年（省略した場合は現在の年）
#      $Month: 月（省略した場合は現在の月）
#
# 使用例1(年月指定)
#   PS > Get-Calendar 2008 2
#
# 使用例2(年月省略)
#   PS > Get-Calendar
#
# copyright HIRO's.NET(http://hiros-dot.net/)
#===============================================================================
function global:Get-Calendar
{
  Param ([int]$Year = $(Get-Date).Year, [int]$Month =  $(Get-Date).Month)
  
  #表示用年月作成
  $DispMonth = New-Object DateTime($Year, $Month, 1)
  $strDispMonth = ($DispMonth.ToString("MMMM",[System.Globalization.CultureInfo]'en-US') + " " + $Year)
  #横幅28文字の中間に表示されるようにする
  Write-Host ""
  Write-Host $strDispMonth.PadLeft([int](28 - (28 - $strDispMonth.Length) / 2))
  
  $firstSunday = Get-FirstSunday $Year $Month
  $lastDay = Get-LastDay $Year $Month
  Write-Host "Sun Mon Tue Wed Thu Fri Sat"
  
  # 第1日曜日が"1日"以外の第1週を表示
  if ( $firstSunday -ne 1 )
  {
    for ( $i = 1; $i -lt $firstSunday; $i++ )
    {
      $week += $i.ToString("  # ");
    }
    $spc = "    "
    $spc *= [int](7 - ( $firstSunday - 1 ))
    Write-Host ($spc + $week)
  }
  
  #中間週を表示
  $loopWeek = [Math]::floor(($LastDay - $firstSunday) / 7)
  $Day = $firstSunday
  for ( $weekCnt = 0; $weekCnt -lt $loopWeek; $weekCnt++ )
  {
    $week = "";
    for ( $iDay = 0; $iDay -lt 7; $iDay++ )
    {
      if ( $Day -lt 10 ) { $week += $Day.ToString("  # "); }
      else               { $week += $Day.ToString(" ## "); }
      $Day += 1
    }
    Write-Host ($week)
  }
  
  #最終週を表示
  if ( $Day -le $LastDay )
  {
    $week = ""
    for ( $iDay = $Day; $iDay -le $LastDay; $iDay++ )
    {
      $week += $Day.ToString(" ## ");
      $Day += 1
    }
    Write-Host ($week)
  }
}

#===============================================================================
# Get-FirstSunday: 指定した年月の第1日曜日を取得する
#
# パラメータ:
#       $Year: 年（省略した場合は現在の年）
#      $Month: 月（省略した場合は現在の月）
#
# 使用例1(年月指定)
#   PS > Get-FirstSunday 2008 2
#
# 使用例2(年月省略)
#   PS > Get-FirstSunday
#
# copyright HIRO's.NET(http://hiros-dot.net/)
#===============================================================================
function global:Get-FirstSunday
{
  Param ([int]$Year = $(Get-Date).Year, [int]$Month =  $(Get-Date).Month)
  for ( $i = 0; $i -lt 7; $i++ )
  {
    $checkDay = New-Object DateTime($Year, $Month, [int]($i + 1))
    if ( $checkDay.DayOfWeek -eq 0 )
    {
      break
    }
  }
  return $i + 1
}

#===============================================================================
# Get-LastDay: 指定した年月の最終日を取得する
#
# パラメータ:
#       $Year: 年（省略した場合は現在の年）
#      $Month: 月（省略した場合は現在の月）
#
# 使用例1(年月指定)
#   PS > Get-LastDay 2008 2
#
# 使用例2(年月省略)
#   PS > Get-LastDay
#
# copyright HIRO's.NET(http://hiros-dot.net/)
#===============================================================================
function global:Get-LastDay
{
  Param ([int]$Year = $(Get-Date).Year, [int]$Month =  $(Get-Date).Month)
  return [System.DateTime]::DaysInMonth($Year, $Month)
}