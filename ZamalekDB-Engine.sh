#! /bin/bash

source ./Color-Variables.sh 


currentDB=""
PS3="${yellow}Enter Your Choice : ${reset}"

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
        source ./Creat-Database.sh

    elif [ $excuteQuery -eq 2 ]
    then 
        source ./List-Databases.sh
    
    elif [ $excuteQuery -eq 3 ]
    then 
        source ./List-Tables
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