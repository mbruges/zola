#!/bin/bash
#cd ~/zola/content/learn/textbook
defaultTITLE="New Textbook"
defaultAUTHOR="First Last"
defaultICON="📔"
defaultKEYSTAGE="3"
defaultTAGS='["none"]'

if [[ "$(pwd)" == *"/zola/" ]]; then
    cd content/learn/textbook
elif [[ "$(pwd)" != *"/zola/content/learn/textbook" ]]; then
    echo "Error: You are not in the correct directory. Please navigate to ..zola/content/learn/textbook."
    exit 1
fi

micro temp.md || exit 1
if [[ $(wc -c < temp.md) -le 5 ]]; then
    rm temp.md
    exit 1
fi

sed -i '' 's/$/  /' temp.md

TITLE=$(head -n 1 temp.md)

TITLE=$( gum input --prompt="TITLE: " --placeholder="$TITLE [enter to accept]" --char-limit="50" )
if [[ -z "$TITLE" ]]; then
    TITLE=$(head -n 1 temp.md)
fi

AUTHOR=$( gum input --prompt="AUTHOR: " --placeholder="Type..." --char-limit="50" )

ICON=$( gum input --prompt="ICON: " --placeholder="Enter emoji" --char-limit="1" )
if [[ -z "$ICON" ]]; then
    ICON=$defaultICON
fi

KEYSTAGE=$( gum filter 3 4 5 --prompt="KEYSTAGE: " --limit="1" )

if [[ "$KEYSTAGE" == "5" ]]; then
    TAGS="poems-of-the-decade poetry"
elif [[ "$KEYSTAGE" == "4" ]]; then
    TAGS="pearson anthology poetry"
else
    TAGS=$( gum input --prompt="TAGS: " --placeholder="Separate with spaces" )
fi


TAGS=$(echo "$TAGS" | tr ' ' ',' | sed 's/\([^,]*\)/"\1"/g' | sed 's/,/, /g' | sed 's/^/[/' | sed 's/$/]/')

SLUG=$(echo "$TITLE" | tr -cd '[:alnum:] [:space:]' | tr ' ' '-' | tr '[:upper:]' '[:lower:]')



FRONTMATTER="---
title: \"$TITLE\"
authors: [\"$AUTHOR\"]
extra:
    icon: $ICON
    keystage: [\"$KEYSTAGE\"]
    tags: $TAGS
---"

FRONTMATTER_CHECKED=$(echo -e "$FRONTMATTER" | gum write --height="9" --header="Enter to confirm")

if [[ -z "$FRONTMATTER_CHECKED" ]]; then
    echo -e "$FRONTMATTER" > $SLUG.md
else
    echo -e "$FRONTMATTER_CHECKED" > $SLUG.md
fi

cat temp.md >> $SLUG.md
rm temp.md
echo "Saved zola/content/learn/textbook/$SLUG.md"
