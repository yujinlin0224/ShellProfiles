$WindowsInfomationProperty = Get-CimInstance -ClassName Win32_OperatingSystem
$WindowsVersionProperty = Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion'

$WindowsInfomation = '{0} {1} {2} ({3}.{4})' -f `
    $WindowsInfomationProperty.Caption, `
    $WindowsVersionProperty.DisplayVersion, `
    $WindowsInfomationProperty.OSArchitecture.Replace(' ', ''), `
    $WindowsInfomationProperty.Version, `
    $WindowsVersionProperty.UBR

Write-Output $WindowsInfomation
