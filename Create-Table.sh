#!/bin/bash

clear
echo "Enter Table Name : "
read tableName

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
            select choice in Int String Alphnumeric
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
                    record+=":Alphnumeric"
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
            echo $primaryKeyColumnNum" = "$columnsLength
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

        i=0;
        while [ $i -lt $columnsLength ]
        do
            echo $(( $i + 1 ))")" ${colArr[i]}
            i=$(( $i + 1 ))
        done

        touch $tableName
        cd ../meta-data
        touch $tableName".md"

        i=0;
        while [ $i -lt $columnsLength ]
        do
            echo ${colArr[i]} >> $tableName".md"
            i=$(( $i + 1 ))
        done
    fi 
    return ;
}

function chkTablesDir {
    if test ! -d tables
    then 
        mkdir tables meta-data 
    fi
    cd tables 
}

if [[ $tableName =~ [a-zA-Z]+ ]]
then 
    chkTablesDir
    if [[ -f $tableName ]]
    then 
        echo "table is already Exists"
    else 
        createColumns
    fi
else 
    echo "table name mustn't contains any spaces, numbers or special character"

fi
