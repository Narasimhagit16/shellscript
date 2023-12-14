#!/bin/bash

FRUITS=( "apple" "banana" "orrange" )


echo "1st fruite" ${FRUITS[0]}
echo "2n fruite" ${FRUITS[1]}
echo "3rd fruite" ${FRUITS[2]}

for frut in ${FRUITS[]}
do
    echo "$frut"
done
