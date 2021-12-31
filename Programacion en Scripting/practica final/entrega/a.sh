#!/bin/sh                                                                       

url=https://analisi.transparenciacatalunya.cat/api/views/6izj-g3sb/rows.csv
file=rows.csv

echo URL de descarga
echo $url
echo numero de columnas
csvcut -n $file | wc -l
echo numero de registros
wc -l $file

while getopts v opt
do      case $opt in
                v)
                echo Formato del Archivo
                echo $file | cut -f2 -d'.'
                echo Tipo de Datos
                csvstat $file --type ;;
        esac
