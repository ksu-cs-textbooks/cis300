Get-ChildItem "G:\workspace\cis300-book\old book" -File -Recurse -Filter *.html | ForEach-Object {
  pandoc -f html -t gfm $_.FullName -o ((Split-Path -Path $_.FullName) + '\' + $_.BaseName + '.md') 
}