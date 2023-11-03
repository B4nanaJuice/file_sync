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
        f_dir=$2
        s_dir=$3
        echo "First dir: $f_dir"
        echo "Second dir: $s_dir"
        ;;

        o) # Set the origin of the copy
        echo "Test of the origin"
        origin=$OPTARG
        ;;

        c) # Set where the copied files will be put
        if [ "$mode" = "refresh" ]; then
            echo "Error: You can use this option only when creating the synchronisation"
            exit
        fi
        copy_output=$OPTARG
        echo coucou toi
        ;;

        \?) # Invalid option
            echo "Error: Invalid option"
            exit;;
    esac
done


if [ "$mode" = "init" ]; then
    ls $copy_output
elif [ "$mode" = "refresh" ]; then
    ls $origin
fi