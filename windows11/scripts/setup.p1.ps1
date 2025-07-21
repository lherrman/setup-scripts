
# -- Unpin taskbar icons --
# $tb = (New-Object -ComObject Shell.Application).NameSpace(
#     'shell:::{4234d49b-0245-4df3-b780-3893943456e1}'
# )
# foreach ($item in $tb.Items()) {
#     $item.Verbs() |
#       Where-Object { $_.Name -replace '&','' -match 'Unpin from taskbar' } |
#       ForEach-Object { Write-Host "Unpinning $($item.Name)..."; $_.DoIt() }
# }

# -- Apply dark-blue theme & tweaks --
Write-Host 'Applying dark theme, accent, and taskbar settings...'
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name ColorPrevalence -Value 1 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name SearchboxTaskbarMode -Value 0 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarDa -Value 0 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -Value 0 -Type DWord -Force

Write-Host 'Restarting Explorer...'
Stop-Process -Name explorer -Force
Start-Sleep -Seconds 1

<#
.SYNOPSIS
  Install Chocolatey and apps with checksum bypass. (until chrome package is fixed)
#>

if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host 'Installing Chocolatey...'
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    iex ((New-Object Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

Write-Host 'Installing applications'


# Core utilities
choco install -y 7zip
choco install -y git
choco install -y openssl

# Media and graphics
choco install -y vlc
choco install -y screentogif

# Development tools
choco install -y vscode
choco install -y dbeaver
choco install -y postman
choco install -y python311
choco install -y python312
choco install -y python313
choco install -y ruff
choco install -y uv

# Productivity and office
choco install -y adobereader
choco install -y notepadplusplus
choco install -y notion
choco install -y mailspring
choco install -y chocolateygui

# System utilities
choco install -y powertoys
choco install -y treesizefree
choco install -y putty
choco install -y winscp
choco install -y shexview
choco install -y rufus
choco install -y unifying
choco install -y wakeonlan

# Browsers and terminals
choco install -y googlechrome
choco install -y warp-terminal

# Development and design
choco install -y docker-desktop