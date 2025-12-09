#!/bin/bash

old_process=$(ps -eo command)									# Para ver todos los procesos de la maquina

while true; do
	new_process=$(ps -eo command)								# En ese lapso de tiempo pillo nuevos procesos
	diff <(echo "$old_process") <(echo "$new_process") | grep -v -E " procmon|command"	# Los comparo y muentro las diferencias pero sin ver los procesos de este Script
	old_process=$new_process								# Los intercambio para que se vaya actualizando
done

# Para buscar procesos en concretos, parar la ejecucion de esto con crtl+c
# y buscar el proceso con crtl+shift+f
