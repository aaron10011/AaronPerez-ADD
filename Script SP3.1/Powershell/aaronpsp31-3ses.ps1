function iniciosesion {

    param(
        [datetime]$FechaInicio,
        [datetime]$FechaFinal
    )

    Write-Host "`nEventos de inicio de sesión:`n" -ForegroundColor Green
    Get-EventLog -LogName Security -InstanceId 4624 | Where-Object {$_.ReplacementStrings[5] -ne "SYSTEM" -and $_.TimeGenerated -ge $FechaInicio -and $_.TimeGenerated -le $FechaFinal} |

    ForEach-Object {
        $fecha = $_.TimeGenerated
        $usuario = $_.ReplacementStrings[5]
        Write-Host "Fecha: $fecha - Usuario: $usuario"
    }

}

iniciosesion -FechaInicio "09/02/2025" -FechaFinal "11/10/2025"