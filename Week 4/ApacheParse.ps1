function ApacheLogs1(){
    $logsNotFormatted = Get-Content "C:\xampp\apache\logs\access.log"
    $tableRecords = @()
    
    for($i=0; $i -lt $logsNotFormatted.Count; $i++){
  
        $words = $logsNotFormatted[$i].Split(" ");
        
        $tableRecords += [PSCustomObject]@{ 
            "IP" = $words[0].Trim('[');
            "Time" = $words[3].Trim('[');
            "Method" = $words[5].Trim('"');
            "Page" = $words[6];
            "Protocol" = $words[7];
            "Response" = $words[8];
            "Referrer" = $words[10].Trim('"');
            "Client" = $words[11..($words.Count-1)]; 
        }
    } # end of for loop
    return $tableRecords | Where-Object { $_.IP -like "10.*" }
}

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap