#!/bin/bash

# Function to perform database actions

database_file="database.txt"

if [ -f "$database_file" ]; then
    echo "Database Records:"
    echo "------------------"
    echo "Filter by Name and Type (Electric/Water)"
    read -p "Enter a filter (leave empty for all records): " filter
    filtered_records=$(grep -i "$filter" "$database_file")
    # cat "$database_file"
    echo "$filtered_records" | sed 's/,/\t/g' | column -t -s $'\t'
else
    echo "Database is empty. No records found."
fi