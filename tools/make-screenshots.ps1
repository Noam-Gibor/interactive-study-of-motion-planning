# Renders every scene of a deck to JPEG (final frame of the last build) and builds a contact sheet.
# Usage:  powershell -File tools\make-screenshots.ps1 [-Deck index.html] [-Out docs\screenshots] [-Width 1280]
# Needs Microsoft Edge (headless). Fonts load from Google Fonts, so run it online for the real look.
param(
  [string]$Deck = "index.html",
  [string]$Out = "docs\screenshots",
  [int]$Width = 1280,
  [string]$Prefix = "scene"
)
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

function Save-Jpeg([string]$src, [string]$dst, [int]$w, [long]$quality = 85) {
  $img = [System.Drawing.Image]::FromFile($src)
  try {
    $h = [int]($img.Height * $w / $img.Width)
    $bmp = New-Object System.Drawing.Bitmap $w, $h
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($img, 0, 0, $w, $h); $g.Dispose()
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
    $ep = New-Object System.Drawing.Imaging.EncoderParameters 1
    $ep.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), $quality
    $bmp.Save($dst, $codec, $ep); $bmp.Dispose()
  } finally { $img.Dispose() }
}

function New-ContactSheet([string[]]$files, [string]$dst, [int]$cols = 4, [int]$tw = 480) {
  $th = [int]($tw * 9 / 16); $gap = 12; $rows = [Math]::Ceiling($files.Count / $cols)
  $bmp = New-Object System.Drawing.Bitmap ($cols * ($tw + $gap) + $gap), ($rows * ($th + $gap) + $gap)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.Clear([System.Drawing.Color]::FromArgb(201, 180, 143))
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  for ($i = 0; $i -lt $files.Count; $i++) {
    $img = [System.Drawing.Image]::FromFile($files[$i])
    $g.DrawImage($img, $gap + ($i % $cols) * ($tw + $gap), $gap + [Math]::Floor($i / $cols) * ($th + $gap), $tw, $th); $img.Dispose()
  }
  $g.Dispose(); $tmp = "$dst.png"; $bmp.Save($tmp); $bmp.Dispose()
  Save-Jpeg $tmp $dst ($cols * ($tw + $gap) + $gap) 82; Remove-Item $tmp
}

if ($MyInvocation.InvocationName -eq '.') { return }  # dot-sourced: only load the functions

$edge = @("${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe", "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $edge) { throw "Microsoft Edge not found" }
$deckPath = (Resolve-Path $Deck).Path
New-Item -ItemType Directory -Force $Out | Out-Null
# copy to a plain temp path: file URLs with non-ASCII folders are fragile in headless mode
$tmp = Join-Path $env:TEMP ("deckshots-" + [guid]::NewGuid()); New-Item -ItemType Directory $tmp | Out-Null
Copy-Item $deckPath "$tmp\deck.html"
$n = ([regex]::Matches((Get-Content $deckPath -Raw -Encoding utf8), "\{ title:'")).Count
$url = "file:///" + ($tmp -replace '\\', '/') + "/deck.html"
$made = @()
for ($i = 1; $i -le $n; $i++) {
  $png = "$tmp\s$i.png"
  # ?final jumps every animation to its end; build 99 is clamped to the scene's last build
  $ErrorActionPreference = "Continue"  # Edge writes harmless noise to stderr
  & $edge --headless=new --disable-gpu --hide-scrollbars --window-size=1920,1080 --virtual-time-budget=4000 --screenshot="$png" "$url`?final#$i.99" 2>$null | Out-Null
  $ErrorActionPreference = "Stop"
  if (-not (Test-Path $png)) { throw "Edge produced no screenshot for scene $i" }
  $dst = Join-Path $Out ("{0}-{1:D2}.jpg" -f $Prefix, $i)
  Save-Jpeg $png $dst $Width; $made += (Resolve-Path $dst).Path
}
New-ContactSheet $made (Join-Path $Out "$Prefix-sheet.jpg")
Remove-Item -Recurse -Force $tmp
Write-Output "Rendered $n scenes to $Out"
