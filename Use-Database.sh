#!/bin/bash

clear
echo "Enter Database Name : "
read dbName

cd $HOME/Zamalek\ Database

if [[ -d $dbName ]]
then 
    cd $dbName
    echo "switched to $dbName"
    return 0;
else 
    echo "$dbName Not Found"
    return 1;
fi