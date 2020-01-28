#! /bin/bash

# Done and tested
function creat_database () {
    echo "Enter the database name, please!"
    read databaseName;
    cd $HOME/Zamalek\ Database
    mkdir $databaseName
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

options=("Creat a DB" "List existing databases" "List tables" "Use Database");

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
    fi
    ;;
*)
    echo "Invalid selection."
    ;;
esac