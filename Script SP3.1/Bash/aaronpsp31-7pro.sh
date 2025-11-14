#!/bin/bash

archivo="programas.txt"

if [ ! -f $archivo ]; then		# Comprobamos si existe el fichero programas.txt
	echo -e "\nNo se encontró el archivo $archivo en el mismo directorio del script...\n"
fi

for programa in $(cat $archivo); do		# Leemos cada linea del fichero programas.txt

	echo -e "\nEliminando: $programa..."
	sudo apt remove -y "$programa" >/dev/null 2>/dev/null		# Eliminamos el programa de forma silenciosa enviando la salida y error /dev/null

	if ! dpkg -s "$programa" >/dev/null 2>/dev/null; then		# Comprobamos si el programa sigue instalado con dpkg
		echo -e "Programa eliminado o no instalado"
	else
		echo -e "No se pudo eliminar el programa $programa"
	fi
done

echo -e "\nEjcución del script finalizada\n"
