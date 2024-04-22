#!/bin/bash

extraButton() {
        dialog --clear \
        --backtitle "Dialog Tutorials" \
        --title "How to use the Extra Button" \
        --extra-button \
        --extra-label "Secrets" \
        --yesno "Press <Secrets> to see some Secrets" 0 0

    dialog_exit_code=$?

    case $dialog_exit_code in
    0)  clear
        echo "Yes button was pressed"
    ;;
    1)  clear
        echo "No button was pressed"
    ;;
    3)  clear
        echo "Extra Button was pressed"
    ;;
    esac
}

extraButton
