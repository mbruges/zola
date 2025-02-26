echo "Running minify.sh"
cd static
for file in *.css; do
    if [[ ! $file == *".min."* ]]; then
        echo "minifying $file"
        curl -X POST -s --data-urlencode "input=$(cat $file)" "https://www.toptal.com/developers/cssminifier/api/raw" -o "${file%.css}.min.css"
        # if [[ "$(uname)" == "Darwin" ]]; then
        #     original_size=$(stat -f%z "$file")
        #     minified_size=$(stat -f%z "${file%.css}.min.css")
        # else
        #     original_size=$(stat -c%s "$file")
        #     minified_size=$(stat -c%s "${file%.css}.min.css")
        # fi
        # reduction=$((original_size - minified_size))
        # echo "Reduction for $file: $reduction bytes"
        #Adding minified snippet to homepage
        if [[ $file == *"homepage"* ]]; then
            echo "updating homepage-style snippet"
            cat "homepage.min.css" | sed '1s/^/<style>\n/' | sed '$s/$/\n<\/style>/' > ../templates/snippets/homepage-style.html
        fi

    fi
done

# echo "Issuing purge command to Cloudflare..."

# curl https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/purge_cache \
#     -H 'Content-Type: application/json' \
#     -H "X-Auth-Email: $CF_EMAIL" \
#     -H "X-Auth-Key: $CF_API_KEY_PURGE" \
#     -d '{
#       "purge_everything": true
#     }' && echo "Succeeded in purge!"


exit
