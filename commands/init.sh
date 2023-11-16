function init(){

    if [ $# -eq 0 ] || [ $1 = "help" ]; then
        init_help;
    fi

    local error_message='';
    local __do_copy=false;

    while [ $# -gt 0 ]; do
        error_message="Error: a value is needed for '$1'"
        case $1 in
            -o | --origin)
                __origin=${2:?$error_message}
                shift 2;
            ;;

            -d | --destination)
                __destination=${2:?$error_message}
                shift 2;
            ;;

            -c | --copy)
                __do_copy=true
                shift 1;
            ;;

            *)
                echo "Error: Unknown option $1"
                exit 1;
            ;;
        esac
    done

    # Test if both values are set
    if [ -z $__destination ]; then
        echo "Error: must specify a destination directory"
        exit 1;
    fi

    if [ -z $__origin ]; then
        echo "Error: must specify an origin directory"
        exit 1;
    fi

    # Test if both values are directories
    for d in $__origin $__destination; do
        if [ ! -d $d ]; then
            echo "Error: $d is not a directory"
            exit 1;
        fi
    done

    # Test if the user set the same directories (the sed removes the ./ in front of and the / at the end)
    if [ $(echo $__origin | sed 's/^\.\///; s/\/$//') = $(echo $__destination | sed 's/^\.\///; s/\/$//') ]; then
        echo "Error: must specify two different directories"
        exit 1;
    fi

    # Test if the synchro file is created, if not, it creates the file
    if [ ! -f $SYNCHRO_FILE ]; then
        echo "File $SYNCHRO_FILE does not exist. Creating one."
        touch $SYNCHRO_FILE
    fi

    # Store data into the synchro file
    echo "$__origin $__destination $(date | sed 's/ /-/g')" > $SYNCHRO_FILE

    # Copy the folder if the user asked for it
    if [ $__do_copy = true ]; then
        copy $__origin $__destination
    else
        echo "Info: use fsync push to copy the content of $__origin to $__destination"
    fi

    exit 0;
}

function init_help(){
    echo "this is the help"
    exit 0;
}