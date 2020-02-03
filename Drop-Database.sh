#!/bin/bash
echo "${cyan}"
select choice in `ls data/` "return to main menu"
do 
    if [[ $choice =~ [a-zA-Z]+ && -d data/$choice ]]
    then 
        rm -r data/$choice  
        echo -e "\n${blue}$choice${green} deleted successfully${reset}\n" 
        return 
    elif [[ $choice =~ [a-zA-Z]+ && $choice == "return to main menu" ]]
    then 
        return
    else
        echo -e "\n${red}Not Found${reset}\n"
    fi
done
echo "${reset}"