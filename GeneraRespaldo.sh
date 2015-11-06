#6/11/2015
#Script que generara un  respaldo de los archivos con extensiones: c\|txt\|cpp\|sh\|c++\|ppt\|doc\|xls\
#del usuario loggeado, guardando el resultado en una carpeta comprimida en el escritorio, teniendo como nombre
#la fecha en que se ejecuto el script, es muy basico, tiene errores, si lo pueden mejorar, por favor haganlo y 
# por favor compartan esa mejora. Gracias.
ArchivoCP=""
RESPALDO=""
ESC=""
#Obtencion del idioma de la maquina
Len="${LANG%'_'*}"
FILENAME=archivos.txt
#Funcion que crea el escritorio si no existe y las carpetas necesarias
validaEscritorio(){
if [ $Len == 'es' ]; then
	echo "Español"
	echo $Len
	if [ -d '~/Escritorio' ]; then
		mkdir ~/Escritorio/RESPALDO
	else
		mkdir ~/Escritorio
		mkdir ~/Escritorio/RESPALDO
	fi
	RESPALDO=~/Escritorio/RESPALDO/	
	ESC=~/Escritorio/
else
	echo "Ingles"
	echo Len
	if [ -d "~/Desktop" ]; then
		mkdir ~/Desktop/RESPALDO
	else
		mkdir ~/Desktop
		mkdir ~/Desktop/RESPALDO
	fi
	RESPALDO=~/Desktop/RESPALDO/
	ESC=~/Desktop/
fi
}
validaEscritorio
#Busca los archivos a respaldar
find ~/ -type f -iregex ".*\.\(c\|txt\|cpp\|sh\|c++\|ppt\|doc\|xls\)" -not -name Practica1.sh -exec cp --backup=numbered -v {} $RESPALDO \;
cd $ESC
#Guarda los archivos encontrados
tar -c "RESPALDO" | bzip2 > $(date +%d-%m-%Y).tar.bz2  && rm -Rf $RESPALDO

