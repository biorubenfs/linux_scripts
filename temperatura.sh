#!/bin/bash
#############################################
# Monitorización de temperatura con sensors #
#############################################

# Funciones ######3##########################

# Imprime el encabezado en la consola
encabezado() {
    echo "########################"
    echo "###### Temperatura #####"
    echo "########################"
	echo ""
	echo "Bienvenido al programa de monitorización de la temperatura"
}

# Pide datos al usuario para realizar las mediciones
# Recoge la fecha y la hora de inicio
# Crea un directorio donde se vuelcan los datos
recopilarParametros() {
	echo -n "Nombre del proyecto -> "
	read nombreProyecto
	mkdir ./$nombreProyecto

	echo "Proyecto $nombreProyecto" >> ./$nombreProyecto/parametros.txt

    echo -n "Introduzca el número de medidas que desea realizar -> "
	read contador
	echo -n "Introduzca el intervalo de tiempo entre cada una de las medidas -> "
	read intervalo
}
# Imprime los datos introducidos por el usuario en la consola y los vuelca a un fichero
# dentro del directorio del proyecto
printDatosGenerales() {
	echo ""
	echo "##############################################"
	echo "## Número medidas: $contador" | tee -a ./$nombreProyecto/parametros.txt
	echo "## Intervalo (s): $intervalo" | tee -a ./$nombreProyecto/parametros.txt
	echo "##############################################"
	echo "Realizando mediciones... Espere." 
	echo ""

	# Se agregan la fecha y la hora al documento de parámetros
	fecha=`date +"%d/%m/%Y"`
	hora=`date +'%H:%M:%S'`

	echo "Fecha: " $fecha >> ./$nombreProyecto/parametros.txt
	echo "Hora Inicio" $hora >> ./$nombreProyecto/parametros.txt
}

# Realiza la medicion. Guarda la fecha y la temperatura en un formato determinado y lo 
# vuelca en un fichero
medida() {
	#fecha=`date +"%d/%m/%Y"`
	hora=`date +'%H:%M:%S'`
	temperatura=`sensors | grep "°C" | cut -d"+" -f2 | cut -d" " -f1 | pr -t -3`
	echo -e $hora'\t'$temperatura >> ./$nombreProyecto/temperatura_log.txt
}

#Escribe un pie de programa y agrega la fecha de finalización al registro de parámetros
pie() {
	hora=`date +'%H:%M:%S'`  
	echo "Hora Final" $hora >> ./$nombreProyecto/parametros.txt
	echo "El programa ha finalizado"
	echo "Los datos se han guardado en el archivo temperatura_log.txt"
}

#Secuencia de funciones
clear
encabezado
recopilarParametros
printDatosGenerales

while [[ "$contador" -gt 0 ]]; do
	medida
	sleep $intervalo
	contador=$(( $contador - 1))
	echo "Quedan $contador mediciones"
done
pie