#!/bin/bash

name_compressed=$(7z l data.gzip | grep -A 2 "Name" | tail -n 1 | awk 'NF{print $NF}')						# Se lista lo que se puede descomprimir y se muestra solo eso
7z x data.gzip > /dev/null 2>&1																				# Se extrae y se quita el resto del output o errores 

while true; do										
	7z l $name_compressed > /dev/null 2>&1																	# Se lista lo que se puede descomprimir del anterior que se descomprimio y se quitan errores de output

	if [ "$(echo $?)" == "0"  ]; then																		# Si el comando da error se va al else, esto porque si no se puede descomprimir un archivo da error y asi paramos el bucle
		decompressed_next=$(7z l $name_compressed | grep -A 2 "Name" | tail -n 1 | awk 'NF{print $NF}')		# Se lista lo que se puede descomprimir y se muestra solo eso
		7z x $name_compressed > /dev/null 2>&1 && name_compressed=$decompressed_next						# Se extrae el y se quita resto del output o errores quitan
	else
		exit 1																								# Simulamos salida 1 y para el bucle
	fi
done

