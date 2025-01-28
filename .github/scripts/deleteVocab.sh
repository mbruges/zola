for file in *.md; do
    sed -i.bak '/^- [[:space:]]*DEFINITIONS:/,/^$/ {d;}' "$file"
done
