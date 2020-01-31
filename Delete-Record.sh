#!/bin/bash

currentTable=""

function selectTable {
    select choice in `ls data/$currentDB/tables` "return to main menu"
    do 
        if [[ $choice =~ [a-zA-Z]+ && -f data/$currentDB/tables/$choice ]]
        then 
            currentTable=$choice 
            return 
        elif [[ $choice =~ [a-zA-Z]+ ]]
        then 
            return
        else
            echo "${red}Not Found${reset}"
        fi
    done
}

function deleteRecord {
    selectTable
    primaryKeyFieledNum=`awk -F: '{if ($3==1) print NR;}' data/$currentDB/meta-data/$currentTable.md` 
    primaryKeyFieledName=`awk -F: '{if ($3==1) print $1;}' data/$currentDB/meta-data/$currentTable.md` 
    read -p "Enter $primaryKeyFieledName value to delete the record : " val 

    isExist=$(awk -F: -v fieledNum=$primaryKeyFieledNum -v fieledVal=$val 'BEGIN{isFounded=0;} {if ($fieledNum==fieledVal){ isFounded=1; }} END {print isFounded;}' data/$currentDB/tables/$currentTable)
    
    if [[ $isExist == 1 ]]
    then 
        recordNumber=$(awk -F: -v fieledNum=$primaryKeyFieledNum -v fieledVal=$val 'BEGIN{recordNumber=0;} {if ($fieledNum==fieledVal){ recordNumber=NR; }} END {print recordNumber;}' data/$currentDB/tables/$currentTable)
        sed -i "$recordNumber d" data/$currentDB/tables/$currentTable
        echo "${green}one Record is deleted${reset}"
    else
        echo "${red}Not found any record match $val${reset}"
    fi
}

deleteRecord