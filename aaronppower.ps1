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

            

        }

########################

        Default{
            Write-Host "Opción incorrecta, inténtalo de nuevo."
        }
    }
}
while ($opcion -ne 16)