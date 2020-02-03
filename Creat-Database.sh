#! /bin/bash

source ./Color-Variables.sh 

function creatDatabase () {
    echo -e "\n${yellow}Enter the database name, please!${reset}"
    read databaseName;
    case $databaseName in 
    *[A-Za-z])
        mkdir data/$databaseName > /dev/null 2>&1
        if [ $? -eq 0 ] 
        then 
            mkdir data/$databaseName/tables data/$databaseName/meta-data
            echo -e "\n${green}The database '$databaseName' has been created.${reset}\n"
        else 
            echo -e "\n${red}Couldn't create Database"
            echo -e "The database ${blue}${databaseName}${red} already exists.${reset}\n"
        fi
        ;;
    *)
        echo -e "\n${red}Couldn't create Database"
        echo -e "The name you entered is not a proper name for a database.${reset}\n"
        ;;
    esac
}

creatDatabase