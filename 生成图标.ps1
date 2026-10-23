# 生成猫咪日记应用图标
Add-Type -AssemblyName System.Drawing

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$iconDir = Join-Path $scriptDir "icons"

if (-not (Test-Path $iconDir)) {
    New-Item -ItemType Directory -Path $iconDir -Force | Out-Null
}

$sizes = @(72, 96, 128, 144, 152, 192, 384, 512)

function Draw-CatIcon {
    param([int]$size)
    
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    
    $s = $size
    $scale = $s / 512.0
    
    # 背景渐变
    $rect = New-Object System.Drawing.Rectangle(0, 0, $s, $s)
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        $rect,
        [System.Drawing.Color]::FromArgb(255, 255, 182, 163),
        [System.Drawing.Color]::FromArgb(255, 255, 107, 107),
        [System.Drawing.Drawing2D.LinearGradientMode]::ForwardDiagonal
    )
    
    # 圆角矩形路径
    $radius = [int](90 * $scale)
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddArc(0, 0, $radius * 2, $radius * 2, 180, 90)
    $path.AddArc($s - $radius * 2, 0, $radius * 2, $radius * 2, 270, 90)
    $path.AddArc($s - $radius * 2, $s - $radius * 2, $radius * 2, $radius * 2, 0, 90)
    $path.AddArc(0, $s - $radius * 2, $radius * 2, $radius * 2, 90, 90)
    $path.CloseFigure()
    
    $g.FillPath($brush, $path)
    
    $cx = $s / 2
    $cy = $s / 2 + [int](10 * $scale)
    $faceColor = [System.Drawing.Color]::FromArgb(255, 255, 228, 220)
    $innerEarColor = [System.Drawing.Color]::FromArgb(255, 255, 181, 181)
    $eyeColor = [System.Drawing.Color]::FromArgb(255, 61, 61, 61)
    $noseColor = [System.Drawing.Color]::FromArgb(255, 255, 154, 139)
    $blushColor = [System.Drawing.Color]::FromArgb(100, 255, 154, 139)
    
    $faceBrush = New-Object System.Drawing.SolidBrush($faceColor)
    $innerEarBrush = New-Object System.Drawing.SolidBrush($innerEarColor)
    $eyeBrush = New-Object System.Drawing.SolidBrush($eyeColor)
    $noseBrush = New-Object System.Drawing.SolidBrush($noseColor)
    $blushBrush = New-Object System.Drawing.SolidBrush($blushColor)
    $whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    
    # 左耳
    $leftEar = New-Object System.Drawing.Drawing2D.GraphicsPath
    $leftEar.AddLine(
        [int]($cx - 100 * $scale), [int]($cy - 60 * $scale),
        [int]($cx - 140 * $scale), [int]($cy - 160 * $scale)
    )
    $leftEar.AddLine(
        [int]($cx - 140 * $scale), [int]($cy - 160 * $scale),
        [int]($cx - 40 * $scale), [int]($cy - 100 * $scale)
    )
    $leftEar.CloseFigure()
    $g.FillPath($faceBrush, $leftEar)
    
    # 右耳
    $rightEar = New-Object System.Drawing.Drawing2D.GraphicsPath
    $rightEar.AddLine(
        [int]($cx + 100 * $scale), [int]($cy - 60 * $scale),
        [int]($cx + 140 * $scale), [int]($cy - 160 * $scale)
    )
    $rightEar.AddLine(
        [int]($cx + 140 * $scale), [int]($cy - 160 * $scale),
        [int]($cx + 40 * $scale), [int]($cy - 100 * $scale)
    )
    $rightEar.CloseFigure()
    $g.FillPath($faceBrush, $rightEar)
    
    # 左耳内侧
    $leftInner = New-Object System.Drawing.Drawing2D.GraphicsPath
    $leftInner.AddLine(
        [int]($cx - 95 * $scale), [int]($cy - 75 * $scale),
        [int]($cx - 125 * $scale), [int]($cy - 140 * $scale)
    )
    $leftInner.AddLine(
        [int]($cx - 125 * $scale), [int]($cy - 140 * $scale),
        [int]($cx - 55 * $scale), [int]($cy - 100 * $scale)
    )
    $leftInner.CloseFigure()
    $g.FillPath($innerEarBrush, $leftInner)
    
    # 右耳内侧
    $rightInner = New-Object System.Drawing.Drawing2D.GraphicsPath
    $rightInner.AddLine(
        [int]($cx + 95 * $scale), [int]($cy - 75 * $scale),
        [int]($cx + 125 * $scale), [int]($cy - 140 * $scale)
    )
    $rightInner.AddLine(
        [int]($cx + 125 * $scale), [int]($cy - 140 * $scale),
        [int]($cx + 55 * $scale), [int]($cy - 100 * $scale)
    )
    $rightInner.CloseFigure()
    $g.FillPath($innerEarBrush, $rightInner)
    
    # 脸部椭圆
    $faceRect = New-Object System.Drawing.RectangleF(
        $cx - 140 * $scale, $cy - 120 * $scale,
        280 * $scale, 240 * $scale
    )
    $g.FillEllipse($faceBrush, $faceRect)
    
    # 眼睛
    $eyeY = $cy - 10 * $scale
    $eyeSpacing = 70 * $scale
    $eyeW = 28 * $scale
    $eyeH = 36 * $scale
    
    $leftEyeRect = New-Object System.Drawing.RectangleF(
        $cx - $eyeSpacing - $eyeW, $eyeY - $eyeH,
        $eyeW * 2, $eyeH * 2
    )
    $g.FillEllipse($eyeBrush, $leftEyeRect)
    
    $rightEyeRect = New-Object System.Drawing.RectangleF(
        $cx + $eyeSpacing - $eyeW, $eyeY - $eyeH,
        $eyeW * 2, $eyeH * 2
    )
    $g.FillEllipse($eyeBrush, $rightEyeRect)
    
    # 眼睛高光
    $highlightW = 8 * $scale
    $highlightH = 10 * $scale
    
    $g.FillEllipse($whiteBrush, 
        [int]($cx - $eyeSpacing + 4 * $scale - $highlightW), 
        [int]($eyeY - 12 * $scale - $highlightH),
        [int]($highlightW * 2), [int]($highlightH * 2))
    
    $g.FillEllipse($whiteBrush, 
        [int]($cx + $eyeSpacing + 4 * $scale - $highlightW), 
        [int]($eyeY - 12 * $scale - $highlightH),
        [int]($highlightW * 2), [int]($highlightH * 2))
    
    # 鼻子（三角形）
    $nosePath = New-Object System.Drawing.Drawing2D.GraphicsPath
    $nosePath.AddLine(
        [int]$cx, [int]($cy + 20 * $scale),
        [int]($cx - 15 * $scale), [int]($cy + 5 * $scale)
    )
    $nosePath.AddLine(
        [int]($cx - 15 * $scale), [int]($cy + 5 * $scale),
        [int]($cx + 15 * $scale), [int]($cy + 5 * $scale)
    )
    $nosePath.CloseFigure()
    $g.FillPath($noseBrush, $nosePath)
    
    # 嘴巴
    $pen = New-Object System.Drawing.Pen($eyeColor, [int](4 * $scale))
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    
    $g.DrawArc($pen,
        [int]($cx - 30 * $scale), [int]($cy + 15 * $scale),
        [int](30 * $scale), [int](25 * $scale),
        0, 180)
    
    $g.DrawArc($pen,
        [int]$cx, [int]($cy + 15 * $scale),
        [int](30 * $scale), [int](25 * $scale),
        0, 180)
    
    # 胡须
    $whiskerPen = New-Object System.Drawing.Pen(
        [System.Drawing.Color]::FromArgb(128, 61, 61, 61), [int](2 * $scale))
    $whiskerPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $whiskerPen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    
    # 左边胡须
    $g.DrawLine($whiskerPen, 
        [int]($cx - 80 * $scale), [int]($cy + 20 * $scale),
        [int]($cx - 160 * $scale), [int]($cy + 10 * $scale))
    
    $g.DrawLine($whiskerPen, 
        [int]($cx - 80 * $scale), [int]($cy + 30 * $scale),
        [int]($cx - 160 * $scale), [int]($cy + 35 * $scale))
    
    $g.DrawLine($whiskerPen, 
        [int]($cx - 80 * $scale), [int]($cy + 40 * $scale),
        [int]($cx - 150 * $scale), [int]($cy + 55 * $scale))
    
    # 右边胡须
    $g.DrawLine($whiskerPen, 
        [int]($cx + 80 * $scale), [int]($cy + 20 * $scale),
        [int]($cx + 160 * $scale), [int]($cy + 10 * $scale))
    
    $g.DrawLine($whiskerPen, 
        [int]($cx + 80 * $scale), [int]($cy + 30 * $scale),
        [int]($cx + 160 * $scale), [int]($cy + 35 * $scale))
    
    $g.DrawLine($whiskerPen, 
        [int]($cx + 80 * $scale), [int]($cy + 40 * $scale),
        [int]($cx + 150 * $scale), [int]($cy + 55 * $scale))
    
    # 腮红
    $g.FillEllipse($blushBrush,
        [int]($cx - 115 * $scale), [int]($cy + 20 * $scale),
        [int](50 * $scale), [int](30 * $scale))
    
    $g.FillEllipse($blushBrush,
        [int]($cx + 65 * $scale), [int]($cy + 20 * $scale),
        [int](50 * $scale), [int](30 * $scale))
    
    # 爪印装饰
    $pawX = $s - 75 * $scale
    $pawY = $s - 65 * $scale
    $pawBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(77, 255, 255, 255))
    
    # 掌垫
    $g.FillEllipse($pawBrush,
        [int]($pawX - 20 * $scale), [int]($pawY - 16 * $scale),
        [int](40 * $scale), [int](32 * $scale))
    
    # 趾垫
    $toeW = 16 * $scale
    $toeH = 20 * $scale
    
    $g.FillEllipse($pawBrush,
        [int]($pawX - 22 * $scale - 8 * $scale), [int]($pawY - 18 * $scale - 10 * $scale),
        [int]$toeW, [int]$toeH)
    
    $g.FillEllipse($pawBrush,
        [int]($pawX - 8 * $scale - 8 * $scale), [int]($pawY - 24 * $scale - 10 * $scale),
        [int]$toeW, [int]$toeH)
    
    $g.FillEllipse($pawBrush,
        [int]($pawX + 8 * $scale - 8 * $scale), [int]($pawY - 24 * $scale - 10 * $scale),
        [int]$toeW, [int]$toeH)
    
    $g.FillEllipse($pawBrush,
        [int]($pawX + 22 * $scale - 8 * $scale), [int]($pawY - 18 * $scale - 10 * $scale),
        [int]$toeW, [int]$toeH)
    
    # 释放资源
    $g.Dispose()
    return $bmp
}

Write-Host ""
Write-Host "🐱 正在生成猫咪日记应用图标..." -ForegroundColor Cyan
Write-Host ""

foreach ($size in $sizes) {
    $bmp = Draw-CatIcon $size
    $filePath = Join-Path $iconDir "icon-$size.png"
    $bmp.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "  ✓ 生成图标: $size x $size" -ForegroundColor Green
}

Write-Host ""
Write-Host "🎉 所有图标生成完成！" -ForegroundColor Magenta
Write-Host "   保存位置: $iconDir" -ForegroundColor White
Write-Host ""

# 同时生成一个favicon
$faviconPath = Join-Path $scriptDir "favicon.png"
$bmp = Draw-CatIcon 64
$bmp.Save($faviconPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Host "  ✓ 生成 favicon.png" -ForegroundColor Green
Write-Host ""
