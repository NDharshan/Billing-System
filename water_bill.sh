#!/bin/bash

database_file="database.txt"
current_date=$(date "+%Y-%m-%d")

# Function to calculate the water bill
calculate_water_bill() {
    local consumption=$1
    local rate_tier1=7
    local rate_tier2=11
    local rate_tier3=25
    local rate_tier4=45
    local tier1_limit=8000
    local tier2_limit=25000
    local tier3_limit=50000

    local bill=0

    # Calculate the bill based on the consumption and pricing tiers
    if ((consumption <= tier1_limit)); then
        bill=$((consumption * rate_tier1))
    elif ((consumption <= tier2_limit)); then
        local tier1_consumption=$tier1_limit
        local tier2_consumption=$((consumption - tier1_limit))
        bill=$((tier1_consumption * rate_tier1 + tier2_consumption * rate_tier2))
    elif ((consumption <= tier3_limit)); then
        local tier1_consumption=$tier1_limit
        local tier2_consumption=$((tier2_limit - tier1_limit))
        local tier3_consumption=$((consumption - tier2_limit))
        bill=$((tier1_consumption * rate_tier1 + tier2_consumption * rate_tier2 + tier3_consumption * rate_tier3))
    else
        local tier1_consumption=$tier1_limit
        local tier2_consumption=$((tier2_limit - tier1_limit))
        local tier3_consumption=$((tier3_limit - tier2_limit))
        local tier4_consumption=$((consumption - tier3_limit))
        bill=$((tier1_consumption * rate_tier1 + tier2_consumption * rate_tier2 + tier3_consumption * rate_tier3 + tier4_consumption * rate_tier4))
    fi

    echo "$bill"
}

# Get user input
read -p "Enter Name: " uname 
read -p "Enter consumer type (Domestic/Commercial): " consumer_type
read -p "Enter the billing month (e.g., Jan 2023): " billing_month
read -p "Enter water consumption in kilolitres (kl): " consumption

# Calculate the water bill
water_bill=$(calculate_water_bill $consumption)

# Generate the bill message
bill_message="Water Bill Details\n"
bill_message+="------------------\n"
bill_message+="Consumer Type: $consumer_type\n"
bill_message+="Consumption: $consumption kl\n"
bill_message+="Water Bill: Rs $water_bill\n"

# Display the bill details
echo -e "$bill_message"

# Save the bill details to a file
bill_file="water_bill.txt"
echo -e "$bill_message" > "$bill_file"

echo "Bill generated successfully. Details saved in $bill_file."

# Add record to the database
echo "$uname,$water_bill,$billing_month,$current_date,WTR" >> "$database_file"
