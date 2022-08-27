Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
public static class WinBrand {
    [DllImport("winbrand.dll", CharSet = CharSet.Unicode)]
    public static extern string BrandingFormatString(string sFormat);
}
'@

$windowsBranding = [WinBrand]::BrandingFormatString('%WINDOWS_LONG%')
$windowsVersion = [System.Environment]::OSVersion.Version
$windowsVersionProperty = Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion'

$windowsInfomation = 'Microsoft {0} {1} ({2}.{3}.{4}.{5})' -f `
    $windowsBranding, `
    $windowsVersionProperty.DisplayVersion, `
    $windowsVersion.Major, `
    $windowsVersion.Minor, `
    $windowsVersion.Build, `
    $windowsVersionProperty.UBR

Write-Output $windowsInfomation
