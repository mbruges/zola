word="$1"
url="https://en.wiktionary.org/w/api.php?action=query&titles=${word}&prop=extracts&explaintext=true&format=json"

response=$(curl -s "$url")

echo "$response" | jq -r '.query.pages | .[] | .extract '
