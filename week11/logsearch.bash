#!bin/bash
allLogs=""
file="/var/log/apache2/access.log"

#results=$(cat "$file" | grep "10.0.17.39/page2.html" | grep "10.0.17.39/page2.html" -o | tr '/' ' ')

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function ips(){
ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
}

function pageCount() { 

getPageCount=$(cat "$file" | grep "GET" | cut -d '"' -f2 | cut -d ' ' -f2 | sort | uniq -c | sort -rn)
}

function curlCount() {
curlC=$(cat "$file" | grep "GET" | cut -d ' ' -f1,12 | grep "curl/7.81.0" | sort | uniq -c | sort -rn)
}

getAllLogs
ips
pageCount
curlCount
echo "$curlC"
