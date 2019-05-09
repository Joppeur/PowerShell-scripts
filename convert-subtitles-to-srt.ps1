$language = "eng"

Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
$FileBrowser.Multiselect = $true
$FileBrowser.InitialDirectory = 'X:\'
$FileBrowser.title = "Select files to process"
$FileBrowser.Filter = "Matroska container (*.mkv)|*.mkv|All files (*.*)|*.*"
$result = $FileBrowser.ShowDialog()
if($result -eq "Cancel") {
    exit
}

Write-Host "`n`n`n`n`n`n`n`n`n"
Write-Host "ffmpeg subtitle extraction started."

$SrtFileNames = New-Object Collections.Generic.List[String]

$filesMoved = 1
ForEach($file in $FileBrowser.FileNames){
    $calc = ($filesMoved/$FileBrowser.FileNames.Count*100)
    Write-Progress -Activity "Converting subtitles ..." -Status ("{0}/{1}" -f $filesMoved, $FileBrowser.FileNames.Count) -PercentComplete $calc  -CurrentOperation $file
    $newName = $file -Replace "\.[^\.]*$",".$language.srt"
    # CHANGE FLAG -y overwrite existing .srt files and-n to disable automatic overwriting. Remove flag to be prompted for each file. 
    ffmpeg -hide_banner -loglevel error -i $file -map 0:s:0 "$newName" -y
    $SrtFileNames.Add($newName)
    $filesMoved++
}

# This is the best way I could figure how to get the folder path
# Regexes the file name off the last processed file's full path.
$folderPath = $file
$folderPath = $folderPath -Replace "\\[^\\]*$"
Set-Location -LiteralPath $folderPath

Write-Host ".srt cleanup started."

$filesMoved = 1
ForEach($file in $SrtFileNames) {
    # Progress Bar
    $calc = ($filesMoved/$SrtFileNames.Count*100)
    Write-Progress -Activity "Cleaning .srt files ..." -Status ("{0}/{1}" -f $filesMoved, $SrtFileNames.Count) -PercentComplete $calc  -CurrentOperation $file 
    (Get-Content -Encoding UTF8 -LiteralPath "$file") -Replace '(<(.*?)>)' | Out-File -LiteralPath "$file"
    #REGEX OPTIONS First one removes font sizes and bolding, 2nd one removes all font formatting.
    #( size="(.*?))"|(<b(.*?)>)|(</b(.*?)>)
    #"<(.*?)>"
    $filesMoved++
}
$filesMoved--
Write-Host "`nProcessed ($filesMoved) file(s).`n"
Read-Host -Prompt “Press any key to exit”