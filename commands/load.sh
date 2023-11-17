function load(){

    if [ $1 = "help" ] || [ $# -eq 0 ]; then
        load_help;
    fi

    echo $@
}

function load_help(){
    echo "Help of the load"
    exit 0;
}