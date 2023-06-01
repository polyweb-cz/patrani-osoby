# Pátrání po osobách
Pátrání po osobách - stažení databáze obsahující záznamy z aktivní pátrací evidence Policie České republiky.

## Informace
Policie ČR neposkytuje API pro svá data. Tento parser v bash tyto informace stahuje z webu policie a ukládá je do souboru people.csv

## Použití
```bash start.sh```
Nastartuje stahování dat, po skončení je výsledek uložen v people.csv. Rychlost dokončení je závislá na rychlosti internetového připojení a počtu hledaných osob.

## Formát dat
Soubor people.csv vypadá takto:
pohlaví;id;datum narození;jméno;poznámka

## Poznámka
z id lze ziskat odkaz na stránku s podrobnými informacemi o osobě: https://aplikace.policie.cz/patrani-osoby/PersonDetail.aspx?person_id=%id%

## Autor
Mafiosoweb1 - na tomto programu jsem se učil základy bash skriptování