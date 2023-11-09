#! /bin/bash

sub_command=$1

case $sub_command in
    init | initialize)
        echo "Init"
    ;;

    pull | get)
        echo "Pull"
    ;;

    save)
        echo "Save"
        echo -n "enter subcommand:"
        read t

        echo "you entered $t"
    ;;

    load)
        echo "Load"
    ;;

    *)
    echo "Error: Invalid subcommand"
    exit;;
esac