## const
$document_directory = [environment]::GetFolderPath('mydocuments')
$xlsx_file = "Book1.xlsx"
$xlsx_path = Join-Path $document_directory $xlsx_file

$xlsx_path

## obj
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $True
$workbooks = $excel.Workbooks.Open($xlsx_path)

$ary = @()
foreach($sht in $workbooks.Worksheets)
{
  $ary += $sht.Name
}
$ary

$workbooks.Close($false)
$excel.Quit()

[void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$excel)
[gc]::Collect()
[gc]::WaitForPendingFinalizers()
Remove-Variable excel -ErrorAction SilentlyContinue
