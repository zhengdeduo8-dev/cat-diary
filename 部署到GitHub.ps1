# 🐱 猫咪日记 - 一键部署到 GitHub Pages
# 运行方法：右键 -> 使用 PowerShell 运行

Write-Host ""
Write-Host "🐱 小猫咪成长日记 - GitHub Pages 部署工具" -ForegroundColor Magenta
Write-Host "=" * 50
Write-Host ""

# 检查 Git
try {
    git --version | Out-Null
    Write-Host "✅ Git 已安装" -ForegroundColor Green
} catch {
    Write-Host "❌ 未检测到 Git，请先安装 Git" -ForegroundColor Red
    Write-Host "   下载地址: https://git-scm.com/download/win"
    Read-Host "按回车键退出"
    exit
}

Write-Host ""
Write-Host "📝 请输入你的 GitHub 用户名:" -ForegroundColor Cyan
$username = Read-Host "  用户名"

if (-not $username) {
    Write-Host "❌ 用户名不能为空" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit
}

$repo = "cat-diary"
$remoteUrl = "https://github.com/$username/$repo.git"

Write-Host ""
Write-Host "🔗 仓库地址: $remoteUrl"
Write-Host ""
Write-Host "正在推送代码到 GitHub..." -ForegroundColor Yellow

# 设置远程仓库
git remote remove origin 2>$null
git remote add origin $remoteUrl 2>$null

# 推送
git branch -M main
$result = git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ 代码推送成功！" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "⚠️  推送失败，可能需要登录 GitHub" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "请按照提示输入你的 GitHub 账号信息" -ForegroundColor Cyan
    Write-Host "如果使用密码，请输入 Personal Access Token" -ForegroundColor Cyan
    Write-Host ""
    
    # 重试推送
    git push -u origin main
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "❌ 推送失败，请检查用户名和仓库是否正确" -ForegroundColor Red
        Write-Host ""
        Write-Host "💡 手动步骤:" -ForegroundColor Yellow
        Write-Host "   1. 确认仓库已创建: $remoteUrl"
        Write-Host "   2. 如果还没创建，去 https://github.com/new 创建"
        Write-Host "   3. 仓库名填: cat-diary"
        Write-Host "   4. 选择 Public"
        Write-Host "   5. 不要勾选 Add README"
        Write-Host ""
        Read-Host "按回车键退出"
        exit
    }
}

Write-Host ""
Write-Host "🎉 代码已推送到 GitHub！" -ForegroundColor Green
Write-Host ""
Write-Host "📋 接下来请手动开启 GitHub Pages:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. 打开仓库设置: https://github.com/$username/$repo/settings/pages"
Write-Host "2. 在 Source 下拉菜单中选择: Deploy from a branch"
Write-Host "3. Branch 选择: main  /  (root)"
Write-Host "4. 点击 Save 保存"
Write-Host "5. 等待 1-2 分钟..."
Write-Host ""
Write-Host "🌐 部署完成后访问地址:" -ForegroundColor Green
Write-Host "   https://$username.github.io/$repo/cat-diary.html"
Write-Host ""
Write-Host "💡 小提示：第一次部署需要等几分钟才能访问~" -ForegroundColor Yellow
Write-Host ""

Read-Host "按回车键退出"
