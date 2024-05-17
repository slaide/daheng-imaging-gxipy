TARGET_FILE="$1"
SAFE_OUTPUT_FILE="$2"

# ensure it exists
ls -l "$TARGET_FILE"
echo "converting ..."

# get line containing the beginning of the binary data
BINARY_ARCHIVE_FIRST_LINE=$(awk '/^__ARCHIVE_FOLLOWS__/ { print NR + 1; exit 0; }' "$TARGET_FILE")

# copy install script until the line right before the binary data begins
head -n $(($BINARY_ARCHIVE_FIRST_LINE - 1)) "$TARGET_FILE" | tee "$SAFE_OUTPUT_FILE" > /dev/null
# append base64 encoded binary data to script copy
tail -n +$BINARY_ARCHIVE_FIRST_LINE "$TARGET_FILE" | base64 >> "$SAFE_OUTPUT_FILE"

# modify data extraction command
sed -i '' 's#tail -n +$ARCHIVE $0 > Galaxy_camera.tar.gz#tail -n +$ARCHIVE $0 | base64 --decode -o Galaxy_camera.tar.gz#' "$SAFE_OUTPUT_FILE"
# if you run this command on macos, use $ sed -i '' 's#tail ....' # instead

echo "done"
