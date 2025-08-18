## How to use the Extra button
![image](https://github.com/RileyMeta/Bash-Dialog/assets/32332593/88bad361-1fd4-4d2d-abd8-99c8bb0e1fb0)
```bash
#!/bin/bash

dialog --clear \
        --backtitle "Dialog Tutorials" \
        --title "How to use the Extra Button" \
        --extra-button \
        --extra-label "Secrets" \
        --yesno "Press <Secrets> to see some Secrets" 0 0 2>&1 >/dev/tty

dialog_exit_code=$?

if [ $dialog_exit_code -eq 3 ]; then
    clear
    echo "The Secrets button was pressed"
elif [ $dialog_exit_code -eq 0 ]; then
    clear
    echo "Yes button was pressed"
else
    clear
    echo "No button was pressed"
fi
```
As we know from earlier, Dialog only operates on Exit codes. This still applies for the Extra button that you can use in Dialog.

In this Example, we added the `--extra-button` to the arguments of Dialog, then customized the label with `--extra-label "Secrets"` to say what we wanted.

Next up comes the actual code of this dialog box:
- First we Capture the Exit Code with a Variable: `dialog_exit_code=$?`
- Next we initiate the `if` function by telling it to search for `[ $dialog_exit_code -eq 3 ]` which checks the output and sees if it `-eq` (equals) the desired output.
- `then` we give it the actual functions and commands that we want it to execute when that button is pressed.
- `elif` is basically `else if` and defines what `else` we want to happen `if` the second button is pressed
- Similar to the previous, we're going to force it to search for the exit code with our `$dialog_exit_code` variable
- Followed by the `else` which is almost* always our `No` button (The label can also be redefined wtih `--no-label "Label"`)
- This is again ended with `fi` to tell Bash that it's done reading the `if` statement.

> [!TIP]
> Adding the additional `then` statements are necessary for this to work as the commands are only executed after being defined. 

Alternatively, you can use the `case` function like it's a `--menu`, but with the Exit Codes instead of the Menu Labels (numbers)
```bash
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
```
> [!NOTE]
> This was also designed as an internal Function, so it can be called from another menu.

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
