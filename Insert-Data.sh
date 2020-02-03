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
        isPK=$(awk -v i="$i" -F: '{if(NR == i+1) print $3}' data/$currentDB/meta-data/$currentTB.md)
        echo "${yellow}Enter the ${colName}${reset}"
        read colValue;
        if [ ${dataType} == "Numbers" ]
        then 
            case $colValue in 
            +([0-9]) )
                if [[ $isPK == "1" ]]
                then
                    
                    isRepeated=$(awk -v fieledNum=$(( $i+1 )) -v newCellValue=$colValue 'BEGIN {flag=0 ; FS= ":"}; {if($fieledNum == newCellValue){ flag=1}} END {print flag}' data/$currentDB/tables/$currentTB)
                    if [[ $isRepeated == "1" ]]
                    then
                        i=$(( $i-1 ))
                        echo "${red}The id should be unique${reset}"
                        continue
                    fi
                fi
                if [ $i -gt 0 ]
                then 
                    data+=":"
                fi
                data+=$colValue;
                ;;
            *)
                i=$(( $i-1 ))
                echo "${red}The id should be integer${reset}"
                continue
                ;;
            esac
        elif [ ${dataType} == "string" ]
        then 
            case $colValue in 
            +([a-zA-Z]) )
                if [[ $isPK == "1" ]]
                then
                    
                    isRepeated=$(awk -v fieledNum=$(( $i+1 )) -v newCellValue=$colValue 'BEGIN {flag=0 ; FS= ":"}; {if($fieledNum == newCellValue){ flag=1}} END {print flag}' data/$currentDB/tables/$currentTB)
                    if [[ $isRepeated == "1" ]]
                    then
                        i=$(( $i-1 ))
                        echo "${red}The id should be unique${reset}"
                        continue
                    fi
                fi
                if [ $i -gt 0 ]
                then 
                    data+=":"
                fi
                data+=$colValue;
                ;;
            *)
                i=$(( $i-1 ))
                echo "${red}The value should be string${reset}"
                continue
                ;;
            esac
        else
            if [[ $isPK == "1" ]]
                then                   
                    isRepeated=$(awk -v fieledNum=$(( $i+1 )) -v newCellValue=$colValue 'BEGIN {flag=0 ; FS= ":"}; {if($fieledNum == newCellValue){ flag=1}} END {print flag}' data/$currentDB/tables/$currentTB)
                    if [[ $isRepeated == "1" ]]
                    then
                        i=$(( $i-1 ))
                        echo "${red}The id should be unique${reset}"
                        continue
                fi
            fi
            if [ $i -gt 0 ]
            then 
                data+=":"
            fi
            data+=$colValue;
        fi
    done
    echo $data >> data/$currentDB/tables/$currentTB
    echo "${green}Done adding the data to table '${currentTB}'${reset}"
}

InsertData