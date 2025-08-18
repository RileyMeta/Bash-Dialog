## Advanced Menu Example
![image](https://github.com/RileyMeta/Bash-Dialog/assets/32332593/18930555-8afa-40ad-9de8-0e2a2c55e43e)

```bash
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
```
The above example goes over multiple techniques that you can use to capture user-input along with a few trouble shooting techniques.

## Explaining the Advanced Menu Example

We're going to work our way down while I explain it to the best of my ability. 

Skipping over the shebang, you'll notice I have a string written out as `BACKTITLE="Your App Title"`
> This is a basic variable, due to it being defined **outside** of the `main()` function it can be called by any menu. 

Next is `trap 'aborted' INT` which is a very small function.
> - `trap` - A pre-defined Bash function that listens for specific Key Combo
> - `'aborted'` - A Custom function written to clear the terminal and print 2 strings 
> - `INT` - This is the specific Key Combo that we want to `trap` (In this case, `Ctrl`+`C`)

Next is the actual `aborted` function
```bash
aborted() {
    clear # Basic Bash command to clear the terminal
    echo "Your App has been Aborted." # A Basic Bash command to print text to the Terminal
    echo "If this was due to a bug or issue, please report it to the the Github." 
    exit 0 # Exiting the App and assigning an Exit Code
}
```

Next is the `userExit` function, near identical to `aborted` but with a "successful" exit code.
> This can actually be replaced with the default Bash command `:` (colon) which immediately quits an app and exports a "successful" exit code.

After this we define the actual `main` function that will work as our app.
```bash
main() { # The name of this does not matter so long as it matches the string at the end of the file
    while true; do # This app will loop infinitely until explicitly stopped by the user
    mainMenuOptions=( # Define the options so you can actually use the Cancel Button
    1 "Run Command Embedded" # Button Label 
    2 "Dummy Menu" # Button Label
    3 "Run Command Literally" # Button Label
)

result=$(dialog --clear --title "Main Menu" \ # This is the actual visuals of the app
    --backtitle "$BACKTITLE" \ # The name of the app displayed on the background
    --cancel-label "Exit" \ # Add a custom label to the bottom-right button 
    --stdout \ # Export the standard output 
    --menu "Choose a Chapter" 0 0 3 "${mainMenuOptions[@]}") # Call the options that we defined earlier
                                # ^ Loosely defines the size of the options in the menu (can also be 0 for auto)
          # ^ This is the text that gets shown before the menu options. Feel free to use \n to add multiple lines
case $? in # case is the bash way of defining what multiple options actually do
   # ^ This is the default bash "return exit code"
    0)  case $result in # The 0) transfers ownership of the 0 exit code to the next list of items
      # ^ This defines the actual menu items in 'results'
            1) menu2 ;; # Opens a pre-defined 'menu2' item 
            2) menu3 ;; # Opens a pre-defined 'menu3' item
            3) menu4 ;; # Opens a pre-defined 'menu4' item
        esac # Tells Bash that 'case' is done
        ;; # Tells Bash that option 0 is done
    1) userExit ;; # When the 'cancel' button is pressed it will run the pre-defined 'userExit' function
esac # Tells Bash that case is done 
    done # The ending declaration for 'do'
}
```
Next we defined what the individual options actually do by assigning them functions:
```bash
menu2() { # Function Name
    clear # Default Bash command to clear the terminal 
    dialog --clear \ # Tell Bash to run dialog and tell dialog to clear the terminal
    --backtitle "$BACKTITLE" \ # Your previously defined App Name
    --colors \ # Enable Advanced Styling Support 
    --cr-wrap \ # Force the menu to retain the command text formatting 
    --title "IP Link Embedded" \ # The name of this specific menu (this is visible to the user)
    --msgbox "\nThis is to show the \ZbIP Link\ZB command embedded in a message box # A note about what this menu is used for 
\n\Z1\Zbroot #\Zn ip link # Custom styling to explain the command 
\n$(ip link)" 0 0 # In Bash $ will run a new command and in Dialog that needs to be wrapped in Parenthesis, thus: $(command) 
            # ^ These set the height and width of the menu to "auto auto"
}

...

menu4() { # Name of Function
    clear # Clear Terminal 
    if dialog --clear \ # Bash Quirk: the if/else dialog is started before the actuall command. In Dialog this translates to "If: Okay Button, Else: Cancel Button"
    --backtitle "$BACKTITLE" \ # App title 
    --title "Run IP Link" \ # Menu Title 
    --yesno "Would you like to run IP Link now?" 0 0 ; # Notice! this is one of the only times in Dialog that the height and width are ended with a semi-colon (;)
    then # This starts the wrapper for the code that's going to be executed when you press "okay"
      clear; ip link; exit # The actual code that will execute (Remember semi-colons (;) in commands mean to execute in succession)
    else  # This Ends the "okay" code and begins the code for "cancel" 
      main # This will close the current menu and open the main menu
    fi # This tells Bash that the "if" statement is done
}
```
Lastly we have `main` which actually starts the app when we call it in the terminal.

## Saving Responses to Files
```bash
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
```

## Saving User Input (Text)
![image](https://github.com/RileyMeta/Bash-Dialog/assets/32332593/7af1a271-210f-423f-8e1b-8bf4c0b07ae1)
```bash
#!/bin/bash

get_user_input() {
    local input
    input=$(dialog --clear \
    --backtitle "Dialog Tutorials" \
    --title "Save User Input" \
    --inputbox "Please type your Name:" 8 40 \
    --output-fd 1)

    if [ $? -eq 0 ]; then
        clear
        echo "User input: $input"
    else
        clear
        echo "User pressed cancel."
    fi
}

get_user_input
```
This might be a new way of invoking Dialog, but it's Virtually the same as the rest.
- First we tell bash that we're going to be using `local` variables (in THIS function only).
- Second we tell Bash that the function's name is `input` which we later envoke with `$input`.
- Next we setup `dialog` as normal with our arguments and styling.
- `--output-fd 1` will override and export the user-input to Exit Code `1` (stdout) which we call in the next part.
- Lastly we make the actual `if`/`else` statement: When the user types something and presses the `< OK >` button it will echo it directly to the Terminal. When the `< Cancel >` button is pressed it will print "User pressed Cancel" to the Terminal. 
> [!TIP]
> If you would like to limit the amount of characters that the user can input, use `----max-input` (followed by a number) 

## Advanced Menu Linking
```bash
#!/bin/bash

# Collect the User's Name and Email
USER_INFO=$(dialog --form "User Registration" 15 50 3 \
    "Username:" 1 1 "" 1 10 20 0 \
    "Email:" 2 1 "" 2 10 20 0 \
    3>&1 1>&2 2>&3 3>&-)

if [ $? -ne 0 ]; then
    echo "Form entry was canceled."
    exit 1
fi

# Parse the USER_INFO fields with sed
USERNAME=$(echo "$USER_INFO" | sed -n '1p')
EMAIL=$(echo "$USER_INFO" | sed -n '2p')

# Collect Password // Allow Asterisk instead of Zero Response (--insecure)
PASSWORD=$(dialog --insecure --passwordbox "Enter your password:" 10 40 3>&1 1>&2 2>&3 3>&-)

if [ $? -ne 0 ]; then
    echo "Password entry was canceled."
    exit 1
fi

# Display the collected data
dialog --msgbox "Username: $USERNAME\nEmail: $EMAIL\nPassword: (hidden)" 10 40
```
Here we're:
- Saving the input provided by the user to the variables
- Splitting the first input menu into 2 separate variables with the `sed` GNU Core Utility
- Checking if either of the inputs were canceled and gracefully shutting down
- Displaying the collected info with a --msgbox
> [!NOTE]
> The password will always display (hidden), this can be dynamically changed if you'd prefer

## Dynamic Menu Selection
If you're intending to have the menu items on a primary menu update and highlight the next option instead of defaulting to the Very First option, you can use 
`--default-item` with any variable you need/want, in this case we'll use `"$default_item"`. By default `--default-item` is set to `1`, or the first menu item.

To change each item you need to re-assign the value of `default_item` before the user returns to the primary menu.

Example:
```bash
dialog --clear --title "Dynamic Text" \
--default-item "$default_item"
--menu "This is my menmu" 0 0 0
...
```
Example changing menu item from another menu:
```bash
...
if [[ $? = 0 ]]; then
    default_item=2
    main
else
    main
fi 
```
