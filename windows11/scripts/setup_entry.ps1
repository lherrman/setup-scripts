<#
.SYNOPSIS
  Phase 1: Debloat with default settings
  Phase 2: Download & execute hosted setup under Bypass policy
#>

# Phase 1: Run the debloat script silently (no Bypass needed)
& ([ScriptBlock]::Create((irm "https://debloat.raphi.re/"))) -RunDefaults -Silent

# Phase 2: Fetch your hosted setup.ps1 and execute it in a new PowerShell process with Bypass
Write-Host "Downloading and running custom setup under Bypass…" -ForegroundColor Cyan

# You can either invoke in memory:
Start-Process powershell.exe -ArgumentList @(
    '-NoProfile',
    '-ExecutionPolicy','Bypass',
    '-Command',"iex (irm 'https://raw.githubusercontent.com/lherrman/setup-scripts/refs/heads/main/windows11/scripts/setup.p1.ps1')"
) -Wait