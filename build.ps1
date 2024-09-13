$currentFolder=(Get-Item .).FullName
$docFolder=$currentFolder + "\doctrine"
$outputFile=$currentFolder + "\doctrine.lst"
Write-Host $docFolder
Write-Host $outputFile

$output = ""
Get-ChildItem -Path $docFolder -Filter *.md -Recurse -File | ForEach-Object {
    $filenameNoExt=[System.IO.Path]::GetFileNameWithoutExtension($_)
    $fileFullName=$_.FullName
    $filePBOFullName=$fileFullName.replace($docFolder, "")
    $filePBOFullName=$filePBOFullName.replace($_, $filenameNoExt)
    $preOutput = $filePBOFullName;
    $output += $preOutput + "`n";
}

if (Test-Path $outputFile) {
    Remove-Item $outputFile
}
New-Item -Path $outputFile -ItemType File

Set-Content -Path $outputFile -Value $output