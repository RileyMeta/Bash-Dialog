#!/bin/bash

# Show dialog box with "Extra" button
dialog --clear \
        --backtitle "Dialog Tutorials" \
        --title "How to use the Extra Button" \
        --extra-button \
        --extra-label "Extra" \
        --yesno "Press <Extra> for additional options" 0 0 2>&1 >/dev/tty

dialog_exit_code=$?

if [ $dialog_exit_code -eq 3 ]; then
    clear
    echo "Extra button was pressed"
elif [ $dialog_exit_code -eq 0 ]; then
    clear
    echo "Yes button was pressed"
else
    clear
    echo "No button was pressed"
fi
