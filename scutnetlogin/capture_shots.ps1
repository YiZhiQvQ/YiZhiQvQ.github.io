# ============================================================================
# SCUTNetLogin 界面截图脚本（半自动）
#
# 为什么需要你参与：程序以管理员权限运行（本脚本无法直接启动），且
# 「认证中/已连接」需在真实校园网里完成认证才会出现；「设置」需点击 UI。
# 本脚本替你完成最繁琐的部分：管理员启动 + 逐帧抓取主窗口并保存为
# 网页所需命名。
#
# 用法（在桌面 PowerShell 里运行）：
#   cd 到此目录；.\capture_shots.ps1
# 1) 首次会弹出 UAC，点「是」以管理员启动 SCUTNetLogin
# 2) 脚本抓主窗口 → 保存 shot_disconnected.png（若程序自动连接中则为其他状态，可稍后重抓）
# 3) 按提示完成其余状态（手动切换后回车抓帧）：
#     · 未连接：断开后 按 1  → 存 shot_disconnected.png
#     · 认证中：点连接 按 2  → 存 shot_connecting.png
#     · 已连接：认证成功 按 3 → 存 shot_connected.png
#     · 设置  ：点击「设置」标签 按 4 → 存 shot_settings.png
#     · 输入 q 退出
# 抓好的 png 直接覆盖 scutnetlogin/assets/ 下同名文件，网页即更新。
# ============================================================================

param(
    [string]$Exe = "E:\documents\GitHub\SCUTNetLogin\release\SCUTNetLogin.exe",
    [string]$OutDir = "$PSScriptRoot\assets",
    [string]$WindowTitle = "SCUT 校园网认证"
)

Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinCap {
    [DllImport("user32.dll")] public static extern IntPtr FindWindowW(string cls, string title);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
    [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr h, IntPtr dc, uint flags);
    public struct RECT { public int Left, Top, Right, Bottom; }
}
"@

function Get-Shot([string]$Name) {
    $hwnd = [WinCap]::FindWindowW($null, $WindowTitle)
    if ($hwnd -eq [IntPtr]::Zero) { Write-Host "未找到窗口：$WindowTitle" -ForegroundColor Red; return }
    $r = New-Object WinCap+RECT
    [WinCap]::GetWindowRect($hwnd, [ref]$r) | Out-Null
    $w = $r.Right - $r.Left; $h = $r.Bottom - $r.Top
    if ($w -le 0 -or $h -le 0) { Write-Host "窗口尺寸异常" -ForegroundColor Red; return }
    $bmp = New-Object System.Drawing.Bitmap($w, $h)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $dc = $g.GetHdc()
    [WinCap]::PrintWindow($hwnd, $dc, 2) | Out-Null   # 2 = PW_RENDERFULLCONTENT
    $g.ReleaseHdc($dc); $g.Dispose()
    $path = Join-Path $OutDir $Name
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "已保存 $path" -ForegroundColor Green
}

# 确保输出目录存在
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

# 1) 管理员启动（首次弹一次 UAC）
Write-Host "正在以管理员启动 SCUTNetLogin 并抓取首帧..." -ForegroundColor Cyan
Start-Process -FilePath $Exe -Verb RunAs
Start-Sleep -Seconds 4
Get-Shot "shot_disconnected.png"

# 2) 交互抓帧
Write-Host "`n切换状态后按对应数字抓帧：1 未连接 / 2 认证中 / 3 已连接 / 4 设置 / q 退出" -ForegroundColor Cyan
while ($true) {
    $k = Read-Host "> "
    switch ($k.ToLower()) {
        "1" { Get-Shot "shot_disconnected.png"; break }
        "2" { Get-Shot "shot_connecting.png"; break }
        "3" { Get-Shot "shot_connected.png";  break }
        "4" { Get-Shot "shot_settings.png";   break }
        "q" { Write-Host "退出。截图在 assets/ 下。" -ForegroundColor Green; break }
        default { Write-Host "无效输入" -ForegroundColor Yellow }
    }
    if ($k.ToLower() -eq "q") { break }
}
