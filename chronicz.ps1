<#
====================================================
              CHRONICZ TWEAK TOOL
          Windows Cleaner & Optimizer
====================================================
#>

Clear-Host
$Host.UI.RawUI.WindowTitle = "Chronicz Tweak Tool"

# Colors
$Accent = "Cyan"
$Success = "Green"
$Warning = "Yellow"

function Logo {

Write-Host ""
Write-Host " ██████╗██╗  ██╗██████╗  ██████╗ ███╗   ██╗██╗ ██████╗███████╗" -ForegroundColor Cyan
Write-Host "██╔════╝██║  ██║██╔══██╗██╔═══██╗████╗  ██║██║██╔════╝╚══███╔╝" -ForegroundColor Cyan
Write-Host "██║     ███████║██████╔╝██║   ██║██╔██╗ ██║██║██║       ███╔╝ " -ForegroundColor Cyan
Write-Host "██║     ██╔══██║██╔══██╗██║   ██║██║╚██╗██║██║██║      ███╔╝  " -ForegroundColor Cyan
Write-Host "╚██████╗██║  ██║██║  ██║╚██████╔╝██║ ╚████║██║╚██████╗███████╗" -ForegroundColor Cyan
Write-Host " ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝ ╚═════╝╚══════╝" -ForegroundColor Cyan

Write-Host ""
Write-Host "        Windows Experience Enhancer" -ForegroundColor DarkGray
Write-Host "              Version 1.0" -ForegroundColor DarkGray
Write-Host ""

}

function Loading($Text) {

Write-Host ""
Write-Host "[>] $Text" -ForegroundColor Yellow

for ($i=0;$i -lt 3;$i++) {
    Write-Host "." -NoNewline -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 200
}

Write-Host ""

}

function Done($Text) {
Write-Host "[✓] $Text" -ForegroundColor Green
}


Logo


# Admin Check

$User = [Security.Principal.WindowsIdentity]::GetCurrent()
$Admin = New-Object Security.Principal.WindowsPrincipal($User)

if (!$Admin.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

Write-Host ""
Write-Host "Run Chronicz as Administrator!" -ForegroundColor Red
Pause
exit

}


# Restore Point

Loading "Creating restore point"

try {

Checkpoint-Computer `
-Description "Chronicz Backup" `
-RestorePointType MODIFY_SETTINGS `
-ErrorAction Stop

Done "Restore point created"

}

catch {

Write-Host "[!] Restore point skipped" -ForegroundColor DarkGray

}



# Dark Mode

Loading "Applying dark mode"

Set-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
AppsUseLightTheme 0

Set-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
SystemUsesLightTheme 0

Done "Dark mode enabled"



# Taskbar

Loading "Cleaning taskbar"

New-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
TaskbarAl 0 `
-Force | Out-Null

Done "Taskbar optimized"



# Suggestions

Loading "Removing Windows suggestions"

New-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
SystemPaneSuggestionsEnabled 0 `
-Force | Out-Null

Done "Suggestions removed"



# Explorer

Loading "Improving File Explorer"

New-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
HideFileExt 0 `
-Force | Out-Null

New-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
LaunchTo 1 `
-Force | Out-Null

Done "Explorer improved"



# Lock screen

Loading "Cleaning lock screen"

New-ItemProperty `
"HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
RotatingLockScreenEnabled 0 `
-Force | Out-Null

Done "Lock screen cleaned"



# Restart Explorer

Loading "Refreshing Windows"

Stop-Process -Name explorer -Force
Start-Process explorer.exe

Done "Windows refreshed"



Write-Host ""

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "          CHRONICZ COMPLETE" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "✔ Windows cleaned" -ForegroundColor Green
Write-Host "✔ Appearance improved" -ForegroundColor Green
Write-Host "✔ Settings optimized" -ForegroundColor Green
Write-Host ""

Pause
