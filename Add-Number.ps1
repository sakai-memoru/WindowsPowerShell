Function Add-Number
{
    <#
    .SYNOPSIS
        A brief description of the function or script.

    .DESCRIPTION
        A longer description.

    .PARAMETER FirstParameter
        Description of each of the parameters
        Note:
        To make it easier to keep the comments synchronized with changes to the parameters, 
        the preferred location for parameter documentation comments is not here, 
        but within the param block, directly above each parameter.

    .PARAMETER SecondParameter
        Description of each of the parameters

    .INPUTS
        Description of objects that can be piped to the script

    .OUTPUTS
        Description of objects that are output by the script

    .EXAMPLE
        Example of how to run the script

    .LINK
        Links to further documentation

    .NOTES
        Detail on what the script does, if this is needed

    #>

    [CmdletBinding()]
    [Outputtype([Object[]])]

    Param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, HelpMessage="複数行の文字列")]
        [AllowEmptyString()]
        [String[]]$Lines,
        
        [Parameter(Mandatory=$false)]
        [String]$NumberFormat="00000: "
    )

    begin{
        $LineCount=0
    }

    process{
        foreach ($s in $Lines){
            $LineCount++
            Write-Output ($LineCount.ToString($NumberFormat) + $s)
        }    
    }
}