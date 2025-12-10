#!/bin/bash

data=$(curl -s "http://10.0.17.39/Assignments.html" | grep -o '<td>[^<]*</td>' | sed 's/<td>//g; s/<\/td>//g')


tempData=$(echo "$data" | head -n 10)
presData=$(echo "$data" | tail -n 10)

paste <(echo "$presData" | awk 'NR%2==1') <(echo "$tempData" | awk 'NR%2==1') <(echo "$tempData" | awk 'NR%2==0') | tr '\t' ' '
