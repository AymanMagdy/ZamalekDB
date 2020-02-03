#!/bin/bash


function deleteRecord {
    primaryKeyFieledNum=`awk -F: '{if ($3==1) print NR;}' data/$currentDB/meta-data/$currentTB.md` 
    primaryKeyFieledName=`awk -F: '{if ($3==1) print $1;}' data/$currentDB/meta-data/$currentTB.md` 
    read -p "${yellow}Enter $primaryKeyFieledName value to delete the record : ${reset}" val 

    isExist=$(awk -F: -v fieledNum=$primaryKeyFieledNum -v fieledVal=$val 'BEGIN{isFounded=0;} {if ($fieledNum==fieledVal){ isFounded=1; }} END {print isFounded;}' data/$currentDB/tables/$currentTB)
    
    if [[ $isExist == 1 ]]
    then 
        recordNumber=$(awk -F: -v fieledNum=$primaryKeyFieledNum -v fieledVal=$val 'BEGIN{recordNumber=0;} {if ($fieledNum==fieledVal){ recordNumber=NR; }} END {print recordNumber;}' data/$currentDB/tables/$currentTB)
        sed -i "$recordNumber d" data/$currentDB/tables/$currentTB
        echo "${green}one Record is deleted${reset}"
    else
        echo "${red}Not found any record match $val${reset}"
    fi
}

deleteRecord