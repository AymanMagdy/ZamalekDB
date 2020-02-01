#! /bin/bash

source ./Color-Variables.sh 

function listTables () {
    if [ -d data/$currentDB ]
    then 
        ls data/$currentDB/tables
    else 
        echo "The database -> '${currentDB}' does not exist."
    fi
}

listTables