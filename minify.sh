cd ~/zola/static
for file in *.css; do
    if [[ ! $file == *".min."* ]]; then
        curl -X POST -s --data-urlencode "input=$(cat $file)" "https://www.toptal.com/developers/cssminifier/api/raw" -o "${file%.css}.min.css"
        original_size=$(stat -c%s "$file")
        minified_size=$(stat -c%s "${file%.css}.min.css")
        reduction=$((original_size - minified_size))
        echo "Reduction for $file: $reduction bytes"
    fi
done
