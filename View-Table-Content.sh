#!/bin/bash

select choice in `ls data/$currentDB/tables` "return to main menu"
do 
    if [[ $choice =~ [a-zA-Z]+ && -f data/$currentDB/tables/$choice ]]
    then 
        sed -n 'p' data/$currentDB/tables/$choice
        echo 
        return 
    elif [[ $choice =~ [a-zA-Z]+ ]]
    then 
        return
    else
        echo "${red}Not Found${reset}"
    fi
done