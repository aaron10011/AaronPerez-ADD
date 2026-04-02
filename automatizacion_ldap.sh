#!/bin/bash

opcion=-1
while [ $opcion -ne 0 ]; do

	echo -e "\n###########################################"
	echo "#           AUTOMATIZACION LDAP           #"
	echo -e "###########################################\n"

	echo "1. Eliminar correo usuario"
	echo "2. Modificar correo de un usuario"
	echo "3. Realizar una busqueda"
	echo -e "0. Salir\n"

	read -p "Seleccione una opcion (0 - 3): " opcion

	case $opcion in

		0) echo -e "\nSaliendo...\n";;

		1) 	echo ""
			read -p "Nombre del usuario: " usuario
			echo ""

			base_dn="dc=aaronp2025,dc=ldap"
			usuario_dn=$(ldapsearch -x -LLL -b "$base_dn" "uid=$usuario" dn | grep "^dn:" | cut -d' ' -f2-)

			if [ -z "$usuario_dn" ]; then
				echo "Usuario no encontrado."
				break
			fi

			ldapmodify -x -D "cn=admin,dc=aaronp2025,dc=ldap" -W <<EOF
dn: $usuario_dn
changetype: modify
delete: mail
EOF
		;;

		2)	echo ""
			read -p "Nombre del usuario: " usuario_correo
			read -p "Nuevo Correo: " correo

			base_dn="dc=aaronp2025,dc=ldap"
			usuario_dn=$(ldapsearch -x -LLL -b "$base_dn" "uid=$usuario_correo" dn | grep "^dn:" | cut -d' ' -f2-)

			if [ -z "$usuario_dn" ]; then
				echo "Usuario no encontrado."
				break
			fi

			ldapmodify -x -D "cn=admin,dc=aaronp2025,dc=ldap" -W <<EOF
dn: $usuario_dn
changetype: modify
replace: mail
mail: $correo
EOF

		;;

		3)	echo -e "\n==== OPCIONES DE BUSQUEDA ====\n"
			echo "1. Buscar usuario concreto"
			echo -e "2. Listar todos los usuarios\n"

			read -p "Escoga una opcion: " opcion_listado

			if [[ $opcion_listado -eq 1 ]]; then

				echo ""
				read -p "Usuario a buscar: " usu_listado
				echo ""
				ldapsearch -x -LLL -b "dc=aaronp2025,dc=ldap" "(uid=$usu_listado)" uid mail | grep -E "^(uid|mail):"

			elif [[ $opcion_listado -eq 2 ]]; then

				echo ""
				ldapsearch -x -LLL -b "dc=aaronp2025,dc=ldap" "(uid=*)" uid mail | grep -E "^(uid|mail):"

			else

				echo -e "\nOpcion incorrecta, vuelva a intentarlo. Solo son validas las opciones 1 y 2.\n"

			fi

		;;

		*) echo -e "\nOPCION INCORRECTA, por favor, elija una opcion entre 0 y 3.\n" ;;
	esac
done
