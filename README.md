# My PowerShell script collection

## convert-subtitles-to-srt

Extracts embedded .ass subtitles from .mkv containers and converts them to .srt files using ffmpeg. Also runs a cleanup for .srt files to remove font formatting, because ffmpeg doesn't map font sizes from ass to srt properly.
Made for managing subtitles in Plex, since some platforms can't direct play .ass subs.

To run:
1. Download and save script anywhere on your computer, right click and choose "Run with PowerShell".
2. Select .mkv files to extract subtitles from.
3. By default, extracted subtitles go to the same folder as the video, and names the subtitle to VideoFileName.eng.srt

Options to change in code:
- Line 1: change the .eng.srt append to your liking
- Line 27: Change -y / -n flag to tell ffmpeg to automatically overwrite (or not to) existing .srt files. Default is -y.
- Line 45: Change regex to remove all font formatting, or just to remove font bold tags and font size. Regex for both are on the line below.

## simple-filesort

A PowerShell script to sort .jpeg and .mp4 files to folders per year and month. Videos will be placed in their own folder.

(Supports any filetypes, just remember to change the code. Sort is based on file creation time.)

To run:
1. Place the script SortToFolders.ps1 to the folder containing files you want to sort.
2. Right-click the script and choose "Run with Powershell.

The script will prompt your for confirmation before moving any files.
