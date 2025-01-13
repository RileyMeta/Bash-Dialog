#!/bin/bash

BACKTITLE="Dialog Tutorials"

main() {
    CHOICE=$(dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Main Menu" \
    --menu "Below are all the available Dialog Menus: " 0 0 15 \
    1 "menu" \
    2 "msgbox" \
    3 "yesno" \
    4 "inputbox" \
    5 "passwordbox" \
    6 "infobox" \
    7 "textbox" \
    8 "checklist" \
    9 "radiolist" \
    10 "gauge" \
    11 "calendar" \
    12 "timebox" \
    13 "fselect" \
    14 "dselect" \
    15 "form" \
    2>&1 > /dev/tty)

    case $CHOICE in
        1 ) menu
            break;;
        2 ) msgbox
            break;;
        3 ) yesno
            break;;
        4 ) inputbox
            break;;
        5 ) passwordbox
            break;;
        6 ) infobox
            break;;
        7 ) textbox
            break;;
        8 ) checklist
            break;;
        9 ) radiolist
            break;;
        10 ) gauge
            break;;
        11 ) calendar
            break;;
        12 ) timebox
            break;;
        13 ) fselect
            break;;
        14 ) dselect
            break;;
        15 ) form
            break;;
    esac
}

menu() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Menu" \
    --menu "This is same as the 'Main Menu' you were just on." 0 0 0 \
    1 "Redundant, huh"
}

msgbox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Msgbox" \
    --msgbox "This is a message box." 10 40
}

yesno() {
    if dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "YesNo" \
    --yesno "Would you like to continue?" 10 40 ; then
        main
    else
        echo "Feel good about yourself?"
    fi
}

inputbox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "InputBox" \
    --inputbox "Enter your text here" 10 40
}

passwordbox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "PasswordBox" \
    --passwordbox "Enter your password:" 10 40
}

# Notice thaet for this specific instance, using `--clear` would
# Cause issues, like a blank screen, because the menu only lasts
# as long as the program or sleep command dictates
infobox() { 
    dialog \ 
    --backtitle "$BACKTITLE" \
    --title "InfoBox" \
    --infobox "Processing, Please wait..." 10 40
    sleep 2
}

textbox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "TextBox" \
    --textbox all_menus.sh 20 60
}

checklist() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Checklist" \
    --checklist "Select Option(s):" 15 50 4 \
    1 "Option 1" off \
    2 "Option 2" on \
    3 "Option 3" off
}

radiolist() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Radiolist" \
    --radiolist "Choose one(1) option:" 15 50 4 \
    1 "Option 1" on \
    2 "Option 2" off \
    3 "Option 3" off
}

gauge() {
    (
        for i in {1..100}; do
            echo $i
            sleep 0.1
        done
    ) | dialog --clear \
        --gauge "Loading..." 10 50 0
}

calendar() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Calendar" \
    --calendar "Select a date:" 15 50 15 1 2025

}

timebox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "TimeBox" \
    --timebox "Set a time:" 10 50 12 30 00
}

fselect() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "F(ile)Select" \
    --fselect ~/ 15 50
}

dselect() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "D(irectory)Select" \
    --dselect ~/ 15 50
}

form() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Form" \
    --form "User Registration" 20 50 4 \
    "Name:" 1 1 "" 1 10 20 0 \
    "Email:" 2 1 "" 2 10 20 0
}

main
