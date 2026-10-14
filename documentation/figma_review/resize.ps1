Add-Type -AssemblyName System.Drawing
$manifest = @(
  @{file='P011-R2-menu-1080p.png'; target='menu.jpg'; w=800; h=450},
  @{file='P011-R2-browser-1080p.png'; target='browser.jpg'; w=800; h=450},
  @{file='P010-R1-pause-menu-1080p.png'; target='pause.jpg'; w=800; h=450},
  @{file='Codex-settings-live.png'; target='audio.jpg'; w=800; h=482},
  @{file='Codex-settings-video-live.png'; target='video.jpg'; w=800; h=482},
  @{file='Codex-debug-live.png'; target='debug_live.jpg'; w=800; h=482},
  @{file='Codex-debug-1920-preview.png'; target='debug_prev.jpg'; w=800; h=450}
)
foreach ($m in $manifest) {
  $src = 'g:\Unreal Projects\SheeshhPropHuntYT\documentation\figma_assets\' + $m.file
  $dst = 'g:\Unreal Projects\SheeshhPropHuntYT\documentation\figma_review\upload_images\' + $m.target
  $orig = [System.Drawing.Image]::FromFile($src)
  $bmp = New-Object System.Drawing.Bitmap $m.w, $m.h
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.DrawImage($orig, 0, 0, $m.w, $m.h)
  $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
  $params = New-Object System.Drawing.Imaging.EncoderParameters 1
  $params.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]75)
  $bmp.Save($dst, $codec, $params)
  $g.Dispose()
  $bmp.Dispose()
  $orig.Dispose()
  Write-Host $m.target ((Get-Item $dst).Length / 1024) 'KB'
}
