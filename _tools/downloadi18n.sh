#!/bin/bash
FILE="/tmp/hatbarcelona.i18n.csv"

echo "Downloading i18n CSV file..."
rm -f ${FILE}
wget -q -O ${FILE} "https://docs.google.com/spreadsheets/d/14LsVruEBy6vyh1Wv5dIHA5s-raE-AHiGuEvWlem4XKs/pub?gid=0&single=true&output=csv"
ruby2.3 ../_tools/csv2yaml.rb ${FILE}
