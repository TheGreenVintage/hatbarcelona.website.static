#!/bin/bash
FILE="/tmp/hatbarcelona.i18n.csv"

echo "Downloading i18n CSV file..."
rm -f ${FILE}
wget -q -O ${FILE} "https://docs.google.com/spreadsheets/d/1ffD7Ef8Kp_lnAokk3Pc-s4CKpZUJDLSod4YxXW9UIlA/pub?gid=0&single=true&output=csv"
ruby2.3 ../_tools/csv2yaml.rb ${FILE}
