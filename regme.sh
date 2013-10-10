#!/bin/bash
#set some vars
sshkey="$HOME/.ssh/id_rsa"
#the main symlink location your shell variable always points to
auth_sock_loc="$HOME/ssh_auth_sock"
#the location where your forwarded socket is
auth_sock_rem_loc="$HOME/ssh_auth_sock_rem"

 if [ "$1" == "help" -o "$1" == "-h" -o "$1" == "?" ]
 then
        echo "This will function will launch ssh-agent and ssh-add to register your private key locally on this server for continued usage when your not logged in, and when you log back in:)"
        echo "running just \"reg\" will register you making sure to first check if you are already registered...running \"reg kill\" will kill any current ssh-agent processes in event of a problem/error/corruption"
        exit
 fi
 if [ "$1" == "kill" ]
 then
        #Maybe theres a problem...this kills all ssh-agents running as youre user
        echo "Killing any running agents..."
        ps -u $LOGNAME | grep 'ssh-agent'
        killall -u $LOGNAME ssh-agent
        #setting our symlink to pnt to our remote forwarded socket
        cp -P "$auth_sock_rem_loc" "$auth_sock_loc"
        echo "Done...exiting."
        exit
 fi
 if pgrep -u $LOGNAME ssh-agent >/dev/null
 then
        echo "Yay!!! Already registered on this server ($(hostname))! Exiting..."
        exit

 else
        #Looks like we arent ssh-agented (for lack of a better word, or im just lazy) on this server
        echo "Not registered on *$(hostname)* (ssh-agent not already running)....starting up..."
        eval `ssh-agent` && ln -sf $SSH_AUTH_SOCK "$auth_sock_loc" && ssh-add "$sshkey"
        echo "Done! Your key is registered on this server. Any continuously running scripts should work successfully."
 fi
