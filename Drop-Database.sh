#!/bin/bash

select choice in `ls data/` "return to main menu"
do 
    if [[ $choice =~ [a-zA-Z]+ && -d data/$choice ]]
    then 
        rm -r data/$choice  
        echo "${blue}$choice${green} deleted successfully${reset}" 
        return 
    elif [[ $choice =~ [a-zA-Z]+ ]]
    then 
        return
    else
        echo "${red}Not Found${reset}"
    fi
done