function tableIt($data)
{
  write-host '+-+-----+---+'
  foreach($lin in $data)
  {
    foreach($inlin in $lin)
    {
      $line = $line + '|' + $inlin
    }

    write-host $line '|'
    $line = ''
  }
  write-host '+-+-----+---+'
}

$data = @(@(1,2,30),@(4,23125,6),@(7,8,999))
tableIt $data
