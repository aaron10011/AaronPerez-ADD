do {

    Write-Host "`n====== AUTOMATIZACION DEL DOMINIO ======`n"

    Write-Host "1. Info. del Dominio"
    Write-Host "2. Crear Nueva OU"
    Write-Host "3. Ver Miembros de una OU"
    Write-Host "4. Crear Nuevo Grupo"
    Write-Host "5. Crear Nueva Cuenta de Usuario"
    Write-Host "0. Salir`n"

    $opcion = Read-Host "Opcion seleccionada"

    switch ($opcion){
        
        "1" {

                $dominio = Get-ADDomain
                $equipo = $env:COMPUTERNAME
                $OUs = (Get-ADOrganizationalUnit -Filter *).Count
                $Grupos = (Get-ADGroup -Filter *).Count
                $Usuarios = (Get-ADUser -Filter *).Count

                Write-Host "`n=== INFO. DEL DOMINIO ==="

                Write-Host "`nEquipo =" $equipo
                Write-Host "Dominio =" $dominio.DNSRoot
                Write-Host "OUs =" $OUs
                Write-Host "Grupos =" $Grupos
                Write-Host "Usuarios =" $Usuarios

            }

        "2" {
                
                $nombreOU2 = Read-Host "`nNombre de la nueva OU"
                $ruta2 = (Get-ADDomain).DistinguishedName

                New-ADOrganizationalUnit -Name "$nombreOU2" -Path "$ruta2"
        
        }

        "3" {
        
                $nombreOU3 = Read-Host "`nNombre de la OU"
                $ruta3 = (Get-ADDomain).DistinguishedName

                Write-Host ""
                Get-ADObject -Filter * -SearchBase "OU=$nombreOU3,$ruta3"
        
        }

        "4" {
                $ruta4 = (Get-ADDomain).DistinguishedName
                $nombreGrupo = Read-Host "`nNombre del Nuevo Grupo"
                $nombreOU4 = Read-Host "`nNombre de la OU"

                Write-Host "`n¿Ambito del Grupo?`n"
                Write-Host "1. Global"
                Write-Host "2. Local"
                Write-Host "3. Universal`n"

                $scope = Read-Host "Opcion introducida"

                if ($scope -eq 1){
                    $ambito = "Global"

                } elseif ($scope -eq 2){
                    $ambito = "DomainLocal"

                } elseif ($scope -eq 3){
                    $ambito = "Universal"

                } else{
                    Write-Host "`nPor favor, escoga una opcion entre 1 y 3."
                    break
                }

                Write-Host "`n¿Tipo de Grupo?`n"
                Write-Host "1. Seguridad"
                Write-Host "2. Distribucion`n"

                $cat = Read-Host "Opcion introducida"

                if ($cat -eq 1){
                    $tipo = "Security"

                } elseif ($cat -eq 2){
                    $tipo = "Distribution"

                } else{
                    Write-Host "`nPor favor, escoga 1 o 2."
                    break
                }

                New-ADGroup -Name "$nombreGrupo" -GroupScope $ambito -GroupCategory $cat -Path "OU=$nombreOU4,$ruta4"
        
        }

        "5" {
        
                $nombre = Read-Host "`nNombre del Usuario"
                $cuenta = Read-Host "Nombre de la Cuenta"
                $grupo = Read-Host "Grupo al que se le va a Añadir"

                if (($nombre, $cuenta, $grupo) -contains $null -or ($nombre, $cuenta, $grupo) -contains ""){
                    Write-Host "`nNo puede dejar ninguno de los campos vacios, vuelva a intentarlo."
                    break
                }

                New-ADUser -Name "$nombre" -SamAccountName "$cuenta" -AccountPassword (ConvertTo-SecureString "C0ntraseñaT3mp" -AsPlainText -Force) -Enabled $true -ChangePasswordAtLogon $true

                Add-ADGroupMember -Identity "$grupo" -Members "$cuenta"
        
        }

        "0" {
                Write-Host "`nSaliendo y limpiando..."
                Start-Sleep -s 2
                cls
            }

        default {Write-Host "`nOpcion Incorrecta, elija un numero entre 0 y 5.`n"}

    }

} while ($opcion -ne 0)