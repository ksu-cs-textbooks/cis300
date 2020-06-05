$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
$source = "G:\workspace\cis300-book\old book"
$destination = "G:\workspace\cis300-book\old book"

foreach ($i in Get-ChildItem $source -Recurse -Force) {
    if ($i.PSIsContainer) {
        continue
    }

    $path = $i.DirectoryName
    $name = $i.Fullname

    if ( !(Test-Path $path) ) {
        New-Item -Path $path -ItemType directory
    }

    $content = get-content $i.Fullname

    if ( $content -ne $null ) {

        [System.IO.File]::WriteAllLines($name, $content, $Utf8NoBomEncoding)
    } else {
        Write-Host "No content from: $i"   
    }
}