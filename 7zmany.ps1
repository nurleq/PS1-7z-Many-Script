#This (powershell) script will extract all of the *.7z files within the current directory to "OUTPUT-'Original 7z filename'-D" directories within the current directory and the .7z contents. Note add a -y to overwrite and skip confirmation for each itteration fo the loop.

$7zPath="C:\Program Files\7-Zip\7z.exe"
$outputDirectory = (Get-Location).Path
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
if (-Not (Test-Path $outputDirectory)) {
    New-Item -ItemType Directory -Force -Path $outputDirectory
}

Get-ChildItem -Path $sourceDirectory -Filter *.7z | ForEach-Object {
    $zipFilePath = $_.FullName
    $extractedDirectoryName = [System.IO.Path]::GetFileNameWithoutExtension($zipFilePath)

    $destinationPath = Join-Path $outputDirectory $extractedDirectoryName
	
	$destinationPath = "OUTPUT-" + [System.IO.Path]::GetFileName($zipFilePath)+"-D"
	echo $destinationPath

    if (-Not (Test-Path $destinationPath)) {
        New-Item -ItemType Directory -Force -Path $destinationPath
    }

    & $7zPath e "$zipFilePath" -o"$destinationPath" -y
}