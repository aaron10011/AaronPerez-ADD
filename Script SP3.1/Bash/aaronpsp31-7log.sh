#!/bin/bash

archivosalida="$HOME/errores_logs.txt"

for archivo in $(find /var/log -type f 2>/dev/null); do

    if sudo grep -qiE "error|fail" "$archivo" 2>/dev/null; then
        echo "" >> "$archivosalida"
        echo "------------------------------------------------------------------------------------" >> "$archivosalida"
        echo "ERRORES ENCONTRADOS EN: $archivo EL: $(date)" >> "$archivosalida"
        echo "------------------------------------------------------------------------------------" >> "$archivosalida"
        sudo grep -iE "error|fail" "$archivo" 2>/dev/null >> "$archivosalida"
        echo "" >> "$archivosalida"
    fi

done

echo ""
echo "Completado!!!"
echo "Los resultados se han guardado en: $archivosalida"
echo ""
