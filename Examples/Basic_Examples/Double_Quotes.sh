#!/bin/bash

main() {
    dialog --clear \
    --backtitle "Double Quotes Tutorial" \
    --colors \
    --title "This is a simple Double Quotes Tutorial" \
    --msgbox "\nIn bash if you preface special characters like \$ and \" you can display them in text." 0 0
}

main
