#!/bin/bash

destino="/bacaaronp"
carpeta="/home"
nsemana=$(date +%V)
nombre="CopDifSem-$nsemana.tar.gz"

tar -cz --newer-mtime="$(date -d 'last month' '+%Y-%m-%d')" -f "$destino/$nombre" "$carpeta"

# --newer-mtime --> Solo copia los archivos que fueron modificados/creados hace un mes (en este caso)

# -c --> para que empaquete en extension .tar

# -z --> para que comprima el archivo con gzip (.gz)
