#!/bin/bash

select choice in `ls data/$currentDB` "return to main menu"
do 
    if [[ $choice =~ [a-zA-Z]+ && -d data/$currentDB/$choice ]]
    then 
        rm data/$currentDB/tables/$choice  
        rm data/$currentDB/meta-data/$choice  
        echo "${blue}$choice${green} deleted successfully${reset}" 
        return 
    elif [[ $choice =~ [a-zA-Z]+ ]]
    then 
        return
    else
        echo "${red}Not Found${reset}"
    fi
done