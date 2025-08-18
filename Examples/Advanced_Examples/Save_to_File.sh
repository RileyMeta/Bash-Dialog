#!/bin/bash

saveToFile() {
    clear
    dialog --clear \
      --backtitle "$BACKTITLE" \
      --title "Test Save to file" \
      --menu "\nThis is a test menu that uses save-to-file instead of direct input.
\n
\nThis could be a really good thing to help create a config file, or similar.
" 0 0 0 \
      1 "I like Coffee" \
      2 "I like Tea" \
      2> /tmp/drinkChoice # This is the main part, taking the output "2" and the built-in Bash command ">" to
                         # send the output to a file

    choice=$(cat /tmp/drinkChoice) # This converts your answer to a variable "choice"
    case $choice in # This takes your answer as read from the variable and executes the associated command
        1 ) Coffee;;
        2 ) Tea;;
    esac
}

saveToFile
