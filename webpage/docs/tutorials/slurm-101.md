# Slurm for Beginners
This small tutorial should give you a start to the world of Slurm! If you have any questions or issues, feel free to get in contact with the admins via Ivanti! We help novice and expert users alike to get settled.

If you are not familiar with the UNIX console, please do the [UNIX Tutorial for Beginners](./unix-101.md) first.

For this whole tutorial you will find code snippets, these are displayed as interactions on a console. Lines with a preceding $ are the commands entered, ones without, are the output of these commands.

```
$ <command-entered-by-user>
<command-output>
```

## Lesson 1: Scheduler
The Scheduler, is the program running on the cluster, that schedules your jobs to be run on the resources available within the cluster. It ensures fair usage, and should under no circumstances be bypassed. The HPC managed by the University of Glasgow use Slurm as their scheduler.

Look at what resources you have available to you on the cluster, using the Slurm `sinfo` command. (The output displayed below is shortened)

```
$ sinfo -o "%n %c %m %G" | column -t
HOSTNAMES  CPUS  MEMORY   GRES
node021     64    514048   (null)
node022     64    515072   (null)
node023     64    515072   (null)
...
```

The nodes are grouped into partitions, this is a way to define what type of machine you want to work with. They are sometimes also referred to as queues. You can list all available partitions also using the `sinfo` command:

```
$ sinfo -o "%P %D %N" | column -t
PARTITION  NODES  NODELIST
nodes*     10     node[01-10]
gpu        3      gpu[01-20]
```

## Lesson 2: Interactive Job
Interactive jobs are great to install software, prepare your environment or debug your script. It is also a good point to start to engage with HPC. But please, for any serious or larger work, use batch jobs. More on those in Lesson 3!

You can start an interactive job using the `srun` command. You can tell, you are on a different server by the prompt, which should now feature the name of a compute node:

```
[login1]$ srun --pty bash
[node01]$
```

Similar from how you switched from your PC via `ssh` to the login node, we now switched from the login node to the compute node using Slurm.

In this session, we can start doing computational work. As an example, we will run some python3 code.

1. Run python3
```
$ python3
```

2. Import python libraries
```
>>> import os
```

3. Get Slurm node name
```
>>> node = os.getenv("SLURMD_NODENAME")
```

4. Open a new text file
```
>>> myfile = open("demofile.txt", "w")
```

5. Write into the text file
```
>>> myfile.write("I am doing compute work on " + node)
```

6. Exit python3
```
>>> exit()
```

Look at the file you just created using `cat`. You can see it used the name of the node we are working on in the output.

```
$ cat demofile.txt
I am doing compute work on node01
```

This is our interactive job done, lets close our session with the exit command. This should bring us back to the login node, as indicated by the prompt again:

```
[node01]$ exit
exit
[login1]$
```

## Lesson 3: Batch Job
If you are thinking the previous lesson was quite tedious and not very convenient, you will like batch job submissions.

First, we have to save our python code into a file. For this create a file with the `.py` ending and add the lines we executed in python above in the interactive job. To make sure the output of our script is unique we will add the JobID as an identifier to the output file of the script.

You can create and edit files using either `vi` or `nano`, whatever is more comfortable to you. Nano is the easier of the two, so if you are unfamiliar, we recommend using it. To exit and save in Nano do `ctrl+X → Y → Enter`.

```
$ nano myPythonCode.py
```
```
import os
node = os.getenv("SLURMD_NODENAME")
jobid = os.getenv("SLURM_JOBID")
myfile = open("demofile-" + jobid + ".txt", "w")
myfile.write("I am doing compute work on " + node)
exit()
```

Now to schedule our job with Slurm , we need to create a job script. You can use a template from [Submission Script Templates](../references/submission-script-templates.md)

In the “My Code” section run the script you saved earlier by providing it as a parameter to the python3 executable:

```
…
############# MY CODE #############
python3 myPythonCode.py
```

Now you can submit your job using the `sbatch` utility and the path to the script. You will get a JobID in return, remember this to find your output later:

```
$ sbatch myPythonJob.sh
Submitted batch job <JobID>
```

After the job has finished, within your current working directory you should find an output file, which contains the `STDOUT` and an error file, which contains the `STDERR` of your job session. In addition, the file your python script created should also be there. Since your home storage is shared across all servers, you can see the output of your scripts in real time from the login node, even if the job ran on a compute node:

```
$ ls -l
myjob-<JobID>.out
myjob-<JobID>.err
demofile-<JobID>.txt
```

Check the output of these files. If all went as planned, the error file should be empty.

You can run this job as many times as you want by just using the `sbatch` command. Like this you have access to the power of the HPC compute nodes, without ever having to log into one yourself.

## Lesson 4: Monitoring
You can see all running jobs on the system using the `squeue` command. If you only want to see your own jobs, you can specify your username with the `-u` parameter. If you only want to see a specific job, you can use the `-j` parameter followed by your JobID.

```
$ squeue
$ squeue -u <GUID>
$ squeue -j <JobID>
```

The output is as follows:

- *JOBID*: Unique identifier of the job. Counts up from 1 being the first job ever queued.
- *PARTITION*: Scheduler partition the job is queued into.
- *NAME*: Name of the job as defined by `--job-name` in your submission or your script name.
- *USER*: User who submitted the job to the scheduler.
- *ST*: Status of the job: `R`=Running, `PD`=Pending (Queued).
- *TIME*: Time the job has been running for.
- *NODES*: Number of nodes.
- *NODELIST*: List of names of allocated nodes.

Slurm keeps a database with information of all jobs run using the system. To access this data, you can use the `sacct` command. Using the JobID you saved from your job, we can show a wide list of information for your job. Use the `-o` parameter followed by a list of Job Accounting Fields.

A list of all available Job Accounting Fields can be found [here](https://slurm.schedmd.com/sacct.html#SECTION_Job-Accounting-Fields)

Below is an example that gives you an overview of the requested resources for a job. You should see, these are the values you provided in the “SLURM SETTINGS” section of your submission script:

```
$ sacct -X -j <JobID> -o JobID,User,ReqCPUS,ReqMem,ReqNodes,TimeLimit
```

Now let’s get some more information on how and where our job ran. In this output we see how long the job ran, and how it completed. An `ExitCode` of anything other than `0` usually means there was an error:

```
$ sacct -X -j <JobID> -o JobID,NodeList,Start,End,Elapsed,State,ExitCode
```

Say we want to check if our job ran efficiently, we could use the `seff` command. It uses data from the Slurm accounting database, to create information on how efficiently your job ran. We can use this information to make our jobs more efficient:

```
$ seff <JobID>
```

These efficiency values are only accurate, once your job has finished running. Accurate job scripts help the queuing system efficiently allocate shared resources. And therefore, your jobs should run quicker.