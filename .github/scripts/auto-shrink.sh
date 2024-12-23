#!/bin/bash

cd "$(git rev-parse --show-toplevel)/static/images"

existing_WEBPs=$(ls *.webp)

for image in *; do
    if [[ $image == *.png || $image == *.jpg || $image == *.jpeg ]]; then
        base_name=$(basename "$image" | sed 's/\.[^.]*$//')
        if echo "$existing_WEBPs" | grep -q "$base_name" ; then
            :
        else
            shrink $image
        fi
    fi
done
