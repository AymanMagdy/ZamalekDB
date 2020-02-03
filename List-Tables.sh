#! /bin/bash

source ./Color-Variables.sh 

function listTables () {
    echo -e "\n====== ${yellow}Tables${reset} ======\n"
    for f in `ls data/$currentDB/tables`
    do 
        echo "- "$f
    done
    echo -e "\n=======================\n"
}

listTables