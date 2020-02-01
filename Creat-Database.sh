#! /bin/bash

source ./Color-Variables.sh 

function creatDatabase () {
    echo "Enter the database name, please!"
    read databaseName;
    case $databaseName in 
    *[A-Za-z])
        mkdir data/$databaseName > /dev/null 2>&1
        if [ $? -eq 0 ] 
        then 
            mkdir data/$databaseName/tables data/$databaseName/meta-data
            echo "The database '$databaseName' has been created."
        else 
            echo "${red}The database '${databaseName}'' already exists.${reset}"
        fi
        ;;
    *)
        echo "${red}The name you entered is not a proper name for a database.${reset}"
        ;;
    esac
}

creatDatabase