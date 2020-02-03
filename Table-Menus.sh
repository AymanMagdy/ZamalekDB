#!/bin/bash

function table-Function-List {
    tableOptions=("Insert" "Modify" "Delete" "View Table Content" "Select" "Back to Last Menu");
    optionsLength=${#tableOptions[@]};
    i=0;
    echo "${cyan}"
    while [ $i -lt $optionsLength ]
    do
        echo $(( $i + 1 ))")" ${tableOptions[i]}
        i=$(( $i + 1 ))
    done
    echo "${reset}"
    read -p "${red}$currentDB${blue}/${red}$currentTB${blue}/${reset} " excuteQuery;

    case $excuteQuery in 
        [1-$optionsLength])
            if [ $excuteQuery -eq 1 ]
            then 
                source ./Insert-Data.sh
            elif [ $excuteQuery -eq 2 ]
            then 
                source ./Update-Table.sh
            elif [ $excuteQuery -eq 3 ]
            then 
                source ./Delete-Record.sh
            elif [ $excuteQuery -eq 4 ]
            then 
                source ./View-Table-Content.sh
            elif [ $excuteQuery -eq 5 ]
            then 
                source ./Select-Based-PK.sh
            elif [ $excuteQuery -eq 6 ]
            then 
                return;
            fi
        ;;
        *)
            echo "${red}Invalid selection.${reset}"
        ;;
    esac
    table-Function-List
}

table-Function-List