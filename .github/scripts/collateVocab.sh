#!/bin/bash

output_file="dictionary.yaml"
> "$output_file"

for file in *.md; do
  if grep -q "DEFINITIONS" "$file"; then
    echo "Found def in ${file}"
    awk '/DEFINITIONS:/{flag=1; next} flag && /^[[:space:]]*-[[:space:]]/{gsub(/^- /,""); print} flag && /^[[:space:]]*$/{flag=0}' "$file" >> "$output_file"
  fi
done
