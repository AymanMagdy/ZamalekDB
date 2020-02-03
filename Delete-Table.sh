#!/bin/bash
echo "${cyan}"
select choice in `ls data/$currentDB/tables/` "return to main menu"
do 
    echo "${reset}"
    if [[ $choice =~ [a-zA-Z]+ && -f data/$currentDB/tables/$choice ]]
    then 
        rm data/$currentDB/tables/$choice
        rm data/$currentDB/meta-data/$choice.md
        echo -e "\n${blue}$choice${green} deleted successfully${reset}\n" 
        return 
    elif [[ $choice =~ [a-zA-Z]+ && $choice == "return to main menu" ]]
    then 
        echo -e "\n"
        return
    else
        echo -e "\n${red}Not Found${reset}\n"
    fi
done