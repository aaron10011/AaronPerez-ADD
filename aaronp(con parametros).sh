#!/bin/bash
#Autor: Aaron Perez

bisiesto() {
	bis=$1
	if [[ $(($bis % 4)) -eq 0 && $(($bis % 100)) -ne 0 || $(($bis % 400)) -eq 0 ]]; then
		echo ""
		echo "El año $bis es bisiesto"
	else
		echo ""
		echo "El año $bis no es bisiesto"
	fi
}

configurar_red() {
	ip=$1
	masc=$2
	gat=$3
	dns=$4

	nmcli connection modify netplan-enp0s3 ipv4.method manual ipv4.addresses "$ip"/"$masc" ipv4.gateway "$gat" ipv4.dns "$dns"
	nmcli con down netplan-enp0s3
	nmcli con up netplan-enp0s3
	echo ""
	nmcli device show enp0s3
	echo ""
}

adivina() {
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
}

buscar() {
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
}

contar() {
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
}

permisos_octal() {
	echo ""
	read -p "De que objeto desea saber sus permisos en octal? (Ruta Absoluta): " obj6

	if [ -e $obj6 ]; then
		echo ""
		echo "El objeto $obj6 tiene estos permisos: $(stat -c '%a' $obj6)"
	else
		echo ""
		echo "El objeto $obj6 no existe"
	fi
}

romano() {
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
}

automatizar() {
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
}

crear() {
	nom9=$1
	tam9=$2

	if [[ ( ! -z $nom9 ) && ( ! -z $tam9 ) ]]; then
		truncate -s "$tam9"K "$nom9"
	elif [[ ( -z $nom9 ) && ( ! -z $tam9 ) ]]; then
		truncate -s "$tam9"K "fichero_vacio"
	elif [[ ( ! -z $nom9 ) && ( -z $tam9 ) ]]; then
		truncate -s "1024K" "$nom9"
	else
		truncate -s "1024k" "fichero_vacio"
	fi
}

crear_2() {
	nom=$1
	tam=$2

	if [[ ( ! -z $nom ) && ( ! -z $tam ) ]]; then

		creado=0
		for i in {0..9}; do
			if [[ $i -eq 0 ]]; then
				nombre_final="$nom"
			else
				nombre_final="${nom}${i}"
			fi

			if [[ ! -e "$nombre_final" ]]; then
				truncate -s "$tam"K "$nombre_final"
				echo ""
				echo "Fichero $nombre_final creado"
				creado=1
				break
			else
				if [ $i -eq 0 ]; then
					echo ""
					echo "El fichero $nom ya existe, intenta otro..."
				fi
			fi
		done

		if [ $creado -eq 0 ]; then
			echo ""
			echo "Error: El fichero $nom y sus variantes hasta ${nom}9 ya existen"
			echo "No se ha creado ningún fichero"
		fi

	elif [[ ( -z $nom ) && ( ! -z $tam ) ]]; then
		truncate -s "${tam}K" "fichero_vacio"
		echo ""
		echo "Fichero 'fichero_vacio' creado correctamente"
	elif [[ ( ! -z $nom ) && ( -z $tam ) ]]; then
		truncate -s "1024K" "$nom"
		echo ""
		echo "Fichero '$nom' creado con tamaño por defecto (1024K)."
	else
		truncate -s "1024k" "fichero_vacio"
		echo ""
		echo "Fichero 'fichero_vacio' creado con tamaño por defecto (1024K)"
	fi
}

reescribir() {
	palabra=$1

	reescrita=$(echo "$palabra" | sed 's/a/1/g; s/e/2/g; s/i/3/g; s/o/4/g; s/u/5/g; s/A/1/g; s/E/2/g; s/I/3/g; s/O/4/g; s/U/5/g')
	echo ""
	echo "La palabra que introdujo fue: $palabra. Y reescrita queda asi: $reescrita"
}

contar_usuarios() {
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
}

quita_blancos() {
	echo "Renombrando archivos con espacios..."

	# Recorremos todos los archivos del directorio actual
	for archivo in *; do
		# Comprobamos si el archivo tiene espacios en el nombre
		if [[ "$archivo" == *" "* ]]; then

			# Creamos el nuevo nombre reemplazando espacios por _
			nuevo_nombre=$(echo "$archivo" | tr ' ' '_')

			# Renombramos el archivo
			mv "$archivo" "$nuevo_nombre"

			echo "Renombrado: '$archivo' -> '$nuevo_nombre'"
		fi
	done

	echo "Proceso completado."
}

lineas() {
	caracter=$1
	num_caracteres=$2
	num_lineas=$3

	# Comprobamos que se hayan introducido los datos
	if [[ -z $caracter || -z $num_caracteres || -z $num_lineas ]]; then
		echo ""
		echo "Error: Debes introducir todos los datos"
		return
	fi

	# Comprobamos que el número de caracteres esté entre 1 y 60
	if [ $num_caracteres -lt 1 ] || [ $num_caracteres -gt 60 ]; then
		echo ""
		echo "Error: El número de caracteres debe estar entre 1 y 60"
		return
	fi

	# Comprobamos que el número de líneas esté entre 1 y 10
	if [ $num_lineas -lt 1 ] || [ $num_lineas -gt 10 ]; then
		echo ""
		echo "Error: El número de líneas debe estar entre 1 y 10"
		return
	fi

	echo ""
	# Dibujamos las líneas
	linea=1
	while [ $linea -le $num_lineas ]; do
		contador=1
		while [ $contador -le $num_caracteres ]; do
			echo -n "$caracter"
			contador=$((contador + 1))
		done
		echo ""
		linea=$((linea + 1))
	done
}

analizar() {
	directorio=$1
	shift
	extensiones="$@"

	# Comprobamos que se haya introducido el directorio
	if [ -z "$directorio" ]; then
		echo ""
		echo "Error: Debes introducir un directorio"
		return
	fi

	# Comprobamos que el directorio existe
	if [ ! -d "$directorio" ]; then
		echo ""
		echo "Error: El directorio '$directorio' no existe"
		return
	fi

	# Comprobamos que se hayan introducido extensiones
	if [ -z "$extensiones" ]; then
		echo ""
		echo "Error: Debes introducir al menos una extensión"
		return
	fi

	echo ""
	echo "========================================"
	echo "Analizando directorio: $directorio"
	echo "========================================"
	echo ""

	# Recorremos cada extensión
	for extension in $extensiones; do
		# Contamos cuántos archivos hay de esa extensión
		contador=$(find "$directorio" -type f -name "*.$extension" 2>/dev/null | wc -l)

		echo "Archivos .$extension: $contador"
	done

	echo ""
	echo "Análisis completado."
}

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
  echo "16. Salir"
  echo ""
  read -p "Seleccione una opcion: " resp

	case $resp in
		1)
			read -p "Que año desea saber si es bisiesto?: " bis
			bisiesto $bis
		;;
		2)
			read -p "Escriba la IP que quiera poner: " ip
			read -p "Escriba la mascara que quiera poner: " masc
			read -p "Escriba la puerta de enlace que quiera poner: " gat
			read -p "Escriba el DNS que quiera poner: " dns
			configurar_red $ip $masc $gat $dns
		;;
		3) adivina ;;
		4) buscar ;;
		5) contar ;;
		6) permisos_octal ;;
		7) romano ;;
		8) automatizar ;;
		9)
			echo ""
			read -p "Nombre que quiera ponerle al fichero: " nom9
			read -p "Tamaño que quiere que tenga (En K): " tam9
			crear $nom9 $tam9
		;;
		10)
			echo ""
			read -p "Nombre que quiera ponerle al fichero: " nom
			read -p "Tamaño que quiere que tenga (En K): " tam
			crear_2 $nom $tam
		;;
		11)
			echo ""
			read -p "Introduzca una palabra para reescribir: " palabra
			reescribir $palabra
		;;
		12) contar_usuarios ;;
		13) quita_blancos ;;
		14)
			echo ""
			read -p "Introduce el carácter a dibujar: " caracter
			read -p "Introduce el número de caracteres por línea (1-60): " num_caracteres
			read -p "Introduce el número de líneas (1-10): " num_lineas
			lineas $caracter $num_caracteres $num_lineas
		;;
		15)
			echo ""
			read -p "Introduce la ruta del directorio a analizar: " directorio
			read -p "Introduce las extensiones a buscar (separadas por espacios): " extensiones
			analizar $directorio $extensiones
		;;
		16) echo "" ;;
		*) echo ""
		   echo "Opcion incorrecta" ;;
	esac
 done
}

menu