# ==================================================
#              CHRONICZ TWEAK TOOL
#          Windows Cleaner & Optimizer
# ==================================================

Clear-Host
$Host.UI.RawUI.WindowTitle = "Chronicz Tweak Tool"

function Banner {
    Write-Host ""
    Write-Host " ██████╗██╗  ██╗██████╗  ██████╗ ███╗   ██╗██╗ ██████╗███████╗" -ForegroundColor Cyan
    Write-Host "██╔════╝██║  ██║██╔══██╗██╔═══██╗████╗  ██║██║██╔════╝╚══███╔╝" -ForegroundColor Cyan
    Write-Host "██║     ███████║██████╔╝██║   ██║██╔██╗ ██║██║██║       ███╔╝ " -ForegroundColor Cyan
    Write-Host "██║     ██╔══██║██╔══██╗██║   ██║██║╚██╗██║██║██║      ███╔╝  " -ForegroundColor Cyan
    Write-Host "╚██████╗██║  ██║██║  ██║╚██████╔╝██║ ╚████║██║╚██████╗███████╗" -ForegroundColor Cyan
    Write-Host " ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝ ╚═════╝╚══════╝" -ForegroundColor Cyan

    Write-Host ""
    Write-Host "        Windows Appearance & Performance Tool" -ForegroundColor DarkGray
    Write-Host ""
}

function Loading($text) {
    Write-Host ""
    Write-Host "[*] $text" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 500
}

function Done($text) {
    Write-Host "[✓] $text" -ForegroundColor Green
}


Banner


# Admin check

if (-not ([Security.Principal.WindowsPrincipal]
[Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole(
[Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Write-Host "Please run PowerShell as Administrator." -ForegroundColor Red
    pause
    exit
}


Loading "Creating restore point"

Checkpoint-Computer `
-Description "Chronicz Backup" `
-RestorePointType MODIFY_SETTINGS `
-ErrorAction SilentlyContinue

Done "Restore point created"


Loading "Applying dark Windows theme"

Set-ItemProperty `
-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
-Name AppsUseLightTheme `
-Value 0

Set-ItemProperty `
-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
-Name SystemUsesLightTheme `
-Value 0

Done "Dark mode enabled"



Loading "Cleaning taskbar"

Set-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
TaskbarAl 0

Done "Taskbar cleaned"



Loading "Removing Windows suggestions"

Set-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
SystemPaneSuggestionsEnabled 0

Done "Suggestions disabled"



Loading "Improving File Explorer"

Set-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
HideFileExt 0

Done "File extensions enabled"



Loading "Cleaning lock screen"

Set-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
RotatingLockScreenEnabled 0

Done "Lock screen cleaned"



Loading "Restarting Explorer"

Stop-Process -Name explorer -Force
Start-Process explorer.exe

Done "Explorer restarted"



Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          CHRONICZ FINISHED" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Your Windows interface has been cleaned." -ForegroundColor White
Write-Host "Restart your PC for the best experience." -ForegroundColor Yellow
Write-Host ""

pause
