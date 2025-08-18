#!/bin/bash
# Notice that it's common practice to split lines of a long command by separating the lines with a single backslash.

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

# Syntax: dialog --menu <text> <height> <width> <menu-height> <tag> <item>
menu() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Menu" \
    --menu "This is same as the 'Main Menu' you were just on." 0 0 0 \
    1 "Redundant, huh"
}

# Syntax: dialog --msgbox <text> <height> <width>
msgbox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Msgbox" \
    --msgbox "This is a message box." 10 40
}

# Syntax: dialog --yesno <text> <height> <width>
# As you can see, I've wrapped this entire dialog menu in an If statement, to capture the user-input.
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

# Syntax: dialog --inputbox <text> <height> <width> <initial-text/placeholder>
inputbox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "InputBox" \
    --inputbox "Enter your text here" 10 40 "Placeholder"
}

# Syntax: dialog --passwordbox <text> <height> <width> <init-text/placeholder>
# Not really recommended to add any 'init-text' for passwords, but you can.
passwordbox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "PasswordBox" \
    --passwordbox "Enter your password:" 10 40
}

# Syntax: dialog --infobox <text> <height> <width>
# Notice that for this specific instance, using `--clear` would
# cause issues, like a blank screen, because the menu only lasts
# as long as the program or sleep command dictates
infobox() { 
    dialog \ 
    --backtitle "$BACKTITLE" \
    --title "InfoBox" \
    --infobox "Processing, Please wait..." 10 40
    sleep 2
}

# Syntax: dialog --textbox <file> <height> <width>
textbox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "TextBox" \
    --textbox all_menus.sh 20 60
}

# Syntax: dialog --checklist <text> <height> <width> <list-height> <tag> <item> <status>
checklist() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Checklist" \
    --checklist "Select Option(s):" 15 50 4 \
    1 "Option 1" off \
    2 "Option 2" on \
    3 "Option 3" off
}

# Syntax: dialog --radiolist <text> <height> <width> <list-height> <tag> <item> <status>
radiolist() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Radiolist" \
    --radiolist "Choose one(1) option:" 15 50 4 \
    1 "Option 1" on \
    2 "Option 2" off \
    3 "Option 3" off
}

# Syntax: dialog --gauge <text> <height> <width> <percent>
# Notice this is piped | directly into the gauge dialog menu.
gauge() {
    (
        for i in {1..100}; do
            echo $i
            sleep 0.1
        done
    ) | dialog --clear \
        --gauge "Loading..." 10 50 0
}

# Syntax: dialog --calendar <text> <height> <width> <day> <month> <year>
calendar() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Calendar" \
    --calendar "Select a date:" 15 50 15 1 2025

}

# Syntax: dialog --timebox <text> <height> <width> <hour> <minute(s)> <second(s)>
timebox() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "TimeBox" \
    --timebox "Set a time:" 10 50 12 30 00
}

# Syntax: dialog --fselect <directory> <height> <width>
fselect() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "F(ile)Select" \
    --fselect ~/ 15 50
}

# Syntax: dialog --dselect <directory> <height> <width>
dselect() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "D(irectory)Select" \
    --dselect ~/ 15 50
}

# Syntax: dialog --form <text> <height> <width> <form-height> <label> <y> <x> <initial> <ylength> <xlength>
form() {
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --title "Form" \
    --form "User Registration" 20 50 4 \
    "Name:" 1 1 "" 1 10 20 0 \
    "Email:" 2 1 "" 2 10 20 0
}

main
