#!/bin/bash

echo "-----------------Part3Start-----------------"
rm people.csv 2> /dev/null

touch people.csv

# Find all files matching the pattern "man*.html" and "woman*.html" in the "source" directory and its subdirectories
male_files=$(find source -type f -name 'man*.html')
female_files=$(find source -type f -name 'woman*.html')

# For each found male file
for file in $male_files; do
    # Read the content of the file
    content=$(cat $file)

    # Extract the IDENTIFIER and DATE from the file
    identifier=$(echo $content | grep -Po 'person_id=\K[^"]*')
    raw_date=$(echo $content | grep -Po '\*&#160;\K[^<]*')

    # Modified regular expression to extract text between </div> and <br/>
    name=$(echo $content | grep -Po '</div> \K[^<]*')

    # Modified regular expression to extract text between the last </div> and the penultimate <br/>
    status=$(echo $content | grep -Po '<br /> <br /> \K[^<]*')

    # Convert identifier, date, and name to arrays - new line separator
    IFS=$'\n' read -rd '' -a array <<<"$identifier"
    IFS=$'\n' read -rd '' -a array2 <<<"$raw_date"
    IFS=$'\n' read -rd '' -a array3 <<<"$name"
    IFS=$'\n' read -rd '' -a array4 <<<"$status"

    # Write the extracted data to people.csv with the added gender value "Man"
    for i in "${!array[@]}"
    do
        text=${array3[i]}
        # Modify the name format - capitalize the first letter, lowercase the rest
        formatted_name=$(echo "$text" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')

        trimmed_text="${formatted_name#"${formatted_name%%[![:space:]]*}"}"   # remove leading spaces
        trimmed_text="${trimmed_text%"${trimmed_text##*[![:space:]]}"}"   # remove trailing spaces

        # Convert the date to the format yyyy.mm.dd using awk
        formatted_date=$(echo "${array2[i]}" | awk -F '.' '{printf "%04d-%02d-%02d", $3, $2, $1}')

        echo "Muž;${array[i]};${formatted_date};$trimmed_text;${array4[i]}" >> people.csv
    done
done

# For each found female file
for file in $female_files; do
    # Read the content of the file
    content=$(cat $file)

    # Extract the IDENTIFIER and DATE from the file
    identifier=$(echo $content | grep -Po 'person_id=\K[^"]*')
    raw_date=$(echo $content | grep -Po '\*&#160;\K[^<]*')

    # Modified regular expression to extract text between </div> and <br/>
    name=$(echo $content | grep -Po '</div> \K[^<]*')

    # Modified regular expression to extract text between the last </div> and the penultimate <br/>
    status=$(echo $content | grep -Po '<br /> <br /> \K[^<]*')

    # Convert identifier, date, and name to arrays - new line separator
    IFS=$'\n' read -rd '' -a array <<<"$identifier"
    IFS=$'\n' read -rd '' -a array2 <<<"$raw_date"
    IFS=$'\n' read -rd '' -a array3 <<<"$name"
    IFS=$'\n' read -rd '' -a array4 <<<"$status"

    # Write the extracted data to people.csv with the added gender value "Woman"
    for i in "${!array[@]}"
    do
        text=${array3[i]}
        # Modify the name format - capitalize the first letter, lowercase the rest
        formatted_name=$(echo "$text" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')

        trimmed_text="${formatted_name#"${formatted_name%%[![:space:]]*}"}"   # remove leading spaces
        trimmed_text="${trimmed_text%"${trimmed_text##*[![:space:]]}"}"   # remove trailing spaces

        # Convert the date to the format yyyy.mm.dd using awk
        formatted_date=$(echo "${array2[i]}" | awk -F '.' '{printf "%04d-%02d-%02d", $3, $2, $1}')

        echo "Žena;${array[i]};${formatted_date};$trimmed_text;${array4[i]}" >> people.csv
    done
done
echo "-----------------Part3Complete-----------------"
