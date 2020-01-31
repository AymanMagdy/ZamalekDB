#!/bin/bash

#clear
echo "${yellow}Enter Table Name : ${reset}"
read -p "${red}$currentDB${blue}/${reset} " tableName

function createColumns {
    typeset -i colNum

    echo "Enter Number of Columns"
    read colNum

    if [[ $colNum -eq 0 ]]
    then 
        echo "Number of Columns must be number and greater than 0"
        createColumns
    elif [[ $colNum =~ [0-9]+ ]]
    then 
        typeset -i i 
        declare -a colArr
        pk=false
        for (( i=0;i<$colNum;++i )){
            echo "Enter Column Name : "
            read colName
            record=""
            record+=$colName
            if [[ $colName =~ [a-zA-Z-]+ ]]
            then
            select choice in Int String Alphanumeric
            do
                case $choice in 
                Int)
                    record+=":Int"
                    break
                ;;
                String)
                    record+=":String"
                    break;
                ;;
                Alphnumeric)
                    record+=":Alphanumeric"
                    break;
                ;;
                esac 
            done
            else 
                echo "Column name must be only characters and -"
                echo "please re enter column name"
                --i
                continue
            fi
            colArr[i]=$record            
        }
        echo "Enter column number to be Primary Key"
        columnsLength=${#colArr[@]};
        i=0;
        while [ $i -lt $columnsLength ]
        do
            echo $(( $i + 1 ))")" ${colArr[i]}
            i=$(( $i + 1 ))
        done

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
    echo "${blue}$tableName${green} is created successfully${reset}"
}


if [[ $tableName =~ [a-zA-Z]+ ]]
then 
    if [[ -f data/$currentDB/tables/$tableName ]]
    then 
        echo "table is already Exists"
    else 
        createColumns
    fi
else 
    echo "table name mustn't contains any spaces, numbers or special character"

fi
