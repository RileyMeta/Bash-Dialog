# Bash and Dialog scripting
#### This is a comprehensive guide on how to use Dialog and Bash to create terminal-based menus.

Along with tips and tricks for adding basic functionality with Bash scripting and interactive and easily modifiable examples.

### How to use the examples
Every example in this should be able to be run in the terminal with `./example-name`. You may need to use `chmod +x` to allow it to be executable. 

## Absolute Basics
For a Dialog menu to function the only things you need are some basic flags
```bash
dialog --msgbox "Hello World" 0 0
```
`dialog` - tells bash to open the menu

`--msgbox "your text here"` - tells dialog what to render

`0 0` - defines the height/width of the dialog menu (0 = auto)
> [!TIP]
> If you want to make the < OK > button perform functions (like going back to the previous menu) you can use a `case` function to capture and assign the Exit Code `0`.
>
> We will go over this more in just a moment.  

# Optional Arguments:
**For more arguments please refer to the [Man Pages](https://manpages.debian.org/stretch/dialog/dialog.1.en.html).**

`--backtitle "Application Name Here"` - This is the text displayed in the background, often as an Application Name.

`--title "Current Menu Name Here"` - This is the text displayed as a menu label.

`--colors` - Enables Advanced Styling Support

`--clear` - Clears the screen of previous menus

`--cr-wrap` - Keeps the exact source-code formatting exported from the terminal

`--msgbox` - A basic message box with an "okay" button at the bottom
> `$(code)` can be used to run a command in-line with the message box

`--infobox` - A basic message box, similar to msgbox, with no "okay" button and will automatically close  

`--menu` - A basic multi-options menu

`--programbox` - Display the output of a command (Cannot GUI features: Images, Ascii art, etc.)

`--pause` - Add a countdown that needs to finish before the menu can be dismissed

`--yesno` - Create a yes or no dialog box
> The output of --yesno is tied directly to exit codes, there are 2 main ways to deal with this which we will talk about later in the "Exit Codes" section

> `--yes-label "new label here"`: can be used to override the default label 

> `--no-label "new label here"`: can be used to override the default label

`--inputbox` - Allow user text-input

`--passwordbox` - Creates an inputbox that hides user input
> `--insecure` will show all user password inputs as Asterisks `*`

`--help-button` - Add a Help button between the okay and cancel button
> `--help-label "new label here"`: can be used to override the default label

`--extra-button` - Add an extra button between the okay and cancel button
> `--extra-label "new label here"`: can be used to override the default label

## Default Bash Styling
`\n` - Works like a line break

`\` - Works like a line continuation for bash and commands 
> Not necessary for elements inside double quotes `" "` (unless it also contains double quotes, then it should be `\"` to stop it from ending your script)

## Advanced Styling
`\Zn` - Reset all Styling

`\Zb` - Start Bold

`\ZB` - End Bold

`\Zr` - Start Reverse

`\ZR` - End Reverse

`\Zu` - Start Underline

`\ZU` - End Underline

`\Z0` - ANSI Colors: Black (Default) 

`\Z1` - ANSI Colors: Red

`\Z2` - ANSI Colors: Green

`\Z3` - ANSI Colors: Yellow

`\Z4` - ANSI Colors: Blue

`\Z5` - ANSI Colors: Magenta

`\Z6` - ANSI Colors: Cyan

`\Z7` - ANSI Colors: White

## Exit Codes
**In Bash whenever a command or application is ran it will report to the shell an "Exit Code" which can be used to determine user-input in Dialog**

The direct outputs of these can be both defined in the later section, and or called directly from your script.

`STDIN` (Standard input) - this is the file handle that your process reads to get information from you.
> This default value is always used for the "Okay" button and cannot be specified

`STDOUT` (Standard output) - your process writes conventional output to this file handle.
> `--stdout` can also be used in Dialog to specify, per-menu

`STDERR` (Standard error) - your process writes diagnostic output to this file handle.
> `--stderr` can also be used in Dialog to specify, per-menu 

> [!TIP]
> If you want to see what an exit code is directly from the Terminal you can use the command `echo "$?"` and it'll print the Exit Code. 

## Default Dialog Values
`DIALOGOPTS` - Define this variable to apply any of the common options to each widget. Most of the common options are reset before processing each widget. If you set the options in this environment variable, they are applied to dialog's state after the reset. As in the "--file" option, double-quotes and backslashes are interpreted. The "--file" option is not considered a common option (so you cannot embed it within this environment variable).

`DIALOGRC` - Define this variable if you want to specify the name of the configuration file to use.

`DIALOG_CANCEL` - (See DIALOG_OK)

`DIALOG_ERROR` - (See DIALOG_OK)

`DIALOG_ESC` - (See DIALOG_OK)

`DIALOG_EXTRA` - (See DIALOG_OK)

`DIALOG_HELP` - (See DIALOG_OK)

`DIALOG_ITEM_HELP` - (See DIALOG_OK)

`DIALOG_OK` - Define any of these variables to change the exit code on Cancel (1), error (-1), ESC (255), Extra (3), Help (2), Help with --item-help (2), or OK (0). Normally shell scripts cannot distinguish between -1 and 255.

`DIALOG_TTY` - Set this variable to "1" to provide compatibility with older versions of dialog which assumed that if the script redirects the standard output, that the "--stdout" option was given.
> - A standard definition looks like this: `DIALOG_TTY=1`

## Bash Error Handling
**One of the coolest things about Bash as a scripting language is probably the built-in error handling.**

When stringing together commands there are a few ways to run multiple commands:

`;` - A completely sequential continuation of commands, requires the previous command to end first (Does not acknowledge Exit Codes):
> `mkdir /tmp/test ; tough /tmp/test/ThisIsATest`

`&` - Executes commands in the background, does not require previous commands to end (Good for Parallelization):
> `mkdir /tmp/test1 & mkdir /tmp/test2` | Not related to `&&`

`|` - Add the output of the previous command to a new command:
> `man bash | grep "control operator"` | Not related to `||`

### **The important ones:**

`&&` - Executes **_if and only if_** the previous command "exits **_successfully_**" (Exit Code: 0):
> - `mkdir /tmp/test3 && echo "Folder Created Successfully"` 
> - `echo "Your Text Here"` will print whatever is in the double-quotes to the terminal.
 
`||` - Executes **_if and only if_** the previous command "**_fails_**" (Exit Code: 1):
> `mkdir /tmp/test3 || echo "Folder Already Exists"`

Both of these use the same commands on purpose. When executed the first time it should succeed, the second time should throw an error because the folder already exists.
> These can be strung together to create consistent error handling for larger scripts. 
> `mkdir /tmp/test4 && echo "Folder Created Successfull" || echo "Folder Already Exists"`

## Bash Coding
Bash _is_ an entire scripting language. Although it may not be as powerful as something like C or Python, it does directly interact with the system kernel allowing you to perform powerful operations quickly.

> See the Basic Example below for more info

## Basic Example Menu
Often you'll find that almost all scripts used in bash will contain what is called a "shebang". This is `#` (shell) `!` (bang) followed by `/bin/bash` (the bash shell path). This marks the file as a bash script with commands inside it that should be executed. 

Below is a basic example menu:
![image](https://github.com/RileyMeta/Bash-Dialog/assets/32332593/b88244e5-8908-4adb-8e05-b33a024e218d)

```bash
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
```
> OR 
```bash
#!/bin/bash

main() {
    CHOICE=$(dialog --clear \
    --backtitle "My Application Title" \
    --title "Application Page" \
    --menu "Page Content would go here." 0 0 0 \
    1 "Option 1" \
    2 "These can be named anything" \
    3 "Option 3" \
    2>&1 >/dev/tty)

    case $CHOICE in
        1 ) do_thing_1;;
        2 ) do_thing_2;;
        3 ) do_thing_3;;
    esac
}
```

### Launching Commands
Paying attention to the above file actually explains a lot of how it works, most importantly is the indented parts immediately after both `then` and `else`. 

First it uses the built-in bash command `clear` to remove all text, then using `echo` it prints the text to the newly cleared Terminal.

You could chain as many commands together in this space as you'd want, including error handling. This can be anything from other applications (example: cfdisk, fdisk, cp, mv, nano, etc) to pre-defined bash functions.

So long as you don't explicitly tell the app to `exit` then it should re-open when the secondary app closes. 

The layout of the above file only has 1 predefined function that gets called at the end of the file with `main`.

> See the below Advanced Menu Example for more information.


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
## Adding Double Quotes or other special characters
If attempting to display special characters like `" "` `$` `{ }` or similar you can cancel out them being rendered as actual code (and thus breaking your current code) by prefacing it with a `\`

Example: 
![image](https://github.com/RileyMeta/Bash-Dialog/assets/32332593/452a1b79-b41a-4cef-bb80-a7311071011c)
```bash
#!/bin/bash

main() {
    dialog --clear \
    --backtitle "Double Quotes Tutorial" \
    --colors \
    --title "This is a simple Double Quotes Tutorial" \
    --msgbox "\nIn bash if you preface special characters like \$ and \" you can display them in text." 0 0
}

main
```
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
## Dynamic Text
> [!TIP]
> This works for any text. You can change button labels, titles, texts, backtitles, and even menu options.

![Dynamic_text](https://github.com/RileyMeta/Bash-Dialog/assets/32332593/4ec6fc36-d754-4bca-a3e5-607c9b154003)
```bash
#!/bin/bash

# # This script intentionally loops forever, please press Ctrl+C to exit.

trap 'clear && exit' INT # trap the ctrl+c input (INT) and execute the code between the single quotes

DEFAULT_VARIABLE=true

dynamic_text() {
    options=("option 1" "option2" "option3") # Add more as you need.
    # You could also pipe in the options from a file with `options=$(cat /path/to/file)`
    # If necessary more adjustments can be chained together with more command arguments / regular expressions

    menu_options=() # Define an empty array that we will add to later.
    i=1 # The number of the menu options | Start at 1, goes up to whatever is needed
    for option in "${options[@]}"; do # Loop through the individual items IN the array | [@] = All items
        menu_options+=("$i" "$option") # Add the new options to the empty array we made earlier.
        ((i++)) # Add 1 to the number
    done # End the loop and continue the rest of the script

    exec 3>&1 # execute the below code and save the input to STDERR (a Bash Variable for temporary storage)
    message="Default Variable: ${DEFAULT_VARIABLE}" # Assign the original message
    if [ $DEFAULT_VARIABLE = true ]; then # Define an if statement to check the DEFAULT_VARIABLE 
    # You can change the variable to any type, but if you're expecting more than 3 values, please use a case/esac statement for better performance
        message+="\nThis is the first message"
    else
        message+="\nThis is the second message"
    fi
    message+="\n\nPlease select a button below:"
    if dialog --clear \
        --title "Locale Selection" \
        --colors \
        --yes-label "TRUE" \
        --no-label "FALSE" \
        --yesno "${message}" 0 0;
    then
        # If you don't define the default Variable, it will stay at the default value
        DEFAULT_VARIABLE=true # Re-assign the Default Variable
        dynamic_text # Restart the Dialog Menu
    else
        DEFAULT_VARIABLE=false # Re-assign the Default Variable
        dynamic_text # Restart the Dialog Menu
    fi
}

dynamic_text
```

# Extensive ANSI Colors List (Terminal Only)
```bash
WHITE="\e[97m"
BLACK="\e[30m"
GRAY="\e[90m"	
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
LIGHT_GRAY="\e[37m"
LIGHT_RED="\e[91m"
LIGHT_GREEN="\e[92m"
LIGHT_YELLOW="\e[93m"
LIGHT_BLUE="\e[94m"
LIGHT_MAGENTA="\e[95m"
LIGHT_CYAN="\e[96m"

BOLD="\e[1m"
FAINT="\e[2m"
ITALICS="\e[3m"
UNDERLINE="\e[4m"
FLASHING="\e[5m"
FLASHING2="\e[6m"
INVISIBLE="\e[7m"
THROUGH-LINE="\e[9m"

BACKGROUND_WHITE_READABLE="\e[7m" # With Black Text

BACKGROUND_BLACK="\e[40m"
BACKGROUND_RED="\e[41m"
BACKGROUND_GREEN="\e[42m"
BACKGROUND_YELLOW="\e[43m"
BACKGROUND_BLUE="\e[44m"
BACKGROUND_MAGENTA="\e[45m"
BACKGROUND_CYAN="\e[46m"
BACKGROUND_GRAY="\e[100m"
BACKGROUND_LIGHT_GRAY="\e[47m"
BACKGROUND_LIGHT_RED="\e[101m"
BACKGROUND_LIGHT_GREEN="\e[102m"
BACKGROUND_LIGHT_YELLOW="\e[103m"
BACKGROUND_LIGHT_BLUE="\e[104m"
BACKGROUND_LIGHT_MAGENTA="\e[105m"
BACKGROUND_LIGHT_CYAN="\e[106m"
BACKGROUND_WHITE="\e[107m" # With white Text

ENDSTYLE="\e[0m"
```
Any of the above can be added to a Bash Script to add their respective effects
`echo -e "${UNDERLINE}Text you want to be underlined${ENDSTYLE}"`
> You can reassign any of the names as you see fit.

## Development Notes: 
> [!IMPORTANT]
> The information in here might not be 100% accurate, please do your own research.
> 
> Everything I've accumulated here is from personal testing, if there are better ways to do things, please submit them in a Pull Request


# References
- [Dialog - Man Pages](https://manpages.debian.org/stretch/dialog/dialog.1.en.html)
- [Bash - Man Pages](https://dyn.manpages.debian.org/bookworm/bash/bash.1.en.html)
- [LinuxCommand](https://linuxcommand.org/lc3_adv_dialog.php)
- [FreeCodeCamp](https://www.freecodecamp.org/news/bash-scripting-tutorial-linux-shell-script-and-command-line-for-beginners/#:~:text=Bash%20scripting%20is%20a%20powerful,tasks%20in%20Unix%2FLinux%20systems.)
