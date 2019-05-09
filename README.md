# My PowerShell script collection

## convert-subtitles-to-srt

<b>Requires ffmpeg set as an environment path!</b>

Extracts embedded .ass subtitles from .mkv containers and converts them to .srt files using ffmpeg. Also runs a cleanup for .srt files to remove font formatting, because ffmpeg doesn't map font sizes from ass to srt properly.
Made for managing subtitles in Plex, since some platforms can't direct play .ass subs.

To run:
1. Download and save script anywhere on your computer, right click and choose "Run with PowerShell".
2. Select .mkv files to extract subtitles from.
3. By default, extracted subtitles go to the same folder as the video, and named as VideoFileName.eng.srt

Options to change in code:
- Line 1: change the .eng.srt append to your liking
- Search for FLAG: Change -y / -n flag to tell ffmpeg to automatically overwrite (or not to) existing .srt files. Default is -y.
- Search for REGEX: Change regex to remove all font formatting, or just to remove font bold tags and font size. Regex for both are on the line below.

NOTE: May work with other containers/video files, but not tested.
## simple-filesort

A PowerShell script to sort .jpeg and .mp4 files to folders per year and month. Videos will be placed in their own folder.

(Supports any filetypes, just remember to change the code. Sort is based on file creation time.)

To run:
1. Place the simple-filesort script to the folder containing files you want to sort.
2. Right-click the script and choose "Run with Powershell.

The script will prompt for confirmation before moving any files.
