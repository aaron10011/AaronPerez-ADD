do {
    Write-Host ""
    Write-Host "1. Pizza"
    Write-Host "2. Días"
    Write-Host "3. Menu Usuarios"
    Write-Host "4. Menu Grupos"
    Write-Host "5. Diskp"
    Write-Host "6. Contraseña"
    Write-Host "7. Fibonacci"
    Write-Host "8. Fibonacci Recursividad"
    Write-Host "9. Monitoreo"
    Write-Host "10. Alerta Espacio"
    Write-host "11. Copias Masivas"
    Write-Host "12. Automatizar PS"
    Write-Host "13. Barrido"
    Write-Host "14. Evento"
    Write-Host "15. Limpieza"
    Write-Host "16. Salir"
    Write-Host ""

    $opcion= Read-Host "Introduce tu selección: "
    Write-Host ""

    switch ($opcion){

        "1" {
            
            $pizza= Read-Host "Quiere una pizza vegetariana o no? (responder si o no): "

            if ($pizza -eq "si"){

                Write-Host "Ingredientes a elegir"
                write-host ""
                Write-Host "Pimiento"
                Write-Host "Tofu"
                Write-Host ""
                $ingrediente= Read-Host "Escoja UN ingrediente (Tomate y Mozzarella incluidos): "
                Write-Host ""

                switch ($ingrediente){
                    "Pimiento" {Write-Host "Usted ha elegido la pizza vegetariana con pimiento como ingrediente."}
                    "Tofu" {Write-Host "Usted ha elegido la pizza vegetariana con tofu como ingrediente."}
                    Default {Write-Host "Ingrediente equivocado o ha seleccionado mas de uno, vuelva a intentarlo."}
                }

            }elseif ($pizza -eq "no"){
                Write-Host "Ingredientes a elegir"
                write-host ""
                Write-Host "Peperoni"
                Write-Host "Jamón"
                Write-Host "Salmón"
                write-host ""
                $ingrediente= Read-Host "Escoja UN ingrediente (Tomate y Mozzarella incluidos): "

                switch ($ingrediente){
                    "Peperoni" {Write-Host "Usted ha elegido la pizza vegetariana con peperoni como ingrediente."}
                    "Jamón" {Write-Host "Usted ha elegido la pizza vegetariana con jamón como ingrediente."}
                    "Salmón" {Write-Host "Usted ha elegido la pizza vegetariana con salmón como ingrediente."}
                    Default {Write-Host "Ingrediente equivocado o ha seleccionado mas de uno, vuelva a intentarlo."}
                }

            }else{
                write-host ""
                Write-Host "Opción Inválida, responda con si o no."
            }

        }

########################

        "2"{
            
            $par=0
            $impar=0
            $fin=367

            for ($i=1; $i -lt $fin; $i++){

                if (($i % 2 -eq 0)){
                 
                    $par++
                    
                }else{

                    $impar++

                }
            }
            Write-Host ""
            Write-Host "Numero de dias pares en un año bisiesto: $par"
            Write-Host "Numero de dias impares en un año bisiesto: $impar"
            Write-Host ""
           
        }

########################

        "3"{

            Write-Host ""
            Write-Host "1. Listar Usuarios"
            Write-Host "2. Crear Usuario"
            Write-Host "3. Eliminar Usuario"
            Write-Host "4. Modificar Nombre Usuario"
            Write-Host ""
            $resp3=Read-Host "Seleccione una de las siguientes opciones (1, 2, 3...)"

            switch ($resp3){
                   
                   "1"{
                        Write-Host ""
                        Get-LocalUser
                        Write-Host ""
                   }

                   "2"{
                        Write-Host ""
                        $nombre=Read-Host "Nombre del nuevo usuario"
                        $contraseña=Read-Host "Contraseña del nuevo usuario" -AsSecureString

                        Write-Host ""
                        New-LocalUser -Name $nombre -Password $contraseña
                        Write-Host "Usuario $nombre creado con exito."
                        Write-Host ""
                   }

                   
                   "3"{
                        Write-Host ""
                        $nombre=Read-Host "Nombre del usuario a eliminar"

                        Write-Host ""
                        Remove-LocalUser -name $nombre
                        Write-Host "Usuario $nombre elimiando con exito."
                        Write-Host ""
                   }

                   
                   "4"{
                        Write-Host ""
                        $nombre=Read-Host "Nombre del usuario a cambiar el nombre"
                        $nuevo=Read-Host "Nuevo nombre"

                        Write-Host ""
                        Rename-LocalUser -name $nombre -newname $nuevo
                        Write-Host "El usuario $nombre ahora se llama $nuevo"
                        Write-Host ""
                   }

                Default {Write-Host "Opcion Invalida"}
            }

        }

########################

        "4"{

            Write-Host ""
            Write-Host "1. Listar Grupos y Miembros"
            Write-Host "2. Crear Grupo"
            Write-Host "3. Eliminar Grupo"
            Write-Host "4. Crear Miembro de un Grupo"
            Write-Host "5. Eliminar Miembro de un Grupo"
            Write-Host ""
            $resp4=Read-Host "Seleccione una de las siguientes opciones (1, 2, 3...)"

            switch ($resp4){
                   
                   "1"{
                        Write-Host ""
                        Get-LocalGroup
                        Write-Host ""
                        $grupo=Read-Host "De que grupo desea saber os miembros que tiene?"
                        Write-Host ""
                        Get-LocalGroupMember -Group $grupo
                   }

                   "2"{
                        Write-Host ""
                        $ngrupo=Read-Host "Nombre del nuevo grupo"

                        Write-Host ""
                        New-LocalGroup -Name $ngrupo
                        Write-Host "Grupo $ngrupo creado con exito."
                        Write-Host ""
                   }

                   
                   "3"{
                        Write-Host ""
                        $rgrupo=Read-Host "Nombre del grupo a eliminar"

                        Write-Host ""
                        Remove-LocalGroup -name $rgrupo
                        Write-Host "Grupo $rgrupo elimiando con exito."
                        Write-Host ""
                   }

                   
                   "4"{
                        Write-Host ""
                        $grupo=Read-Host "A que grupo desea añadir un usuario?"
                        $usu=Read-Host "Nombre del usuario"

                        Write-Host ""
                        Add-LocalGroupMember -Group $grupo -Member $usu
                        Write-Host "El usuario $usu a sido añadido a $grupo"
                        Write-Host ""
                   }

                   "5"{
                        Write-Host ""
                        $grupo=Read-Host "De que grupo desea eliminar un usuario?"
                        $usu=Read-Host "Nombre del usuario"

                        Write-Host ""
                        Remove-LocalGroupMember -Group $grupo -Member $usu
                        Write-Host "El usuario $usu a sido eliminado de $grupo"
                        Write-Host ""
                   }

                Default {Write-Host "Opcion Invalida"}
            }

        }

########################

        "5"{

            $disco=Read-Host "De que disco desea saber su tamaño? (C, D...)"
            Write-Host ""
            Write-Host "Tamaño disponible en el disco $disco : "(((Get-PSDrive $disco).Free + (Get-PSDrive $disco).Used) / 1GB) "GB"
            Write-Host ""
            $ndisco=Read-Host "Ahora indique el numero del disco que desea limpiar (0 = C:\!!)"
            Write-Host ""

            $ruta= "C:\Users\AaronPerez\Desktop\repositorio\AaronPerez-ADD\comandos_diskpart.txt"
            $comandos= @"
                select disk $ndisco
                clean
                convert gpt
"@

            $comandos | Out-File $ruta -Encoding ASCII
            diskpart /s $ruta
            Write-Host "Proceso completado."

        }

########################

        "6"{

            Write-Host ""
            Write-Host "La contraseña será válida si contiene: letras minúsculas, letras mayúsculas, números, caracteres especiales y al menos 8 caracteres."
            Write-Host ""

            $contra = Read-Host "Escriba una contraseña para comprobar su validez"

            if (($contra.Length -lt 8) -or ($contra -notmatch '(?-i)[a-z]') -or ($contra -notmatch '(?-i)[A-Z]') -or ($contra -notmatch '[0-9]') -or ($contra -notmatch '[!@#$%^&*_-]')) {
                Write-Host ""
                Write-Host "La contraseña no es válida."
            }else {
                Write-Host ""
                Write-Host "La contraseña es válida."
            }
        }

########################

        "7"{

            $numero=Read-Host "Introduzca cuantos numeros de Fibonacci desea ver"
            Write-Host ""
            $x=0
            $y=1

            for ($i=0; $i -lt $numero; $i++){

                Write-Host $x
                $fibo = $y + $x
                $x = $y
                $y = $fibo

            }
        }

########################

        "8"{

            $numero=Read-Host "Introduzca cuantos numeros de Fibonacci desea ver (Recursivo)"
            Write-Host ""
            $x=0
            $y=1
            $array=@()

            for ($i=0; $i -lt $numero; $i++){

                $array += $x
                $fibo = $y + $x
                $x = $y
                $y = $fibo
            }

            Write-Host "$($array | Sort-Object -Descending)"
        }

########################
        
        "9"{

            $i=0
            $array = @()

            while($i -lt 6){
            
                Get-CimInstance -ClassName Win32_Processor | Out-Null
                Start-Sleep -Seconds 0.1
                $usoCPU= (Get-CimInstance -ClassName Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
                $array += $usoCPU
                Start-Sleep -Seconds 5
                $i++
            }

            $promedio=($array | Measure-Object -Average).Average
            Write-Host ""
            Write-Host "Uso de CPU promedio en 30s: $usoCPU %"

        }

########################

        Default{
            Write-Host "Opción incorrecta, inténtalo de nuevo."
        }
    }
}
while ($opcion -ne 16)
