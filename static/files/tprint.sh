#!/bin/bash

## This is a very basic script, taking piped text and printing it out
## Lines preceeded with a '#' will be printed in double-size
## All lines will be word-wrapped to 32 or 16 chars (depending on font size)

# Change this to the path to the printer
PRINTER="/dev/usb/lp0"

# ESC/POS commands
E="esc"
ESC="\x1B"
RESET="${ESC}@" #32 normal
BIG="${ESC}!1" #16 chars

function break_text() {
local limit="$2"
local input_string="$1"
    local length="${#input_string}"

    if [ "$length" -le "$limit" ] && [ "$length" -gt 0 ]; then
        echo -e "$input_string"
    else
        local result=""
        local current_chunk=""

        # Read the string line by line
        while IFS= read -r line; do
            for word in $line; do
                if [ ${#current_chunk} -eq 0 ]; then
                    current_chunk="$word"
                elif [ $((${#current_chunk} + ${#word} + 1)) -le $limit ]; then
                    current_chunk="$current_chunk $word"
                else
                    result="$result$current_chunk"$'\n'
                    current_chunk="$word"
                fi
            done
            # Append the remaining chunk at the end of the line
            if [ ${#current_chunk} -gt 0 ]; then
                result="$result$current_chunk"$'\n\n'
                current_chunk=""
            fi
        done <<< "$input_string"

        # If there's any remaining chunk, add it to the result
        if [ ${#current_chunk} -gt 1 ]; then
            result="$result$current_chunk"
        fi

        trimmed_string=$(echo -e "$result" | sed 's/[[:space:]]*$//')
        echo -e "$trimmed_string\n"
    fi
}

function print_title() {
    local input_string="$1"
    echo -e "$BIG"
    break_text "$input_string" "16"
    echo -e $RESET
}

function print_body() {
    local input_string="$1"
    local asterisk_count=$(echo "$input_string" | grep -o '\*' | wc -l)
    if [ "$asterisk_count" -gt 1 ]; then
        local modified_string=""
        local index=2
        for ((i=0; i<${#input_string}; i++)); do
            char="${input_string:i:1}"
            if [[ "$char" == "*" ]]; then
                if (( index % 2 == 0 )); then
                    modified_string+="${ESC}!1"
                else
                    modified_string+="${ESC}!8"
                fi
                index=$((index + 1))
            else
                modified_string+="$char"
            fi
        done
        input_string="$modified_string"
    fi
    break_text "$input_string" "32"
}

function print_end() {
    echo "x------------------------------x"
    echo ""
}


echo -e "$RESET"

if [ -p /dev/stdin ]; then
    INPUT=$(cat -)
    while IFS= read -r line; do
        if [[ ${line:0:1} == "#" ]]; then
            print_title "${line:1}"
        elif [ ${#line} -gt 0 ]; then
            print_body "$line"
        fi
    done <<< "$INPUT"
fi

print_end
