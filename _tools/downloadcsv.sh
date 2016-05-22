#!/bin/bash

echo "Downloading CSV files..."
wget -q -O "../_data/packages.csv" "https://docs.google.com/spreadsheets/d/14LsVruEBy6vyh1Wv5dIHA5s-raE-AHiGuEvWlem4XKs/pub?gid=551081751&single=true&output=csv"

dos2unix ../_data/*
