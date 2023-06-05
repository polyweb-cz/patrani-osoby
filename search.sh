#!/bin/bash
#!/bin/bash

# Získání parametrů
hledane_datum="$1"
hledane_jmeno="$2"
treti_parametr="$3"
ctvrty_parametr="$4"

# Sloučení druhého a třetího parametru s mezerou
hledane_jmeno="$hledane_jmeno $treti_parametr"

file="people.csv"

if [ -n "$ctvrty_parametr" ]; then
  file=$ctvrty_parametr
fi

vysledek=$(grep -F ";$hledane_datum;" $file | grep -F "$hledane_jmeno")

# Výpis výsledku do konzole
if [ -n "$vysledek" ]; then
    echo -n "["
    first_line=true
    while IFS= read -r line; do
        if [ "$first_line" = true ]; then
            first_line=false
        else
            echo -n ","
        fi
        gender=$(echo "$line" | cut -d';' -f1)
        ID=$(echo "$line" | cut -d';' -f2 | tr -d '\n')  # Odstranění nového řádku
        birth=$(echo "$line" | cut -d';' -f3)
        name=$(echo "$line" | cut -d';' -f4)
        state=$(echo "$line" | cut -d';' -f5)
        link="https://aplikace.policie.cz/patrani-osoby/PersonDetail.aspx?person_id=$ID"
        echo -n '{"gender":"'"$gender"'","id":"'"$ID"'","birth":"'"$birth"'","name":"'"$name"'","state":"'"$state"'","link":"'"$link"'"}'
    done <<< "$vysledek"
    echo "]"
else
    echo "Nenalezen žádný řádek splňující zadaná kritéria."
fi
