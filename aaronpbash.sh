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
	 intento=1
	 num_user=0

		while [[ $intento -lt 6 ]]; do
			echo ""
			read -p "Ingrese el numero a adivinar: " num_user
			echo ""
			if [[ $num_user -eq $num_ale ]]; then
				echo "Has acertado el numero!!, lo lograste en $intento intentos"
				echo ""
				break
			fi

			intento=$(($intento + 1))

			if [[ $num_user -gt $num_ale ]]; then
				echo "Tu numero es mas grande que el numero aleatorio, te quedan $((6 - $intento)) intentos"
			else
				echo "Tu numero es mas pequeño que el numero aleatorio, te quedan $((6 - $intento)) intentos"
			fi
		done
			if [[ $intento -eq 6 ]]; then
				echo "Te has quedado sin intentos, el numero a adivinar era: $num_ale"
			fi

	;;
	4)

	echo""
	read -p "Escriba el nombre del fichero que desea buscar: " fichero
		ruta=$(sudo find / -name "$fichero" 2> /dev/null)

		if [ -z $ruta ]; then
			echo ""
			echo "No se encontro el fichero $fichero"
		elif [ -f $ruta ]; then
			echo ""
			echo "El fichero existe, se encuentra en $(dirname $ruta) y tiene $(grep -Eoi 'a|e|i|o|u' $ruta | wc -l) vocales"
		else
			echo ""
			echo "No existe el fichero $fichero"
		fi

	;;
	5)

	echo ""
	read -p "Escriba de que directorio quiere saber el numero de ficheros: " dir5

		if [ -d $dir5 ]; then
			num_fich=$(find "$dir5" -maxdepth 1 -type f | wc -l)
			echo ""
			echo "En el directorio $dir5 hay $num_fich archivo/s"
		else
			echo ""
			echo "$dir5 no es un directorio o no existe"
		fi

	;;
	6)

	echo ""
	read -p "De que objeto desea saber sus permisos en octal? (Ruta Absoluta): " obj6

		if [ -e $obj6 ]; then
			echo ""
			echo "El objeto $obj6 tiene estos permisos: $(stat -c '%a' $obj6)"
		else
			echo ""
			echo "El objeto $obj6 no existe"
		fi

	;;
	16)

	 echo ""
	;;
    	*)echo ""
	  echo "Opcion incorrecta"

   	esac
  done
