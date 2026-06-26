# DMTCP

DMTCP (Distributed MultiThreaded Checkpointing) transparently checkpoints a single-host or distributed computation in user-space with no modifications to user code or to the OS. It works on most Linux applications, including Python, Matlab, R, GUI desktops, MPI, etc.

A list of all available commands within this module can be found here:

`ls -la $DMTCPBIN`

Use --help on any of them to get more information on the command!

## Example
This is a very basic example of the utility for this software.

For this example we use a program written in C called checkpoint_test, that runs for 3 minutes and prints a line of code every second:

Code:
```
#include <stdio.h>
#include <unistd.h>

int main (void)
{
        printf ("I will do a loop every second!\n");
        for (int i = 1 ; i < 181 ; i++) {
                printf ("This is loop %d\n", i);
                sleep(1);
        }
        printf ("That was all the loops!\n");
        return 0;
}
```

Output:

```
I will do a loop every second!
This is loop 1
This is loop 2
This is loop 3
This is loop 4
...
This is loop 180
That was all the loops!
```

Now instead of running this program normally, we run it through DMTCP with `dmtcp_launch` and tell it to checkpoint the run every 35 seconds with the `--interval` parameter :

```
$ dmtcp_launch --interval 35 ./checkpoint_test
I will do a loop every second!
This is loop 1
This is loop 2
...
```

This will create and overwrite a .dmtcp (checkpoint) file every 35 seconds in your current working directory. Additionally with the parameter --ckptdir you can set where the checkpoint files should be written to. With larger applications, the checkpoints can get really big, so storing them in your scratch or project directory is a good idea, to avoid running out of space.


If your application were to crash, you can restart your job from the last checkpoint taken. You can simulate a crash by using ctrl+C or cancelling your Slurm job. Here we cancelled at loop 50:

```
...
This is loop 47
This is loop 48
This is loop 49
This is loop 50
^C
$
```

To restart use the `dmtcp_restart` utility and provide the .dmtcp file as the parameter. This should start your program again at about loop 36, as 35 was the last time a checkpoint was taken:

```
$ dmtcp_restart ckpt_checkpoint_test_xxx.dmtcp
This is loop 36
This is loop 37
This is loop 38
...
```

## External Resources

[DMTCP Website](https://dmtcp.sourceforge.io/)

[DMTCP Overview](https://dmtcp.sourceforge.io/dmtcp-mug-17.pdf)

