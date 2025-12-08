#!/bin/bash
site="10.0.17.39/IOC.html"

ioc=$(curl -sL "$site" | sed -E 's/<[^>]*>//g')
echo "$ioc" > IOC.txt
