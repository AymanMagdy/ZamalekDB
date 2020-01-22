#! /bin/bash

# Done and tested
function creat_database () {
    echo "Enter the database name, please!"
    read databaseName;
    cd $HOME/Zamalek\ Database
    mkdir $databaseName
    echo "The database '$databaseName' has been created."
}

function list_databases () {
    cd $HOME/Zamalek\ Database
    ls
}

options=("Creat a DB" "List existing databases");

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
    fi
    ;;
*)
    echo "Not in the list"
    ;;
esac