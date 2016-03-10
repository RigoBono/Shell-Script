Actua(){
echo "Usuario Direccion Hora_de_conexion Hora_de_desconexion Tiempo_de_conexion">archSal
while read line
do
	U=$(echo $line | awk '{print $1}')
	D=$(echo $line | awk '{print $5}')
	HC=$(echo $line | awk '{print $4}')
	var=$(last $U -n 1 |awk '{print $10}')
	if [  $var == "in" ]; then
		HD="NA"
		horaA=$(date +"%H:%M")
		TC=$((( $(date -ud $horaA +'%s')-$(date -ud $HC +'%s'))/60))" Minutos"
	else
		HD=$(last $U -n 1 | awk '{print $9}')
		TC=$(last $U -n 1 | awk '{print $10}')
	fi
	echo $U" "$D" "$HC" "$HD" "$TC>>archSal			
done < ListaU
}
Imprime(){
typeset -i cont
cont=3
column -t archSal>imp
while read line;
do
	tput setaf $cont
	echo "$line" 
	cont=cont+1
	if [ $cont == 8 ]; then
		cont=0
	fi
done<imp
tput sgr0
rm archSal imp
}
typeset -i band
band=0
who | wc -l>NumIni
who | uniq |sort -k 4 >ListaU
while [ $band == 0 ]
do
	UsuA=$(who | wc -l)
	UsuI=$(cat NumIni)
	if [ $UsuA -gt $UsuI ]; then
		#who | uniq |sort -k 4 >ListaU
		cp ListaU ListaAux
		rm ListaU
		who | uniq | sort -k 4 -r >NuevoU
		sed -n 1p NuevoU>>ListaAux
		sort ListaAux -k 4 > ListaU
		who | wc -l >NumIni
		rm ListaAux
	fi	
	Actua
	Imprime
	sleep 2
	clear
done
