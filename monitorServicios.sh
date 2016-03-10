imprime_servicios(){
service --status-all>Servicios
while read line
do
	set -- "$line"
	IFS=" "; declare -a Columnas=($*)
	status=${Columnas[1]}
	nombre=${Columnas[3]}
	if [ $status == "+" ]; then
		tput setaf 2
	else
		tput setaf 1
	fi
	echo $nombre
	tput sgr0
done<Servicios
imprime_opciones
}
imprime_opciones(){
echo "1 ->Activar/Desactivar Servicio 2->Salir"
read opcion
ejecuta $opcion
}
activa_desactiva(){
Ser=$1
servicio=$(grep $Ser Servicios)
set -- "$servicio"
IFS=" "; declare -a Partes=($*)
if [ ${Partes[1]} == "+" ]; then
	service "$Ser" stop
	echo "Servicio detenido"
else 
	service "$Ser" start
	echo "Servicio iniciado"
fi
sleep 2
imprime_servicios
}
ejecuta(){
if [ $1 == "1" ]; then
	echo "Servicio:"
	read serv
	activa_desactiva $serv
fi
}
imprime_servicios
