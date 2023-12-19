#!/bin/bash

TO_TEAM=$1
ALERT_TYPE=$2
BODY=$3
ESCAPE_BODY=$(printf '%s\n' "$BODY" | sed -e 's/[]\/$*.^[]/\\&/g');
TO_ADDRESS=$4
SUBJECT=$5

echo "body: $BODY"
echo $TO_TEAM

FINAL_BODY=$(sed -e "s/'TO_TEAM'/$TO_TEAM/g" template.html)

#FINAL_BODY=$(sed -e "s/'TO_TEAM'/'$TO_TEAM'/g" -e "s/'ALERT_TYPE'/'$ALERT_TYPE'/g" -e "s/'BODY'/'$ESCAPE_BODY'/g" template.html)

echo " fINAL_BODY $FINAL_BODY"


echo "$FINAL_BODY" | mail -s "$(echo -e "$SUBJECT\nContent-Type: text/html")" "$TO_ADDRESS"