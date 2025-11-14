[int]$opcion = -1
while ($opcion -ne 0){

    $valores = Get-EventLog -LogName System | Select-Object -ExpandProperty EntryType -Unique
    $i = 1

    Write-Host "`n===== MENU DE EVENTOS =====`n"
    foreach ($valor in $valores){
        Write-Host "$i. $valor"
        $i++
    }
    Write-Host "0. Salir`n"

    [int]$opcion = Read-Host "Seleccione una opcion (1, 2, 3...)"

    if ($opcion -eq 0){

        Write-Host "`nSaliendo..."

    } elseif ([int]$opcion -ge 1 -and [int]$opcion -le $valores.Count){
       
       $seleccion = $valores[$opcion - 1]

       Get-EventLog -LogName System -EntryType $seleccion -Newest 12
        
    } else{

        Write-Host "`nOpción Inválida, vuelva a intentarlo" -ForegroundColor Red

    }

}