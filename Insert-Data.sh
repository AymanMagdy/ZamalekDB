#!/bin/bash

function InsertData () {
    
    cd data/$currentDB/$currentTB
    cat "$currentTB+.md";
    pwd
}

InsertData