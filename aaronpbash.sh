#!/bin/bash
#Autor: Aaron Perez
 resp=0
 while [ $resp -ne 16 ]; do
  #Creamos el menu de opciones
  echo ""
  echo "1. Bisiesto"
  echo "2 .Configurar_Red"
  echo "3. Adivina"
  echo "4. Buscar"
  echo "5. Contar"
  echo "6. Permisos_Octal"
  echo "7. Romano"
  echo "8. Automatizar"
  echo "9. Crear"
  echo "10. Crear_2.0"
  echo "11. Reescribir"
  echo "12. Contar_Usuarios"
  echo "13. Quita_Blancos"
  echo "14. Lineas"
  echo "15. Analizar"
  echo "16. Salir"		#Ponemos la opcion de salir del script
  echo ""
  read -p "Seleccione una opcion: " resp		#Creamos la variable de la respuesta

	case $resp in
    	1)

	  read -p "Que año desea saber si es bisiesto?: " bis

	   if [[ $(($bis % 4)) -eq 0 && $(($bis % 100)) -ne 0 || $(($bis % 400)) -eq 0 ]]; then
		echo ""
		echo "El año $bis es bisiesto"
	   else
		echo ""
		echo "El año $bis no es bisiesto"
	   fi

    	;;
	2)

	 read -p "Escriba la IP que quiera poner: " ip
	 read -p "Escriba la mascara que quiera poner: " masc
	 read -p "Escriba la puerta de enlace que quiera poner: " gat
	 read -p "Escriba el DNS que quiera poner: " dns

		nmcli connection modify netplan-enp0s3 ipv4.method manual ipv4.addresses "$ip"/"$masc" ipv4.gateway "$gat" ipv4.dns "$dns"
		nmcli con down netplan-enp0s3
		nmcli con up netplan-enp0s3
		echo ""
		nmcli device show enp0s3
		echo ""

	;;
	3)

	 num_ale=$(($RANDOM % 100 + 1))
	 intento=0
	 num_user=0

		while [[ $intento -lt 5 ]]; do
echo "$num_ale"
			read -p "Ingrese el numero a adivinar: " num_user
			if [[ $num_user -ne $num_ale ]]; then
				echo ""
				intento=$(($intento + 1))
				echo "Has fallado, te quedan $((5 - $intento)) intentos"
				echo ""
			else
				echo "Has acertado el numero!!"
			fi

			if [[ $num_user -gt $num_ale ]]; then
				echo "Tu numero es mas grande que el numero aleatorio"
			else
				echo "Tu numero es mas pequeño que el numero aleatorio"
			fi
		done

	;;
	16)

	 echo ""
	;;
    	*) echo "Opcion incorrecto"

   	esac
  done
