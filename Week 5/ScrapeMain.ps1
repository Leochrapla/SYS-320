. (Join-Path $PSScriptRoot ClassScrape.ps1)
$FullTable = gatherClasses

# $FullTable | Select "Class Code", Instructor, Days, "Time Start", "Time End" | where {$_."Instructor" -ilike "Furkan Paligu"}

 # $FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.days -ilike "*M*") } | Sort-Object "Time Start" | Select-Object  "Time Start", "Time End", "Class Code" 
 $ITSInstructors = $FullTable | Where-Object { ($_."Class Code" -like "SYS*") -or
                                               ($_."Class Code" -like "NET*") -or
                                               ($_."Class Code" -like "SEC*") -or
                                               ($_."Class Code" -like "FOR*") -or
                                               ($_."Class Code" -like "CSI*") -or
                                               ($_."Class Code" -like "DAT*") } | Select-Object "Instructor" -Unique | Sort-Object "Instructor"

$FullTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } | Group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending

$ITSInstructors