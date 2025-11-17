#!/bin/bash

destino="/bacaaronp"
carpeta="/home"
nombre="CopTot-$(date +%B-%Y).tar.gz"

tar -czf "$destino/$nombre" "$carpeta"
