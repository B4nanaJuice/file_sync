function init(){
    if [ $# -eq 0 ] || [ $1 = "help" ]; then
        push_help;
    fi

    local error_message='';

    while [ $# -gt 0 ]; do
        error_message="Error: a value is needed for '$1'"
        case $1 in
            -o | --origin)
                __origin=${2:?$error_message}
                shift 2;
            ;;

            -c | --copy)
                __copy=${2:?$error_message}
                shift 2;
            ;;

            *)
                echo "Error: Unknown option $1"
                exit 1;
            ;;
        esac
    done

    # Test if both values are set
    if [ -z $__copy ]; then
        echo "Error: must use the option -c or --copy"
        exit 1;
    fi

    if [ -z $__origin ]; then
        echo "Error: must use the option -o or --origin"
        exit 1;
    fi

    # Test if both values are directories
    for d in $__origin $__copy; do
        if [ ! -d $d ]; then
            echo "Error: $d is not a directory"
            exit 1;
        fi
    done

    # Test if the user set the same directories (the sed removes the ./ in front of and the / at the end)
    if [ $(echo $__origin | sed 's/^\.\///; s/\/$//') = $(echo $__copy | sed 's/^\.\///; s/\/$//') ]; then
        echo "Error: must specify two different directories"
        exit 1;
    fi

    if [ ! -f $SYNCHRO_FILE ]; then
        echo "File .synchro does not exist. Creating one."
        touch .synchro
    fi

    echo "$__origin $__copy $(date | sed 's/ /-/g')" > $SYNCHRO_FILE

    copy A B

    exit 0;
}

function push_help(){
    echo "this is the help"
    exit 0;
}