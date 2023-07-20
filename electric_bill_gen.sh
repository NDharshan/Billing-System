#!/bin/bash

database_file="database.txt"
current_date=$(date "+%Y-%m-%d")

calculate_bill() {
	local units=$1
   local type=$2
   local rate_tier1_domestic=5
   local rate_tier2_domestic=9
   local rate_tier1_commercial=7
   local rate_tier2_commercial=11
   local threshold_tier1=100


   local bill=200 # minimum bill amount
   if ((units <= 100)); then
        if [ "$type" == "1" ]; then
            bill=$((bill + (units * rate_tier1_domestic)))
        else
            bill=$((bill + (units * rate_tier1_commercial)))
        fi
   else
      # Calculate the units beyond tier 1
      local units_tier2=$((units - threshold_tier1))
      if [ "$type" == "2" ]; then
         bill=$((bill + (threshold_tier1 * rate_tier1_domestic + units_tier2 * rate_tier2_domestic)))
      else
         bill=$((bill + (threshold_tier1 * rate_tier1_commercial + units_tier2 * rate_tier2_commercial)))
      fi
   fi
   
  echo "$bill"
  
} # calc

# Read values
read -p "Enter Name: " uname 
read -p "Enter Previous Month Usage: " prev
read -p "Enter Current Month Usage: " cur
read -p "Pick type: 1) Domestic 2) Commercial: " type
read -p "Enter the billing month (e.g., Jan 2023): " billing_month

# calculate usage
usage=$((cur - prev))
# call function
bill_amount=$(calculate_bill $usage "$type")

# Generate the bill in a text file
bill_file="${uname}_bill.txt"
echo "Name: $uname " > "$bill_file"
echo "Usage Details:" >> "$bill_file"

echo "Previous Month: $prev units" >> "$bill_file"
echo "Current Month: $cur units" >> "$bill_file"
echo "Total Usage: $usage units" >> "$bill_file"
echo "Bill Amount: Rs $bill_amount" >> "$bill_file"

echo "Bill generated successfully. Please check $bill_file for details."

# Add record to the database
echo "$uname,$bill_amount,$billing_month,$current_date,ELE" >> "$database_file"
