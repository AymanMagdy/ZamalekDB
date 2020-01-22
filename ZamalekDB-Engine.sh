#! /bin/bash

# Done and tested
function creat_database () {
    echo "Enter the database name, please!"
    read databaseName;
    mkdir $databaseName
    echo "The database '$databaseName' has been created."
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
    fi
    ;;
*)
    echo "Not in the list"
    ;;
esac