## Dynamic Text
> [!TIP]
> This works for any text. You can change button labels, titles, texts, backtitles, and even menu options.

![Dynamic_text](https://github.com/RileyMeta/Bash-Dialog/assets/32332593/4ec6fc36-d754-4bca-a3e5-607c9b154003)
```bash
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
```
## Dynamic Extra Button
To make a simple dynamic `<More Info>` button, we can employ some tricks we've used before:
![image](https://github.com/user-attachments/assets/b02dbe46-c688-4992-a5c7-0afeb6ed48d7)
```sh
#!/bin/bash

show_menu() {
    while true; do
        CHOICE=$(dialog --clear --title "Select an Option" \
            --extra-button --extra-label "More Info" \
            --cancel-label "Exit" \
            --menu "Choose an item:" 15 50 5 \
            1 "Item One" \
            2 "Item Two" \
            3 "Item Three" \
            3>&1 1>&2 2>&3)

        EXIT_STATUS=$?
        
        case $EXIT_STATUS in
            0)  # OK was pressed
                dialog --msgbox "You selected item $CHOICE." 6 40
                ;;
            3)  # Extra button (More Info) was pressed
                case $CHOICE in
                    1) INFO="Item One: This is the first option." ;;
                    2) INFO="Item Two: This option is second." ;;
                    3) INFO="Item Three: The third choice available." ;;
                    *) INFO="No item selected!" ;;
                esac
                dialog --msgbox "$INFO" 6 50
                ;;
            1)  # Cancel was pressed
                clear
                exit 0
                ;;
        esac
    done
}

show_menu
```
- First, we're wrapping the entire menu in a variable named `CHOICE`
- Skipping the menu itself, we capture the `EXIT_STATUS` to a variable
- Next we use a simple `case` statement to loop through the `EXIT_STATUS`'s
- Now for the fun, In exit code `3` we issue another `case` statement to loop through the `CHOICE` that we're hovering on.
- After that we generate a simple generic msgbox to show the `INFO` that we want.
