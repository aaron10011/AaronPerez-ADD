$tempusu = "C:\Users\$env:USERNAME\AppData\Local\Temp"

$tempsys = "C:\Windows\Temp"

Remove-Item -Path "$tempusu\*" -Recurse -Force
Remove-Item -Path "$tempsys\*" -Recurse -Force