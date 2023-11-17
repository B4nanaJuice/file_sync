function save(){

    if [ $# -eq 0 ] || [ $1 = "help" ]; then
        save_help;
    fi

    local error_message='';

    while [ $# -gt 0 ]; do
        error_message="Error: a value is needed for '$1'"
        case $1 in
            -o | --origin)
                __origin=${2:?$error_message}
                shift 2;
            ;;

            -v | --version)
                __version=${2:?$error_message}
                shift 2;
            ;;

            *)
                echo "Error: Unknown option $1"
                exit 1;
            ;;
        esac
    done

    # Test if origin directory is set
    if [ -z $__origin ]; then 
        echo "Error: must specify an origin directory"
        exit 1;
    fi

    # Test if origin is in the synchro file
    if [[ $(echo $__origin | sed 's/^\.\///; s/\/$//') != $(awk '{print $1}' $SYNCHRO_FILE) ]] && [[ $(echo $__origin | sed 's/^\.\///; s/\/$//') != $(awk '{print $2}' $SYNCHRO_FILE) ]]; then
        echo "Error: $__origin is not in the synchro file"
        exit 1;
    fi

    # Test if backup directory exists
    if [ ! -d $BACKUP_DIRECTORY ]; then
        echo "Directory $BACKUP_DIRECTORY does not exist. Creating one."
        mkdir $BACKUP_DIRECTORY
    fi

    # Test the version
    # If the version is not set -> take the last directory and add 1 to the last digit
    # If the version is set and the backup already exist -> Cancel 
    # If the version is set and the dir doesn't exist, create and copy everything
    if [ -z $__version ]; then

        # Test if the backup directory is empty or not
        # If it's empty -> the first backup directory will be 0.0.1
        # If it's not -> get the newest backup and add 1 to the last digit of the version
        if [[ $(ls -1q $BACKUP_DIRECTORY | wc -l) -eq 0 ]]; then
            __version="0.0.1"
        else
            # Get the last directory (most recent)
            local __last_directory=$(ls -Art $BACKUP_DIRECTORY | tail -n 1)
            __version=$(echo $__last_directory | awk -F\. 'BEGIN{OFS="."} {$NF+=1; print}')
        fi

        echo "The version of this backup will be $__version"
    else
        if [ -d $BACKUP_DIRECTORY/$__version ]; then
            echo "Error: the version $__version already exists"
            exit 1;
        fi
    fi

    # Create the backup
    # - Create the new directory named with the version
    # - Copy everything from the origin directory to the new directory
    mkdir $BACKUP_DIRECTORY/$__version
    copy $__origin $BACKUP_DIRECTORY/$__version

    echo "The backup has been successfully created !"
    exit 0;
}

function save_help(){
    echo "Help of the save"
    exit 0;
}