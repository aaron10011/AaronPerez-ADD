Write-Host "`n===== OPCIONES DE LISTADO =====`n"
Write-Host "1. Mostrar un listado de los eventos del sistema"
Write-Host "2. Mostrar un listado de los errores del sistema que han surgido en el último mes"
Write-Host "3. Mostrar un listado de los problemas de aplicaciones de esta semana (warning)`n"

$opcion = Read-Host "Seleccione una opcion (1, 2 o 3): "

switch ($opcion){
    
    "1"{
        Get-EventLog -LogName System -Newest 31
    }

    "2"{

        Get-EventLog -LogName System -EntryType Error -After (Get-Date).AddMonths(-1)
    }

    "3"{
        Get-EventLog -LogName Application -EntryType Warning -After (Get-Date).AddDays(-7)
    }

    default {Write-Host "`nOpción Inválida"}
}