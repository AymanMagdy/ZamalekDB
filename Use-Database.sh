#!/bin/bash

clear
echo "${yellow}Enter Database Name : ${reset}"
read dbName

function list_table {
    tableOptions=("Creat table" "Delete Table" "List tables" "View table Content" "Delete Record");
    optionsLength=${#tableOptions[@]};
    i=0;
    while [ $i -lt $optionsLength ]
    do
        echo $(( $i + 1 ))")" ${tableOptions[i]}
        i=$(( $i + 1 ))
    done
    read excuteQuery;

    case $excuteQuery in 
        [1-$optionsLength])
            if [ $excuteQuery -eq 1 ]
            then 
                source ./Create-Table.sh 
            elif [ $excuteQuery -eq 2 ]
            then 
                source ./Delete-Table.sh
            elif [ $excuteQuery -eq 3 ]
            then 
                source ./List tables.sh
            elif [ $excuteQuery -eq 4 ]
            then 
                source ./View-Table-Content.sh
            elif [ $excuteQuery -eq 5 ]
            then 
                source ./Delete-Record.sh
            fi
        ;;
        *)
            echo "Invalid selection."
        ;;
    esac
}

if [[ -d data/$dbName ]]
then 
    currentDB=$dbName
    echo "${green}switched to $dbName ${reset}" 
    list_table
    return 0;
else 
    echo "${red}$dbName Not Found${reset}"
    return 1;
fi