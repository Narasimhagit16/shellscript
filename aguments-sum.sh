#!/bin/bash

if [ $# -lt 1 ]
then
    echo "number of argument passed is 0"
    exit 1
fi
NUM1=$1
NUM2=$2
NUM3=$3

SUM=$(( $NUM1+$NUM2+$NUM3 ))

echo "sum of three number is :$SUM "