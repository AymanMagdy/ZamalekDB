#!/bin/bash

#echo -e "\n${yellow}Enter Database Name : ${reset}\n"
#read dbName

function list_table_menu {

    while [[ true ]]
    do 
        echo -e "${yellow}Choose what want to do : ${reset}"
        tableOptions=("Creat table" "Delete Table" "List tables" "Use Table" "Back to Last Menu");
        optionsLength=${#tableOptions[@]};
        i=0;
        echo "${cyan}"
        while [ $i -lt $optionsLength ]
        do
            echo $(( $i + 1 ))")" ${tableOptions[i]}
            i=$(( $i + 1 ))
        done
        echo "${reset}"
        read -p "${red}$currentDB${blue}/${reset} " excuteQuery;

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
                    source ./List-Tables.sh
                elif [ $excuteQuery -eq 4 ]
                then 
                    source ./Use-Table.sh
                elif [ $excuteQuery -eq 5 ]
                then 
                    return;
                fi
            ;;
            *)
                echo -e "\n${red}Invalid selection.${reset}\n"
            ;;
        esac
    done 
}

function Use-Database {
    while [[ true ]]
    do 
        while [[ true ]]
        do 
            let i=1
            echo -e "\n${yellow}Enter Database Number : ${reset}"
            echo "${cyan}"
            for f in `ls data/` "return to main menu"
            do 
                echo $i") "$f
                i=$(( $i + 1 )) 
            done
            echo "${reset}"
            read DB 
            if [[ $DB -ge 1 && $DB -lt $i ]]
            then 
                if [[ $DB -ge 1 && $DB -lt $(( $i-1 )) ]]
                then 
                    i=1
                    for f in `ls data/`
                    do 
                        if [[ $i == $DB ]]
                        then 
                            currentDB=$f
                            break
                        fi
                        i=$(( $i + 1 )) 
                    done
                else
                    clear
                    return 
                fi
                break;
            else 
                echo -e "\n${red}invalid selection${reset}\n"
            fi
        done 
        
        echo -e "\n"
        list_table_menu
    done    
}

Use-Database