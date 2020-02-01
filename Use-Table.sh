#!/bin/bash

select choice in `ls data/$currentDB/tables/`
do
     if [[ $choice =~ [a-zA-Z]+ && -f data/$currentDB/tables/$choice ]]
        then 
            currentTB=$choice 
            source ./Table-Menus.sh
            return 
        elif [[ $choice =~ [a-zA-Z]+ ]]
        then 
            return
        else
            echo "${red}Not Found${reset}"
    fi
done