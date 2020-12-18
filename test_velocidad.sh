#!/bin/bash
# Aplicación speedtest
clear

#Funciones
header() {
        echo -e "\e[0;32m########################"
        echo -e "#### Internet Speed ####"
        echo -e "########################\e[0m"
}

recopilarParametros() {
	echo -n "Nombre del proyecto -> "
	read nombreProyecto
	mkdir ./$nombreProyecto

	#echo "Proyecto $nombreProyecto" >> ./$nombreProyecto/parametros.csv

     	echo -n "Número de medidas que desea realizar -> "
	read contador
	echo -n "Intervalo de tiempo entre cada una de las medidas (en segundos) -> "
	read intervalo
}

headerTable() {
	echo -e "fecha\thora\tbajada\tsubida" >> ./$nombreProyecto/medidas.csv
	echo "Realizando medidas..."
}

medida() {

	#Obtener fecha
	fecha=`date +"%d/%m/%y"`

	#Obtener hora
	hora=`date +'%H:%M:%S'`

	#Obtener velocidad
	speedtest > ./$nombreProyecto/raw_data_temp # Ejecuta el comando speedtest y guarda la salida en un fichero temporal que luego se borra.
	exitstatus=$?
	
	if [ $exitstatus -eq 0 ]; then
		down=`cat ./$nombreProyecto/raw_data_temp | grep Download | cut -d" " -f2`
		up=`cat ./$nombreProyecto/raw_data_temp | grep Upload | cut -d" " -f2`
		echo -e $fecha' '$hora'\t'$down'\t'$up >> ./$nombreProyecto/medidas.csv
	else 
		down="null"
		up="null"		
		echo -e $fecha' '$hora'\t'$down'\t'$up >> ./$nombreProyecto/medidas.csv
	fi
}

footer() {
	echo "La tarea ha finalizado"
	echo "¿Desea conservar los datos crudos? (Y/N)"
	read respuesta
	if [ $respuesta != "Y" ]; then
		rm ./$nombreProyecto/raw_data_temp
	fi
}


# Secuencia de funciones
header
recopilarParametros
headerTable
while [[ "$contador" -gt 0 ]]; do
	medida
	sleep $intervalo
	contador=$(( $contador - 1))
done
#footer

echo "¡Buen día!"

#checkSpeedtest() {
#	if [ `which speedtest`]; then
#		#bucle while
#	else
#		echo "La utilidad speedtest no está instalada. ¿Desea instalarla? (Y/N)"
#		read resp
#		if [ $resp != "Y" ]; then
#			sudo apt-get install speedtest-cli
#		else
#			echo ""
#		fi
#	fi
	
	# Esta función debe comprobar si la aplicación speedtest está instalada.
	# Si no lo esta, ofrecer la posibilidad de instalarlo.
	#sudo apt-get install speedtest-cli
#}