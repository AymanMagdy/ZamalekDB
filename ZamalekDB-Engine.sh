#! /bin/bash

currentDB=""

# Colors
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`


# Done and tested
function creat_database () {
    echo "Enter the database name, please!"
    read databaseName;
    mkdir data/$databaseName
    mkdir data/$currentDB/tables data/$currentDB/meta-data
    echo "The database '$databaseName' has been created."
}

# Done and tested
function list_databases () {
    cd $HOME/Zamalek\ Database
    ls
}

# Done and tested
function list_tables () {
    echo "Enter the needed database to list its tables"
    cd $HOME/Zamalek\ Database
    read select_database;
    cd $select_database > /dev/null 2>&1
    if [ $? -eq 0 ]
    then 
        ls
    else 
        echo "The database -> '${select_database}' does not exist."
    fi
}

options=("Creat a DB" "List existing databases" "List tables" "Use Database" "Delete Table");

optionsLength=${#options[@]};

i=0;
while [ $i -lt $optionsLength ]
do
    echo $(( $i + 1 ))")" ${options[i]}
    i=$(( $i + 1 ))
done

read excuteQuery;

case $excuteQuery in 
[1-$optionsLength])
    if [ $excuteQuery -eq 1 ]
    then 
        creat_database

    elif [ $excuteQuery -eq 2 ]
    then 
        list_databases
    
    elif [ $excuteQuery -eq 3 ]
    then 
        list_tables
    elif [ $excuteQuery -eq 4 ]
    then 
        source ./Use-Database.sh
        echo $?
    fi
    ;;
*)
    echo "Invalid selection."
    ;;
esac