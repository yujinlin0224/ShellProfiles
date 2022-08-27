(Get-Host).PrivateData.FormatAccentColor = [System.ConsoleColor]::Magenta
(Get-Host).PrivateData.ErrorAccentColor = [System.ConsoleColor]::Cyan
(Get-Host).PrivateData.ErrorForegroundColor = [System.ConsoleColor]::Red
(Get-Host).PrivateData.ErrorBackgroundColor = [System.ConsoleColor]::Black
(Get-Host).PrivateData.WarningForegroundColor = [System.ConsoleColor]::Yellow
(Get-Host).PrivateData.WarningBackgroundColor = [System.ConsoleColor]::Black
(Get-Host).PrivateData.DebugForegroundColor = [System.ConsoleColor]::Green
(Get-Host).PrivateData.DebugBackgroundColor = [System.ConsoleColor]::Black
(Get-Host).PrivateData.VerboseForegroundColor = [System.ConsoleColor]::Blue
(Get-Host).PrivateData.VerboseBackgroundColor = [System.ConsoleColor]::Black
(Get-Host).PrivateData.ProgressForegroundColor = [System.ConsoleColor]::Gray
(Get-Host).PrivateData.ProgressBackgroundColor = [System.ConsoleColor]::Black

Set-PSReadLineOption -Colors @{
    'Error' = [System.ConsoleColor]::Red
    'Default' = [System.ConsoleColor]::White
    'Comment' = [System.ConsoleColor]::DarkGreen
    'Keyword' = [System.ConsoleColor]::DarkMagenta
    'String' = [System.ConsoleColor]:: Blue
    'Operator' = [System.ConsoleColor]::Gray
    'Variable' = [System.ConsoleColor]::Cyan
    'Command' = [System.ConsoleColor]::Green
    'Parameter' = [System.ConsoleColor]::DarkGray
    'Type' = [System.ConsoleColor]::DarkBlue
    'Number' = [System.ConsoleColor]::Magenta
    'Member' = [System.ConsoleColor]::Yellow
}

function Prompt {
    $currentPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    $relativePath = [System.IO.Path]::GetRelativePath($HOME, $currentPath)
    if ($relativePath -eq '.') {
        $path = '~'
    } elseif ($currentPath.IndexOf($HOME) -eq 0) {
        $path = Join-Path '~' $relativePath
    } else {
        $path = $currentPath
    }
    if ($path.EndsWith('\')) {
        $path = $path.TrimEnd('\')
    }
    if ($path.IndexOf('Microsoft.PowerShell.Core\FileSystem::') -eq 0) {
        $path = $path.Remove(0, 'Microsoft.PowerShell.Core\FileSystem::'.Length)
    }
    $authority = "$($env:UserName)@$([System.Net.Dns]::GetHostName())"
    $host.UI.RawUI.WindowTitle = "$($authority):$($path) - PowerShell"
    Write-Host $authority -NoNewLine -ForegroundColor 'DarkCyan'
    Write-Host ':' -NoNewLine
    Write-Host $path -ForegroundColor 'DarkYellow'
    return "$('>' * ($NestedPromptLevel + 1)) "
}

& {
    $windowsInfomation = & '~\Get-WindowsInfomation.ps1'
    $infomation = "PowerShell $($PSVersionTable.PSVersion) [$($windowsInfomation)]"
    $copyright = 'Copyright © Microsoft Corporation. All rights reserved.'

    chcp 65001 | Out-Null

    Write-Host $infomation -ForegroundColor 'Cyan'
    Write-Host $copyright
    Write-Host
}

if (Test-Path '~\miniconda3' -PathType 'Container') {
    & '~\miniconda3\shell\condabin\conda-hook.ps1'
    conda activate base
}
