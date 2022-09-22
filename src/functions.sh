#!/bin/bash

source "$SCRIPT_DIRECTORY/help.sh"

#Color for Outputs
OK='\033[0;32m'
INF='\033[0;33m'
ERR='\033[0;31m'
NC='\033[0m'

# Defaults
OVERRIDE=false
function hr(){
    for i in {1..100}; do echo -n -; done
    echo ""
}

function get_opts(){
    #Input Of Optional Parameters
    while getopts ho flag

    do
        case "${flag}" in
            o) OVERRIDE=true ;;
            h) help
                exit 0 ;;
            *) ;;
        esac
    done


    # DEFINE Variables
    REPO=${GITHUB_REPOSITORY#*/}

    hr
    echo -e "Repository: ${INF}$REPO${NC}"
    echo -e "Running script: ${INF}'`basename $0`'${NC}"
    echo -e "Override: ${INF}$OVERRIDE${NC}"
    hr
}