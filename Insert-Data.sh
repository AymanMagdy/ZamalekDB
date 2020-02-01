#!/bin/bash
shopt -s extglob
LC_ALL=C

function InsertData () {
    mapfile -t arrayMeta < data/$currentDB/meta-data/$currentTB.md
    data=""
    for (( i=0; i<${#arrayMeta[@]}; i++ ))
    do 
        colName=$(awk -v i="$i" -F: '{if(NR == i+1) print $1}' data/$currentDB/meta-data/$currentTB.md)
        dataType=$(awk -v i="$i" -F: '{if(NR == i+1) print $2}' data/$currentDB/meta-data/$currentTB.md)

        echo "Enter the ${colName}"
        read colValue;

        if [ ${dataType} == "Numbers" ]
        then 
            case $colValue in 
            +([0-9]))
                $data
                data+=$colValue;
                ;;
            *)
                echo "The id should be integer"
                ;;
            esac
        elif [ ${dataType} == "alphabet letters" ]
        then 
            if [ $i -gt 0 ]
            then 
                data+=":"
            fi
            case $colValue in 
            +([a-zA-Z]))
                data+=$colValue;
                ;;
            *)
                echo "The id should be alphabet letters"
                ;;
            esac
        else
            if [ $i -gt 0 ]
            then 
                data+=":"
            fi
            data+=$colValue;
        fi
    done
    echo $data >> data/$currentDB/tables/$currentTB
    echo "Done adding the data to table '${currentTB}'"
}

InsertData