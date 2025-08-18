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
> [!NOTE]
> For more arguments please refer to the [Man Pages](https://manpages.debian.org/stretch/dialog/dialog.1.en.html)
> or look at the [all_menus.sh](https://github.com/RileyMeta/Bash-Dialog/main/all_menus.sh) file to interactively see all dialog menu options.

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

### Linking multiple files
Bash does allow for linking of multiple files as if they were a single file with one of the following:
```bash
source ./second_script.sh
. ./second_script.sh
```

## Function Parameters
Thanks to the way bash functions are called (`function` instead of `function()`) setting up function parameters is a little confusing unless you know what to do. Functions tend to count the immediate next text as a parameter, so `function 1 2 3 4` could have 4 different parameters, which are outlined below in an example.
```bash
error() {
    local parameter=$1
    local parameter=$2
    local parameter=$3
    local parameter=$4

    ...
}
```

## Script Launch Arguments
Similar to how function parameters are issued, bash scripts can also take in parameters (or run-time flags) that change the way your script works, below is a simple example for adding a `--help` flag.
```bash
if [[ '$1' == '--help' ]]; then
    echo "--help opens this menu"
fi
```
If you are more comfortable using case statements:
```bash
case $1 in
    '--help') echo "--help opens this menu" ;;
esac
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
