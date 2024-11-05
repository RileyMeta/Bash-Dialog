#!/bin/bash

# Collect the User's Name and Email
USER_INFO=$(dialog --form "User Registration" 15 50 3 \
    "Username:" 1 1 "" 1 10 20 0 \
    "Email:" 2 1 "" 2 10 20 0 \
    3>&1 1>&2 2>&3 3>&-)

if [ $? -ne 0 ]; then
    echo "Form entry was canceled."
    exit 1
fi

# Parse the USER_INFO fields with sed
USERNAME=$(echo "$USER_INFO" | sed -n '1p')
EMAIL=$(echo "$USER_INFO" | sed -n '2p')

# Collect Password // Allow Asterisk instead of Zero Response (--insecure)
PASSWORD=$(dialog --insecure --passwordbox "Enter your password:" 10 40 3>&1 1>&2 2>&3 3>&-)

if [ $? -ne 0 ]; then
    echo "Password entry was canceled."
    exit 1
fi

# Display the collected data
dialog --msgbox "Username: $USERNAME\nEmail: $EMAIL\nPassword: (hidden)" 10 40
