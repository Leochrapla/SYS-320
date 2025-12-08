#!bin/bash

echo "<html>" > report.html
echo "<head<><title>IOC Report</title></head>" >> report.html
echo "<body>" >> report.html
echo "<p>Access log with IOC indicators</p>" >> report.html
echo "<table border='1' cellpadding='10' cellspacing='0'>" >> report.html
echo "<tr><td>IP</td><td>Time</td><td>IOC trigger</td></tr>" >> report.html

cat report.txt | while read -r line; do
	ip=$(echo "$line" | cut -d' ' -f1)
	timestamp=$(echo "$line" | cut -d'[' -f2 | cut -d']' -f1)
	ioc=$(echo "$line" | cut -d']' -f2 | sed 's/^ //')

	echo "<tr><td>$ip</td><td>$timestamp</td><td>$ioc</td></tr>" >> report.html
done

echo "</table></body></html>" >> report.html

mv report.html /var/www/html/

