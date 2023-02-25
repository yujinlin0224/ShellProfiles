$windowsInfomationProperty = Get-CimInstance -ClassName Win32_OperatingSystem
$windowsVersionProperty = Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion'

$windowsInfomation = '{0} {1} {2} ({3}.{4})' -f `
    $windowsInfomationProperty.Caption, `
    $windowsVersionProperty.DisplayVersion, `
    $windowsInfomationProperty.OSArchitecture.Replace(' ', ''), `
    $windowsInfomationProperty.Version, `
    $windowsVersionProperty.UBR

Write-Output $windowsInfomation
