#!/bin/bash

# Function to generate the electric bill
generate_electric_bill() {
    bash electric_bill_gen.sh
}

# Function to generate the water bill
generate_water_bill() {
    bash water_bill.sh
}

# Function to view the database
view_database() {
    bash database.sh
}

# Main menu
while true; do
    clear
    echo "Billing Application Menu"
    echo "-----------------------"
    echo "1. Generate Electric Bill"
    echo "2. Generate Water Bill"
    echo "3. View Database"
    echo "4. Exit"
    echo "-----------------------"
    read -p "Enter your choice (1/2/3/4): " choice

    case $choice in
        1)
            generate_electric_bill
            ;;
        2)
            generate_water_bill
            ;;
        3)
            view_database
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    read -p "Press Enter to continue..."
done
