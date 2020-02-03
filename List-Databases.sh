#! /bin/bash


function listDatabases () {
    echo -e "\n====== ${yellow}Databases${reset} ======\n"
    for f in `ls data/`
    do 
        echo "- "$f
    done
    echo -e "\n=======================\n"
}

listDatabases