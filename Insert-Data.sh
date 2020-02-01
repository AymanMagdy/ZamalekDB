#!/bin/bash

function InsertData () {
    mapfile -t arrayMeta < data/$currentDB/meta-data/$currentTB.md
    data=""
    for (( i=0; i<${#arrayMeta[@]}; i++ ))
    do 
        dataType=$(awk -v i="$i" -F: '{if(NR == i+1) print $1}' data/$currentDB/meta-data/$currentTB.md)
        echo "Enter the ${dataType}"
        read colValue;
        if [ $i -gt 0 ]
        then 
            data+=":"
        fi
        data+=$colValue
    done
    echo $data >> data/$currentDB/tables/$currentTB
    echo "Done adding the data to table '${currentTB}'"
}

InsertData