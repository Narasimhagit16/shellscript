#!/bin/bash

#"sh grettings.sh :n:w:h"
#syntax: sh greetings.sh -n name -w wishes -h
#example: sh greetings.sh -n narasimha -w "good morning"

USAGE(){
    echo "usage:: $(basename $0) -n <name> -w <wishesh>"
    echo "Options::"
    echo "-n, Specify the name(Mandatory)"
    echo "-w, Specify the wishes (Optional)"
    echo "-h, Display Help and exit"
    
    }

while getopts ":n:w:h" opt
do
    case $opt in 
        n) NAME="$OPTARG";;
        w) WISHES="$OPTARG";;
        h) USAGE; exit 1;;
        :) USAGE; exit 1;;
        \?) echo "Invalid Options"; USAGE; exit 1;;
    esac
done 

#if [ -z "$NAME" ] || [ -z "WISHES"]  # both aptions are mandatory
if [ -z "$NAME" ]
then
    echo "Error: -n is Mandatory"
    USAGE
    exit 1
fi

echo "Hello $NAME, $WISHES !"
