#!/bin/bash

LIMIT=13000
EXCLUDE="lessons"

echo "" > temp.csv
find . \( -name "*.html" -o -name "*.min.css" \) -type f -size +"$LIMIT"c -print | while read line; do
    info=$(ls -l "$line")
    name=$(echo $info | awk '{print $9}')
    icon="🟡"
    if [[ "$name" != *"$EXCLUDE"* ]]; then
        size=$(echo $info | awk '{print $5}')
        dif=$(( $size - $LIMIT ))
        if [[ "$dif" -gt $LIMIT ]]; then
            icon="🔴"
        fi
        echo "$icon,$name,$size,+$dif" >> temp.csv
    fi
done

which gum &>/dev/null
if [ $? -ne 0 ]; then
    cat temp.csv
else
    cat temp.csv | gum table --columns="🚦,NAME,SIZE,EXCESS" -p
fi
rm temp.csv
