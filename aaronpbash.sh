#!/bin/bash
#Autor: Aaron Perez
menu() {
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
	7)

	echo ""
	read -p "Escriba un numero del 1 al 200 para saber como se escribe en romano: " num7

		if [[ $num7 -ge 1 || $num7 -le 200 ]]; then
			centenas=( "" "C" "CC" )
			decenas=( "" "X" "XX" "XXX" "XL" "L" "LX" "LXX" "LXXX" "XC" )
			unidades=( "" "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" )

			centena=$(($num7 / 100))
			decena=$(($num7 % 100 / 10))
			unidad=$(($num7 % 10))

			result="${centenas[$centena]}${decenas[$decena]}${unidades[$unidad]}"

			echo
			echo "El numero $num7 en romano es: $result"
		else
			echo ""
			echo "El numero $num7 no esta dentro de los valores de 1 - 200"
		fi
	;;
	8)

		comprobar=$(ls /mnt/usuarios/)
		if [ -z $comprobar ]; then
			echo ""
			echo "El directorio esta vacio."
		else
			for archivo in /mnt/usuarios/*; do
				nom_arch=$(basename "$archivo")
				sudo useradd -m "$nom_arch"

				carpt=$(cat "$archivo")
				for linea in $carpt; do
					sudo mkdir "/home/$nom_arch/$linea"
				done

				sudo rm "$archivo"
			done
		fi

	;;
	9)

		echo ""
		read -p "Nombre que quiera ponerle al fichero: " nom9
		read -p "Tamaño que quiere que tenga (En K): " tam9

		if [[ ( ! -z $nom9 ) && ( ! -z $tam9 ) ]]; then
			truncate -s "$tam9"K "$nom9"
		elif [[ ( -z $nom9 ) && ( ! -z $tam9 ) ]]; then
			truncate -s "$tam9"K "fichero_vacio"
		elif [[ ( ! -z $nom9 ) && ( -z $tam9 ) ]]; then
			truncate -s "1024K" "$nom9"
		else
			truncate -s "1024k" "fichero_vacio"
		fi

	;;
	10)

		echo ""
                read -p "Nombre que quiera ponerle al fichero: " nom10
                read -p "Tamaño que quiere que tenga (En K): " tam10

		if [[ ( ! -z $nom10 ) && ( ! -z $tam10 ) ]]; then

			for i in {0..9}; do
				if [[ $i -eq 0 ]]; then
					nombre_final="$nom10"
				else
					nombre_final="${nom10}${i}"
				fi

				if [[ ! -e "$nombre_final" ]]; then
					truncate -s "$tam10"K "$nombre_final"
					echo ""
					echo "Fichero $nombre_final creado"
					break
				elif [[ $i -eq 9 ]]; then
					echo ""
				echo "El fichero $nombre_base y sus variantes hasta el 9 ya existe"
				fi
			done

			elif [[ ( -z $nom10 ) && ( ! -z $tam10 ) ]]; then
                        	truncate -s "$tam10"K "fichero_vacio"
                	elif [[ ( ! -z $nom10 ) && ( -z $tam10 ) ]]; then
                        	truncate -s "1024K" "$nom10"
                	else
                       		truncate -s "1024k" "fichero_vacio"
		fi

	;;
	11)
		echo ""
		read -p "Introduzca una palabra para reescribir: " palabra

		reescrita=$(echo "$palabra" | sed 's/a/1/g; s/e/2/g; s/i/3/g; s/o/4/g; s/u/5/g; s/A/1/g; s/E/2/g; s/I/3/g; s/O/4/g; s/U/5/g')
		echo ""
		echo "La palabra que introdujo fue: $palabra. Y reescrita queda asi: $reescrita"

	;;
	12)

		echo ""
		n_usu=$(ls --ignore "copiaseguridad" /home/)
		echo "Este sistema tiene $(ls --ignore='copiaseguridad' /home/ | wc -l) usuarios."
		echo ""
		echo "$n_usu"
		echo ""
		read -p "A que usuario quiere hacerle una copia de seguridad: " user

		comprobar=$(ls /home/ | grep -i "copiaseguridad" 2> /dev/null)
		if [ -z $comprobar ]; then
			sudo mkdir /home/copiaseguridad
			sudo tar -czvf copiaseguridad"$user"_"$(date +%Y-%m-%d)".tar.gz /home/"$user"
		else
			sudo tar -czvf copiaseguridad"$user"_"$(date +%Y-%m-%d)".tar.gz /home/"$user"
			sudo mv copiaseguridad"$user"_"$(date +%Y-%m-%d)".tar.gz /home/copiaseguridad/
			echo ""
			echo "Copia de seguridad del usuario $user creada correctamente, puede verla en /home/copiaseguridad"
		fi

	;;
	16)

	 echo ""
	;;
    	*)echo ""
	  echo "Opcion incorrecta"

   	esac
  done
}

menu
