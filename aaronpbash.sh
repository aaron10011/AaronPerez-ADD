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

	   if [[ $(( $bis % 4 -eq 0 && $(( $bis % 100 )) -ne 0 || $(( $bis % 400 )) -eq 0 ]]; then
		echo ""
		echo "El año $bis es bisiesto"
	   else
		echo ""
		echo "El año $bis no es bisiesto"
	   fi

    	;;
    	*) echo "Incorrecto"

   	esac
  done
