
ArchivoCP=""
RESPALDO=""
ESC=""
Len="${LANG%'_'*}"
FILENAME=archivos.txt
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
find ~/ -type f -iregex ".*\.\(c\|txt\|cpp\|sh\|c++\|ppt\|doc\|xls\)" -not -name Practica1.sh -exec cp --backup=numbered -v {} $RESPALDO \;
cd $ESC
tar -c "RESPALDO" | bzip2 > $(date +%d-%m-%Y).tar.bz2  && rm -Rf $RESPALDO

