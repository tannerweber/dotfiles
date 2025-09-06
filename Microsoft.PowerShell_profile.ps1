# POWERSHELL PS1
# C:\Users\twebe\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

Invoke-Expression (&starship init powershell) # starship.rs
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\montys.omp.json" | Invoke-Expression

# Yazi path for when file.exe is installed with git.
$env:YAZI_FILE_ONE = "C:\Program Files\Git\usr\bin\file.exe"
