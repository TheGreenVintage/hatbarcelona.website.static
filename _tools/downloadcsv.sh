#!/bin/bash

echo "Downloading CSV files..."
wget -q -O "../_data/packages.csv" "https://docs.google.com/spreadsheets/d/1ffD7Ef8Kp_lnAokk3Pc-s4CKpZUJDLSod4YxXW9UIlA/pub?gid=551081751&single=true&output=csv"
wget -q -O "../_data/menus.csv"    "https://docs.google.com/spreadsheets/d/1ffD7Ef8Kp_lnAokk3Pc-s4CKpZUJDLSod4YxXW9UIlA/pub?gid=1411098766&single=true&output=csv"
wget -q -O "../_data/private.csv"  "https://docs.google.com/spreadsheets/d/1ffD7Ef8Kp_lnAokk3Pc-s4CKpZUJDLSod4YxXW9UIlA/pub?gid=2104266518&single=true&output=csv"

dos2unix ../_data/*
