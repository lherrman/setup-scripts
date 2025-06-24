
# -- Unpin taskbar icons --
$tb = (New-Object -ComObject Shell.Application).NameSpace(
    'shell:::{4234d49b-0245-4df3-b780-3893943456e1}'
)
foreach ($item in $tb.Items()) {
    $item.Verbs() |
      Where-Object { $_.Name -replace '&','' -match 'Unpin from taskbar' } |
      ForEach-Object { Write-Host "Unpinning $($item.Name)..."; $_.DoIt() }
}
# -- Apply dark-blue theme & tweaks --
Write-Host 'Applying dark theme, accent, and taskbar settings...'
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name ColorPrevalence -Value 1 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\DWM -Name ColorizationColor -Value 0xFF0078D7 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Search -Name SearchboxTaskbarMode -Value 0 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarDa -Value 0 -Type DWord -Force
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -Value 0 -Type DWord -Force

Write-Host 'Restarting Explorer...'
Stop-Process -Name explorer -Force
Start-Sleep -Seconds 1
# Start-Process explorer

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
choco install -y vlc 7zip vscode powertoys googlechrome --ignore-checksums --force