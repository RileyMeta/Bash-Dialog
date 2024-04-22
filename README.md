# Bash and Dialog scripting
**This is a comprehensive guide on how to use Dialog and Bash to create terminal-based menus.**

**Along with tips and tricks for adding basic functionality with Bash scripting.** 


## Absolute Basics
For a Dialog menu to function the only things you need are some basic flags
```bash
dialog --msgbox "Hello World" 0 0
```
`dialog` - tells bash to open the menu

`--msgbox "your text here"` - tells dialog what to render

`0 0` - defines the height/width of the dialog menu (0 = auto)

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
> Not necessary for elements inside double quotes `" "`

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

## Development Notes: 
> [!NOTE]
> The information in here might not be 100% accurate, please do your own research.

> [!IMPORTANT]
> I DO plan on continuing this project and expanding this documentation when I learn more.

# References
- [Dialog - Man Pages](https://manpages.debian.org/stretch/dialog/dialog.1.en.html)
- [Bash - Man Pages](https://dyn.manpages.debian.org/bookworm/bash/bash.1.en.html)
- [LinuxCommand](https://linuxcommand.org/lc3_adv_dialog.php)
- [FreeCodeCamp](https://www.freecodecamp.org/news/bash-scripting-tutorial-linux-shell-script-and-command-line-for-beginners/#:~:text=Bash%20scripting%20is%20a%20powerful,tasks%20in%20Unix%2FLinux%20systems.)
