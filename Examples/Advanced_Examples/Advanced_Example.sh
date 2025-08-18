#!/bin/bash

BACKTITLE="Your App Title"

trap 'aborted' INT

aborted() {
    clear
    echo "Your App has been Aborted."
    echo "If this was due to a bug or issue, please report it to the the Github."
    exit 0
}

userExit() {
    clear
    echo "Your App has closed successfully."
    echo "Thank you, have a great day!"
    exit 1
}

main() {
    while true; do
    mainMenuOptions=(
    1 "Run Command Embedded"
    2 "Dummy Menu"
    3 "Run Command Literally"
)

result=$(dialog --clear --title "Main Menu" \
    --backtitle "$BACKTITLE" \
    --cancel-label "Exit" \
    --stdout \
    --menu "Choose an Option" 0 0 3 "${mainMenuOptions[@]}")

case $? in
    0)  case $result in
            1) menu2 ;;
            2) menu3 ;;
            3) menu4 ;;
        esac
        ;;
    1) userExit ;;
esac
    done
}

menu2() {
    clear
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --colors \
    --cr-wrap \
    --title "IP Link Embedded" \
    --msgbox "\nThis is to show the \ZbIP Link\ZB command embedded in a message box
\n\Z1\Zbroot #\Zn ip link
\n$(ip link)" 0 0
}

menu3() {
    clear
    dialog --clear \
    --backtitle "$BACKTITLE" \
    --colors \
    --title "Dummy Menu" \
    --msgbox "This just a Dummy Menu" 0 0
}

menu4() {
    clear
    if dialog --clear \
    --backtitle "$BACKTITLE" \
    --colors \
    --title "Run IP Link" \
    --yesno "Would you like to run IP Link now?" 0 0 ;
    then
      clear; ip link; exit
    else
      main
    fi
}

main
