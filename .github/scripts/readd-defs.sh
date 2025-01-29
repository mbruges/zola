#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Usage: $0 dictionary.yaml markdown_file.md"
  exit 1
fi

dictionary_file=$1
markdown_file=$2

# Read the markdown file
file_content=$(<"$markdown_file")

# Read the dictionary YAML file into a variable
dictionary=$(<"$dictionary_file")

# Initialize words section
words_section="    vocab:\n"

# Loop through each word in the dictionary YAML
while IFS=$'\n' read -r line; do
  word=$(echo $line | cut -d ':' -f 1)


  # Check if the word appears in the markdown file
  if grep -q "\<$word\>" "$markdown_file"; then
    definition=$(echo $line | cut -d ':' -f 2-)
    # Add the word and definition to the words section
    words_section+="        $word: $definition\n"
  fi
done <<< "$dictionary"

# Update the markdown file with the words section
sed -i "s/extra:/&\n$words_section/" "$markdown_file"
