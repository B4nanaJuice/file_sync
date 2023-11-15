#! /bin/bash

SYNCHRO_FILE=.synchro

function copy(){
    echo $@
}

function main(){
    if [ $# -eq 0 ]; then
        echo t
        exit
    fi

    case $1 in
        init | push | save | load) # Test if it's one of the commands
            source "commands/$1.sh" # Import the content of the file depending on the given sub command
            $1 "${@:2}"            # Call the function linked to the sub command with arguments
        ;;

        *)
            echo "Error: Invalid subcommand (expected init, push, save or load but got $1)"
            exit
        ;;
    esac
}

main "$@";