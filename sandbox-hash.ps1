$template = @"
{{first}} is first.
{{second}} is second.
"@

$dic = @{
  'first' = 1
  'second' = 2
}
$dic

foreach ($key in $dic.Keys)
{
  $template = $template.Replace("{{$key}}",$dic[$key])
}

$template
