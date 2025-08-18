#!/bin/bash

main() {
    clear
    if dialog --clear \
    --title "test" \
    --yesno "Would you like to continue?" 0 0 ;
    then
      clear
      echo "Task Succeeded"
    else
      clear
      echo "Task Failed"
    fi
}

main
