#! /bin/bash

mode=""
while getopts ":ir:o:c:" option; do
    case $option in
        i) # Initialize the synchro
        if [ "$mode" = "refresh" ]; then
            echo "Error: "
            exit
        fi

        mode="init"
        ;;

        r) # Actualize the two directories
        if [ "$mode" = "init" ]; then
            echo "Error: 2"
            exit
        fi

        mode="refresh"
        directories=$OPTARG # Directories in double quotes and will be splited later
        ;;

        o) # Set the origin of the copy
        origin=$OPTARG

        if [ ! -d $origin ]; then 
            echo "Error: $origin is not a directory"
            exit
        fi
        ;;

        c) # Set where the copied files will be put
        if [ "$mode" = "refresh" ]; then
            echo "Error: You can use this option only when creating the synchronisation"
            exit
        fi

        copy_output=$OPTARG

        if [ ! -d $copy_output ]; then
            echo "Error: $copy_output is not a directory"
            exit
        fi
        ;;

        \?) # Invalid option
            echo "Error: Invalid option"
            exit;;
    esac
done

if [ "$mode" = "init" ]; then
    # Do all the things when it's on init
    if [ "$origin" = "" ]; then
        echo "Error: Must provide an origin directory"
        exit
    fi

    if [ "$copy_output" = "" ]; then
        echo "Error: Must provide a destination directory"
        exit
    fi


elif [ "$mode" = "refresh" ]; then
    # Do all the things for the refresh
    set $directories

    if [ $# -ne 2 ]; then
        echo "Error: Must provide 2 folders"
        exit
    fi

    if [ ! -d $1]; then
        echo "Error: $1 is not a directory"
        exit
    fi

    if [ ! -d $2 ]; then
        echo "Error: $2 is not a directory"
        exit
    fi

    # Check for the folder that is different
    # Set it as the origin folder
    


    # Copy the content of the origin folder to the other folder
    # Pour la copie du directory
    # Mise en place d'un dossier temporaire pour la copie (à voir si on peut pas copier directement en changeant le nom)
    # mkdir .temp
    # cp -rp $origin ./.temp -> r = recursive, p = keep the permissions
    # rm -r $copy_output
    # mv ./.temp/$origin ./$copy_output
    # rm -r ./.temp

    

    # Refresh the content of the .synchro file

fi