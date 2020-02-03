#!/bin/bash

echo "${yellow}Enter Table Name : ${reset}"
read -p "${red}$currentDB${blue}/${reset} " tableName

function createColumns {
    typeset -i colNum

    echo "${yellow}Enter Number of Columns${reset}"
    read colNum

    if [[ $colNum -eq 0 ]]
    then 
        echo "${red}Number of Columns must be number and greater than 0${reset}"
        createColumns
    elif [[ $colNum =~ [0-9]+ ]]
    then 
        typeset -i i 
        declare -a colArr
        pk=false
        for (( i=0;i<$colNum;++i )){
            echo "${yellow}Enter Column Name : ${reset}"
            read colName
            record=""
            record+=$colName
            if [[ $colName =~ [a-zA-Z_-]+ ]]
            then
            echo "${cyan}"
            select choice in Numbers "string" AlphaNumeric
            do
                case $choice in 
                Numbers)
                    record+=":Numbers"
                    break
                ;;
                "string")
                    record+=":string"
                    break;
                ;;
                AlphaNumeric)
                    record+=":AlphaNumeric"
                    break;
                ;;
                *)
                    echo -e "\n${red}invalid selection\n${yellow}please re enter it\n${reset}"
                ;;
                esac 
            done
            echo "${reset}"
            else 
                echo "${red}Column name must be only characters , _ and -"
                echo "${yellow}please re enter column name${reset}"
                i=$(( $i-1 ))
                continue
            fi
            colArr[i]=$record            
        }
        echo "${yellow}Enter column number to be Primary Key${reset}"
        columnsLength=${#colArr[@]};
        i=0;
        echo "${cyan}"
        while [ $i -lt $columnsLength ]
        do
            echo $(( $i + 1 ))")" ${colArr[i]}
            i=$(( $i + 1 ))
        done
        echo "${reset}"

        typeset -i primaryKeyColumnNum
        primaryKeyColumnNum=0
        while [[ primaryKeyColumnNum -lt 1 || primaryKeyColumnNum -gt $columnsLength ]]
        do 
            read chkPrimaryKeyColumnNumValue
            if [[ $chkPrimaryKeyColumnNumValue =~ [0-9]+ ]]
            then 
                primaryKeyColumnNum=$chkPrimaryKeyColumnNumValue
            else 
                primaryKeyColumnNum=-1
            fi
        done
        i=0;
        while [ $i -lt $columnsLength ]
        do
            if [[ $(( i+1 )) -eq primaryKeyColumnNum ]]
            then 
                colArr[i]=${colArr[i]}":1"
            else
                colArr[i]=${colArr[i]}":0"
            fi
            i=$(( $i + 1 ))
        done
        touch data/$currentDB/tables/$tableName
        touch data/$currentDB/meta-data/$tableName".md"
        i=0;
        while [ $i -lt $columnsLength ]
        do
            echo ${colArr[i]} >> data/$currentDB/meta-data/$tableName".md"
            i=$(( $i + 1 ))
        done
    fi 
    echo -e "\n${blue}$tableName${green} is created successfully${reset}\n"
}


if [[ $tableName =~ [a-zA-Z_-]+ ]]
then 
    if [[ -f data/$currentDB/tables/$tableName ]]
    then 
        echo "${red}table is already Exists${reset}"
    else 
        createColumns
    fi
else 
    echo "${yellow}table name mustn't contains any spaces, numbers or special character${reset}"

fi
