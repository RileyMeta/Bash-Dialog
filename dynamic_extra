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
