#! /bin/bash

if [[ -d data ]]
then 
mkdir data
fi

source ./Color-Variables.sh 

function Main-Menu {
    currentDB=""
    PS3="${yellow}Enter Your Choice : ${reset}"

    options=("Creat a DB" "List existing databases" "Use Database" "Drop Databse" "Exit");

    optionsLength=${#options[@]};
    i=0;
    echo "${cyan}"
    while [ $i -lt $optionsLength ]
    do
        echo $(( $i + 1 ))")" ${options[i]}
        i=$(( $i + 1 ))
    done
    echo "${reset}"

    read -p "${yellow}Enter Your Choice : ${reset}" excuteQuery;

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
            source ./Use-Database.sh
        elif [ $excuteQuery -eq 4 ]
        then 
            source ./Drop-Database.sh
        elif [ $excuteQuery -eq 5 ]
        then 
            exit
        fi
        ;;
    *)
        echo "${red}Invalid selection.${reset}"
        ;;
    esac
}
clear
while [[ true ]]
do 
    Main-Menu
done