# 小猫咪成长日记 - 自动备份脚本
# 功能：创建备份文件夹、设置每日自动备份提醒、管理备份文件

$ErrorActionPreference = "Stop"

# 获取脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BackupFolder = Join-Path $ScriptDir "猫咪日记备份"
$LogFile = Join-Path $BackupFolder "备份日志.txt"

# 写日志函数
function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMsg = "[$timestamp] $Message"
    Add-Content -Path $LogFile -Value $logMsg -Encoding UTF8
    Write-Host $logMsg
}

# 创建备份文件夹
function New-BackupFolder {
    if (-not (Test-Path $BackupFolder)) {
        New-Item -ItemType Directory -Path $BackupFolder -Force | Out-Null
        Write-Log "创建备份文件夹: $BackupFolder"
    }
    
    # 创建子文件夹
    $subFolders = @("每日备份", "手动备份", "导出文件")
    foreach ($folder in $subFolders) {
        $path = Join-Path $BackupFolder $folder
        if (-not (Test-Path $path)) {
            New-Item -ItemType Directory -Path $path -Force | Out-Null
            Write-Log "创建子文件夹: $folder"
        }
    }
    
    Write-Log "备份文件夹初始化完成"
}

# 清理旧备份（保留最近30天）
function Clean-OldBackups {
    $dailyFolder = Join-Path $BackupFolder "每日备份"
    if (Test-Path $dailyFolder) {
        $cutoffDate = (Get-Date).AddDays(-30)
        $oldFiles = Get-ChildItem $dailyFolder -Filter "*.json" | Where-Object { $_.LastWriteTime -lt $cutoffDate }
        if ($oldFiles.Count -gt 0) {
            $oldFiles | Remove-Item -Force
            Write-Log "清理了 $($oldFiles.Count) 个超过30天的备份文件"
        }
    }
}

# 显示备份状态
function Show-BackupStatus {
    Write-Host ""
    Write-Host "📦 备份文件夹: $BackupFolder" -ForegroundColor Cyan
    Write-Host ""
    
    $folders = @("每日备份", "手动备份", "导出文件")
    foreach ($folder in $folders) {
        $path = Join-Path $BackupFolder $folder
        if (Test-Path $path) {
            $files = Get-ChildItem $path -Filter "*.json" -ErrorAction SilentlyContinue
            $size = ($files | Measure-Object -Property Length -Sum).Sum
            $sizeMB = [math]::Round($size / 1MB, 2)
            Write-Host "  📁 $($folder): $($files.Count) 个文件, $sizeMB MB" -ForegroundColor White
        }
    }
    
    Write-Host ""
}

# 创建说明文件
function New-Readme {
    $readmePath = Join-Path $BackupFolder "使用说明.txt"
    if (-not (Test-Path $readmePath)) {
        $readme = @"
🐱 小猫咪成长日记 - 备份说明
================================

📁 文件夹结构：
  ├─ 每日备份/    - 每日自动备份的文件（保留30天）
  ├─ 手动备份/    - 手动保存的重要备份
  └─ 导出文件/    - 从网页导出的备份文件

💡 使用方法：
  1. 打开 cat-diary.html 网页应用
  2. 点击底部"备份"标签页
  3. 点击"导出备份文件"按钮
  4. 将下载的文件移动到本文件夹的"导出文件"目录中

🔔 设置每日提醒备份：
  右键点击"设置每日备份提醒.ps1"，选择"使用PowerShell运行"
  系统会在每天指定时间提醒你备份数据

⚠️ 注意事项：
  - 网页数据存储在浏览器本地，清理浏览器缓存会丢失
  - 建议每周至少手动导出一次备份
  - 重要节点（如生日、体检后）建议手动备份到"手动备份"文件夹
  - 可以将备份文件夹同步到云端（如OneDrive、百度网盘等）

📅 备份策略建议：
  - 每日：应用内自动备份（浏览器本地）
  - 每周：手动导出文件到本文件夹
  - 每月：将备份文件复制到云端或U盘
"@
        Set-Content -Path $readmePath -Value $readme -Encoding UTF8
        Write-Log "创建使用说明文件"
    }
}

# 主菜单
function Show-Menu {
    Write-Host ""
    Write-Host "🐱 小猫咪成长日记 - 备份管理工具" -ForegroundColor Magenta
    Write-Host "==================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "  1. 初始化备份文件夹"
    Write-Host "  2. 查看备份状态"
    Write-Host "  3. 设置每日备份提醒"
    Write-Host "  4. 清理旧备份（30天以上）"
    Write-Host "  5. 打开备份文件夹"
    Write-Host "  0. 退出"
    Write-Host ""
}

# 设置每日备份提醒
function Set-DailyReminder {
    Write-Host ""
    Write-Host "⏰ 设置每日备份提醒" -ForegroundColor Yellow
    Write-Host ""
    
    $hour = Read-Host "请输入提醒时间（小时，24小时制，例如 20 表示晚上8点）"
    if (-not [int]::TryParse($hour, [ref]$null) -or $hour -lt 0 -or $hour -gt 23) {
        Write-Host "❌ 无效的时间，请输入0-23之间的数字" -ForegroundColor Red
        return
    }
    
    $taskName = "猫咪日记备份提醒"
    $description = "每天提醒备份小猫咪成长日记数据"
    
    # 创建提醒脚本
    $reminderScript = Join-Path $BackupFolder "提醒弹窗.ps1"
    $reminderCode = @"
Add-Type -AssemblyName System.Windows.Forms
\$result = [System.Windows.Forms.MessageBox]::Show(
    "别忘了今天给小猫咪写日记哦！`n`n点击确定打开备份页面~",
    "🐱 猫咪日记提醒",
    "OKCancel",
    "Information"
)
if (\$result -eq "OK") {
    \$htmlPath = Join-Path (Split-Path -Parent `$PSScriptRoot) "cat-diary.html"
    if (Test-Path `$htmlPath) {
        Start-Process `$htmlPath
    }
}
"@
    Set-Content -Path $reminderScript -Value $reminderCode -Encoding UTF8
    
    # 检查是否已有任务
    $existingTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
    if ($existingTask) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
        Write-Log "删除旧的计划任务"
    }
    
    # 创建计划任务
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -File `"$reminderScript`""
    $trigger = New-ScheduledTaskTrigger -Daily -At "$hour`:00"
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
    
    Register-ScheduledTask -TaskName $taskName -Description $description -Action $action -Trigger $trigger -Settings:$settings -Force | Out-Null
    
    Write-Log "设置每日备份提醒成功，每天 $hour 点提醒"
    Write-Host ""
    Write-Host "✅ 每日备份提醒已设置！" -ForegroundColor Green
    Write-Host "   每天 $hour 点会弹出提醒窗口" -ForegroundColor White
    Write-Host ""
}

# 主程序
New-BackupFolder
New-Readme

do {
    Show-Menu
    $choice = Read-Host "请选择操作"
    
    switch ($choice) {
        "1" {
            New-BackupFolder
            New-Readme
            Write-Host ""
            Write-Host "✅ 备份文件夹已初始化" -ForegroundColor Green
        }
        "2" {
            Show-BackupStatus
        }
        "3" {
            try {
                Set-DailyReminder
            } catch {
                Write-Host ""
                Write-Host "❌ 设置失败：$($_.Exception.Message)" -ForegroundColor Red
                Write-Host "   请以管理员身份运行此脚本" -ForegroundColor Yellow
            }
        }
        "4" {
            Clean-OldBackups
            Write-Host ""
            Write-Host "✅ 旧备份清理完成" -ForegroundColor Green
        }
        "5" {
            if (Test-Path $BackupFolder) {
                Invoke-Item $BackupFolder
            }
        }
        "0" {
            Write-Host ""
            Write-Host "👋 再见！记得常来记录猫咪成长哦~" -ForegroundColor Cyan
            break
        }
        default {
            Write-Host ""
            Write-Host "❌ 无效选项，请重新选择" -ForegroundColor Red
        }
    }
    
    if ($choice -ne "0") {
        Write-Host ""
        Read-Host "按回车键继续..."
    }
    
} while ($choice -ne "0")
