# GUI / X applications

While an HPC system is primarily a platform optimised for submitting jobs/scripts via command line interface, graphical applications that provide development tools or visualisation of data are supported.

## X forwarding

If you want to forward the GUI of applications you start through your SSH session, you have to enable X-forwarding. If you are using an SSH client, that is usually done in the advanced options of your session. If you connect through a console, use the -X parameter:

```
ssh -X <nodename>
```

Any GUI application you load/run will be displayed in you desktop session.

## Forward to third party system

To redirect the display to a system beyond the HPC, on another server/desktop machine:

```
export DISPLAY=<hostname>:<x>
```
Where <hostname> is the full hostname/ip address of the machine you want to display on and <x> is the number of the session on that machine. For example :

```
export DISPLAY=random-pc.campus.gla.ac.uk:3
```

!!! note
    The target machine needs to have an “X” compatible windowing system running – could be a standard linux system like Gnome or KDE or other local X-windows system
