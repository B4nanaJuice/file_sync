#! /bin/bash

# tester si il y a deux arguments
if [ $# -ne 2 ]; then
    echo "Merci d'entrer deux arguments"
    exit
fi

# tester si le premier argument est bien un dossier
if [ ! -d $1 ]; then
    echo "$1 n'est pas un directory"
    exit
fi

# tester si le deuxième argument est bien un dossier
if [ ! -d $2 ]; then
    echo "$2 n'est pas un directory"
    exit
fi

# On entend par métadonnées le type, les permissions du fichier p, 
# la taille de p ainsi que la date de dernière modification de p.

# Format
# first second x--------- size date mois heure
# Avec x le type de fichier (fichier ou dossier)

# récupérer les informations contenues dans le fichier .synchro
cat .synchro > xargs set
first_dir=$1
second_dir=$2
permissions=$3
size=$4
date=$5
month=$6
hour=$7



