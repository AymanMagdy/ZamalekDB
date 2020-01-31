#!/bin/bash

clear
echo "Enter Table Name : "
read tableName

if [[ $tableName =~ [a-zA-Z]+ ]]
then 
    if [[ -f data/$currentDB/tables/$tableName ]]
    then 
        rm data/$currentDB/tables/$tableName
        rm data/$currentDB/meta-data/$tableName.md
    else 
        echo "$tableName not Found"
    fi
else 
    echo "table name mustn't contains any spaces, numbers or special character"

fi
