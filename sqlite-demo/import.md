##### SQLite import from CSV
This is sqlite3 admin code to get a table from a csv file within sqlite. Assumes file has a header row.

`> .mode csv`  
`> .import 'reg.csv' registrations`  
`> .mode headers on`  
`> .mode column`  
