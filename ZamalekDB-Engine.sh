#! /bin/bash

source ./Color-Variables.sh 

currentDB=""
PS3="${yellow}Enter Your Choice : ${reset}"


# Done and tested
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

# Done and tested
function listDatabases () {
    ls data/
}

# Done and tested
function listTables () {
    echo "Enter the needed database to list its tables"
    if [ -d /data/$currentDB ]
    then 
        ls /data/$currentDB/tables
    else 
        echo "The database -> '${currentDB}' does not exist."
    fi
}

options=("Creat a DB" "List existing databases" "List tables" "Use Database" "Drop Databse");

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
        creatDatabase

    elif [ $excuteQuery -eq 2 ]
    then 
        listDatabases
    
    elif [ $excuteQuery -eq 3 ]
    then 
        listTables
    elif [ $excuteQuery -eq 4 ]
    then 
        source ./Use-Database.sh
    elif [ $excuteQuery -eq 5 ]
    then 
        source ./Drop-Database.sh
    fi
    ;;
*)
    echo "Invalid selection."
    ;;
esac