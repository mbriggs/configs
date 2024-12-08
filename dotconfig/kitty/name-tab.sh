#!/bin/zsh

# echo -n  "=> Set Tab Title: "
# read new_tab_title
#
# kitty @ set-tab-title "$new_tab_title"
#
#!/bin/zsh
#!/bin/zsh
#!/bin/zsh
#!/bin/zsh

# Check if tput is available
if ! command -v tput >/dev/null 2>&1; then
    echo "Error: tput is required but not installed."
    echo "Install ncurses package to get tput."
    exit 1
fi

# Save cursor position and enable alternative buffer
tput smcup

# Move cursor to center of screen
rows=$(tput lines)
cols=$(tput cols)
middle_row=$(( rows / 2 ))
middle_col=$(( (cols - 20) / 2 ))
tput cup $middle_row $middle_col

echo -n "Set Tab Title: "

# Read input character by character
title=""
while IFS= read -r -s -k1 char; do
    # Check for escape key
    if [[ $char == $'\e' ]]; then
        tput rmcup
        exit 0
    fi
    
    # Check for enter key
    if [[ $char == $'\n' ]]; then
        break
    fi
    
    # Handle backspace (both ^H and ^?)
    if [[ $char == $'\b' || $char == $'\177' ]]; then
        if [[ -n "$title" ]]; then
            title=${title%?}
            echo -n $'\b \b'  # Move back, clear character, move back again
        fi
        continue
    fi
    
    # Add character to title and echo it
    title+="$char"
    echo -n "$char"
done

# Only set the title if we got some input
if [[ -n "$title" ]]; then
    kitty @ set-tab-title "$title"
fi

# Restore cursor position and exit alternative buffer
tput rmcup
