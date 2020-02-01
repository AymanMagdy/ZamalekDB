#! /bin/bash

source ./Color-Variables.sh 

function listTables () {
    echo "Enter the needed database to list its tables"
    if [ -d /data/$currentDB ]
    then 
        ls /data/$currentDB/tables
    else 
        echo "The database -> '${currentDB}' does not exist."
    fi
}

listTables