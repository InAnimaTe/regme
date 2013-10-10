#### Welcome to regme...

##### The Problem

Regme is a ssh-agent socket manager for forwarded ssh keys on a host.
I ran into problems at work where when using a private key (with a passphrase) was great...
except for when you start using a virtual terminal.

##### What is needed

In order to keep a socket alive that your virtual terminal can keep utilizing, some
management is necessary to ensure your terminals always have an updated and alive socket to use.

##### How it works

>__Here's the premise:__ We utilize a symlink as our main socket that all shells know about all the time.
>We then modify this symlink depending on the socket we want to use. For remote servers, we end up
>utilizing ssh-agent and loading our key there and then setting our shells to use it. If we end
>the ssh-agent process, we want the symlink to point to our current socket that was/is created 
>at our/every ssh login.

This is awesome because it enables us to leave scripts running that utilize authentication 
whilst not logged into the server!

You can probably read through some of regme and get a pretty good grasp of whats going on here.

##### What you need

1. A linux box with ssh-agent installed (never seen one with out it).
2. A home directory with obvious write perms.

##### How to use it

1. Copy the rc file to ~/.ssh/
2. Add the contents of .zshrc to your .zshrc/.bashrc file.
3. Copy regme somewhere and edit the top of the file...specifying the ssh key to load into ssh-agent and the locations for the symlinks (i store em in my homedir)
4. Run the regme script whenever you want to "register" yourself on the box! This will essentially check if you are already registered, and if not,
   launch ssh-agent, setup your symlink to point to the new socket, and run ssh-add with the key you want added.

Usage: ```regme.sh [kill | ?/-h/help]```

Running the script with 'kill' will kill ssh-agent. 

##### More on this

More on the details of this and some of the original code here: http://scriptthe.net/2013/09/11/seriously-managing-ssh-forwarding-in-virtual-terminals-and-beyond/
