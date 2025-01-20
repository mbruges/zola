#!/bin/bash

FILE_PATH="$1"

TEXT=$( cat $FILE_PATH )


if [ ${#TEXT} -lt 2 ]; then
    echo "No text provided from $FILE_PATH, check filepath"
    exit 1
fi

ADDITIONAL=". "
if [[ ! $TEXT =~ "DEFINITIONS" ]]; then
    ADDITIONAL="of words to add to the existing DEFINITIONS list."
fi

TEXT=$( echo $TEXT | sed 's|- DEFINITIONS:|\nHere is the current list of defined words - please add to it:|g')

QUERY="You will generate a list of challenging vocabulary and their definitions, to help a student understand the given text. First, read the text; then select specific vocabulary that a 15 year old may need help understanding. Be selective, only picking a few of the advanced and important vocabulary essential for understanding the text - a longer text will need more definitions. Then, generate a list of those words with short definitions (limit to 5 simple words) - consider context in which word is being used. The list must be as a Markdown list, in the following format: - decimate: (v) to destroy, ruin \n  - fastidious: (adj) extremely tidy, precise\n Here is the text: $TEXT\nNow, generate the list of words and definitions. No commentary, only the list $ADDITIONAL"

QUERY="$(echo -n "$QUERY" | jq -sRr @uri)"

OUTPUT=$(curl -s "https://api.mxb.fyi/gpt-mini?query=$QUERY")
echo $OUTPUT

if [ ${#ADDITIONAL} -gt 4 ]; then
    echo -e "\n- DEFINITIONS:" >> $FILE_PATH
fi

IFS="~" read -r -a list <<< "$( echo $OUTPUT | sed 's|- | ~ |g' )"
for element in "${list[@]}"; do
if [[ ${#element} -gt 3 ]] && [[ ! $element =~ "decimate" ]] && [[ ! $element =~ "fastidious" ]]; then
        echo "  -$element" | sed 's| \n||g' >> $FILE_PATH
    fi
done
