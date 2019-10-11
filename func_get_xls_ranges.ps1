function Excute-Procedure{
    param
    (
        [string] $DocumentDir,
        [string] $TagetFile,
        [string] $OutputFile
    )
    process{
        $filepath= (join-path $DocumentDir $TagetFile)
        $outputpath= (join-path $DocumentDir $OutputFile)
        #$filepath
        $outputpath

        $objxls = New-Object -comobject Excel.Application
        $objxls.visible = $True
        $objxls.DisplayAlerts = $False

        ## xls operation
        $xlbook = $objxls.Workbooks.Open($filepath)
        '$xlbook.FullName=' + $xlbook.FullName

        $targetSheet = $xlbook.worksheets.item("list")
        $targetSheet.activate()
        '$targetSheet.name=' + $targetSheet.name

        ## get json text
        $range = $targetSheet.Range('json_data')
        $json_text = $range.Text
        echo $json_text | out-file -FilePath $outputpath

        ## post process
        $objxls.Workbooks.Close()
        $objxls.Quit() 
    }
}

## main process
## set variables
$mydocuments = [environment]::getfolderpath("mydocuments")
$myspreadsheet = "job_sheet.xlsx"
$myoutputjson  = "job_sheet.json"

Excute-Procedure($mydocuments,$myspreadsheet,$myoutputjson)