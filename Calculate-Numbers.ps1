function Calculate-Numbers($ary)
{
  $total = 0
  $ary | foreach {$total += $_}
  $total
}

function Run-Process($last_number=100)
{
  $ary = @(1..$last_number)
  $ret = Calculate-Numbers $ary
  $ret
}


## ---------------------------------------------------- // entry point
##
If ((Resolve-Path -Path $MyInvocation.InvocationName).ProviderPath -eq $MyInvocation.MyCommand.Path) 
{


$result = Run-Process

$result = Run-Process 50
 
}