#!/bin/bash

function table-Function-List {
    tableOptions=("Insert" "Modify" "Delete" "View Table Content" "Select");
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
                # insert
                source ./Insert-Data.sh
            elif [ $excuteQuery -eq 2 ]
            then 
                # Modify
                source ./Update-Table.sh
            elif [ $excuteQuery -eq 3 ]
            then 
                source ./Delete-Record.sh
            elif [ $excuteQuery -eq 4 ]
            then 
                source ./View-Table-Content.sh
            elif [ $excuteQuery -eq 5 ]
            then 
                # select
                source ./Select-Based-PK.sh
            fi
        ;;
        *)
            echo "Invalid selection."
        ;;
    esac
    table-Function-List
}

table-Function-List