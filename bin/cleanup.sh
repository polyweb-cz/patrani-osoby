#!/bin/bash

echo "-----------------Part2Start-----------------"
files=$(find source -type f -name '*.html')

for file in $files; do
    # Read the content of the file
    content=$(<"$file")

    # Replace multiple spaces, tabs, and newlines with a single space
    cleaned_content=$(echo "$content" | tr -s ' \t\n\r' ' ')

    # Save the result back to the file
    echo "$cleaned_content" > "$file"
done
echo "-----------------Part2Complete-----------------"
