url="$1"

if [ -z "$url" ]; then
    read -p "Enter image URL: " url
fi

if [[ ! "$url" == http* ]]; then
    LOCAL=true
    filename=$(basename "$url")
    cp $url $filename
fi

if [[ "$url" =~ \.(jpg|jpeg|png|gif|webp)$ ]]; then
    filename=$(basename "$url")
else
    echo "The provided URL does not refer to a valid image format, but we'll give it a go."
    #exit 1
    filename=$(basename "$url")
fi

read -p "Enter image name (or press enter for default): " filename_input
if [ -z "$filename_input" ] || [ "$filename_input" == " " ]; then
    echo "No file name provided, using default file name."

    new_filename="$(echo "$(date +"%d-%m_")${filename%.*}" | tr -cd '[:alnum:]_-').webp"

else
    new_filename="$(echo "${filename_input%.*}" | tr -cd '[:alnum:]_-').webp"
fi



# Download the image
if [ "$LOCAL" != true ]; then
    if command -v wget &> /dev/null; then
        wget -q "$url" -O "$filename"
    elif command -v curl &> /dev/null; then
        curl -s -o "$filename" "$url"
    else
        echo "Neither wget nor curl is installed. Please install one of them to proceed."
        exit 1
    fi
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    old_size=$(stat -f "%z" "$filename")
else
    old_size=$(stat --printf="%s" "$filename")
fi


if command -v magick &> /dev/null; then
    magick "$filename" -strip -resize 700 -quality 40 "$new_filename"
else
    echo "Install image-magick to proceed."
    exit 1
fi

# Remove the original file
rm "$filename"

if [[ "$OSTYPE" == "darwin"* ]]; then
    new_size=$(stat -f "%z" "$new_filename")
else
    new_size=$(stat --printf="%s" "$new_filename")
fi

mv $new_filename static/images/
echo "Saved to   /images/$new_filename     Size reduction: $(((old_size - new_size) / 1024)) KB"
