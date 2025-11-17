# Aviso-EspacioDisco.ps1
# Muestra un aviso si el disco C: tiene poco espacio libre

$disco = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$espacioLibreGB = $disco.FreeSpace / 1GB
$espacioTotalGB = $disco.Size / 1GB
$porcentajeLibre = ($espacioLibreGB / $espacioTotalGB) * 100

if ($porcentajeLibre -lt 15) {
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show("El disco C: tiene menos de un 15% de espacio libre. Por favor, elimina archivos innecesarios o mueve datos a otro disco.", "Espacio en disco bajo", 'OK', 'Warning')
}
