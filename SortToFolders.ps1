# WARNING if using a direct folder path, do not type in \ to the end or the script might not work
#FolderPath = Path C:\Users\Me\Photos
$FolderPath = Get-Location

Write-Host "Counting files... Might take a while."

# Filetypes to sort (NOTE, when adding new video types, also add them to "$isVideo" line somewhere in the loop
$Photos = Get-ChildItem -Path $FolderPath\* -File -Include *.jpg, *.jpeg, *.mp4
Clear-Host

# Confirmation prompt to run script
Write-Host "Do you want to sort $($Photos.Count) files in folder $FolderPath ?" -BackgroundColor Red
$confirmation = Read-Host "[y/n] "
if($confirmation -notin "y", "yes") {
    break
}

$FilesMoved = 0
$FoldersCreated = 0;
ForEach($File in $Photos) {
    # Progress bar
    $calc = ($FilesMoved/$Photos.Count*100)
    Write-Progress -Activity "Moving photos" -Status ("{0:0}% " -f $calc) -PercentComplete $calc -CurrentOperation $File.Name

    # Getting months in format "06_june" and years in "2019".
    $fMonth = "{0:00}_{1}" -f $File.LastWriteTime.Month, $File.LastWriteTime.toString("MMMM")
    $fYear = $File.LastWriteTime.Year

    # Setting up the destination for the file.
    $isVideo =  $File.Extension -eq ".mp4"
    if($isVideo) { 
        $fDest = "$fYear\$fMonth\Videos"
    } else {
        $fDest = "$fYear\$fMonth\"
    }

    # Creating folders if needed. Separate videos to their own folder
    $pathExist = Test-Path($fDest)
    if($pathExist -eq $false) { 
        mkDir $fDest | Out-Null 
        $FoldersCreated++
    }
    Move-Item $File -Destination $fDest
    $FilesMoved++
}
Write-Host "Moved $FilesMoved files and created $FoldersCreated new folders."
Read-Host -Prompt “Press any key to exit ”