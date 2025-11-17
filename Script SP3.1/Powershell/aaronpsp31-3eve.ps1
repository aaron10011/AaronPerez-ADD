[int]$opcion = -1

while ($opcion -ne 0){

    $valores = Get-EventLog -List | Select-Object -ExpandProperty Log
    $i = 1

    Write-Host "`n===== MENU DE TIPOS DE REGISTROS =====`n"
    foreach ($valor in $valores){
        Write-Host "$i. $valor"
        $i++
    }
    Write-Host "0. Salir`n"

    [int]$opcion = Read-Host "Seleccione una opción (1, 2, 3...)"

    if ($opcion -eq 0){
        Write-Host "`nSaliendo..."
    }
    elseif ($opcion -ge 1 -and $opcion -le $valores.Count){

        $seleccion = $valores[$opcion - 1]

        Write-Host "`nMostrando los 12 últimos eventos del registro: $seleccion"
        Write-Host "==================================================`n"

        Get-EventLog -LogName $seleccion -Newest 12 -ErrorAction SilentlyContinue

    }
    else {
        Write-Host "`nOpción inválida, vuelva a intentarlo" -ForegroundColor Red
    }
}
