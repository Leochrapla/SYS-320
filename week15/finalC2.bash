#!/bin/bash
echo "please input your IOC file name: "
read iocFile

echo "please enter your log file to scan for IOC: "

read logFile

echo "scanning your log file"

output=$(cat "$logFile" | egrep -i -f "$iocFile" | cut -d ' ' -f1,4,7)

echo "$output"

echo -n "Contents saved to report.txt"
echo ""
echo "$output"  > report.txt
