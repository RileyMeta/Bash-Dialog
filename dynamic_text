#!/bin/bash

# # This script intentionally loops forever, please press Ctrl+C to exit.

trap 'clear && exit' INT # trap the ctrl+c input (INT) and execute the code between the single quotes

DEFAULT_VARIABLE=true

dynamic_text() {
    options=("option 1" "option2" "option3") # Add more as you need.
    # You could also pipe in the options from a file with `options=$(cat /path/to/file)`
    # If necessary more adjustments can be chained together with more command arguments / regular expressions

    menu_options=() # Define an empty array that we will add to later.
    i=1 # The number of the menu options | Start at 1, goes up to whatever is needed
    for option in "${options[@]}"; do # Loop through the individual items IN the array | [@] = All items
        menu_options+=("$i" "$option") # Add the new options to the empty array we made earlier.
        ((i++)) # Add 1 to the number
    done # End the loop and continue the rest of the script

    exec 3>&1 # execute the below code and save the input to STDERR (a Bash Variable for temporary storage)
    message="Default Variable: ${DEFAULT_VARIABLE}" # Assign the original message
    if [ $DEFAULT_VARIABLE = true ]; then # Define an if statement to check the DEFAULT_VARIABLE 
    # You can change the variable to any type, but if you're expecting more than 3 values, please use a case/esac statement for better performance
        message+="\nThis is the first message"
    else
        message+="\nThis is the second message"
    fi
    message+="\n\nPlease select a button below:"
    if dialog --clear \
        --title "Locale Selection" \
        --colors \
        --yes-label "TRUE" \
        --no-label "FALSE" \
        --yesno "${message}" 0 0;
    then
        # If you don't define the default Variable, it will stay at the default value
        DEFAULT_VARIABLE=true # Re-assign the Default Variable
        dynamic_text # Restart the Dialog Menu
    else
        DEFAULT_VARIABLE=false # Re-assign the Default Variable
        dynamic_text # Restart the Dialog Menu
    fi
}

dynamic_text
