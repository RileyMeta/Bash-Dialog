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

> See the [Advanced Menu Example](https://github.com/RileyMeta/Bash-Dialog/tree/main/Examples/Advanced_Examples) for more information.

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
