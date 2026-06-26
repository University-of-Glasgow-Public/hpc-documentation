# HPC Etiquette

An HPC system is a shared resource for researchers and students to work with. To ensure all users have a good experience, there are some expected behaviours.

If you see users not following these behaviours on the cluster, please [contact us](https://glasgow.saasiteu.com/Modules/SelfService/#serviceCatalog/request/AFB25E75ED5E40E4BDF84FDEE6108945). We do not tolerate users harassing each other over cluster usage!

## Don’t use the login node to run computational work

The login node is the central point of access to the cluster for all users using MARS. Therefore, if something goes wrong with it, all users are impacted. Actions you would usually do from the login node involve the following:

- Moving data from, to and within the system.
- Perform minor edits on scripts and code.
- Slurm Job management

If you are unsure if your action is impacting the login node, you can run the command top. This will show you the current CPU and memory usage of the server. If you are topping the charts with more than 100% usage, you should consider moving your action into a Slurm allocation.

To specifically only see your processes on the system you can use the following command. (type q to exit the program)

```
top -u $(whoami)
```

Jobs that impact the login node are regularly deleted by the admins. You are usually informed via email, if this is done to one of your processes.


## Clean up your storage spaces

Please delete unused and old data off the system after you are done using it, to make room for other users and projects. While we are working with quotas, to keep usage in check, only using what you need, reduces storage waste.

To keep track of your quota, you can use the quota command, that will give you an overview of all quotas that apply to you. The -s parameter displays all the information in human readable units.

```
$ quota -s
Disk quotas for user <GUID> (uid 999999999):
     Filesystem   space   quota   limit   grace   files   quota   limit   grace
storage:/export/users
                 31202M  40960M  51200M            157k    200k    250k
```
If you want an overview of storage usage, you can use the du command. It allows you to list directories and their sizes. This can be helpful, if you are using a lot of space but are not sure where the bulk of the data is. you can use the -h parameter to display the information in human readable units and the -d parameter to limit the depth level of subdirectories, that are scanned.

```
$ du -h -d 2 /users/<GUID>/myData
50M     /users/<GUID>/myData/code/script1.sh
50M     /users/<GUID>/myData/code
100M    /users/<GUID>/myData/example/data1.csv
100M    /users/<GUID>/myData/example/data2.csv
200M    /users/<GUID>/myData/example
250M    /users/<GUID>/myData
```

## Use resources efficiently

Don’t waste the resources, this is easily said and I bet you’ve heard it a bunch. Here we offer some tips on how to optimise your jobs.

But first, why do we care about resource waste? Here are a few reasons:

- All resources that are requested and not used, stay blocked for people who are waiting in the queue for their jobs to start.
- The HPC still uses power and cooling, even when the resources are not used, so having idle resources is bad for the environment.
- If you ask for a bigger job, than you need, it will likely take longer to start, as a big job is harder for the scheduler to find space for.

### Efficiency

For CPU and Memory efficiency, you can easily use the seff command. If you provide it with the Id of the job you want to analyse, it will show you how efficient the requested resources were used. the numbers can only be fully trusted after the job has finished running.

```
$ seff <JobID>
Job ID: <JobID>
Cluster: mars.alces.network
User/Group: <GUID>/clusterusers
State: COMPLETED (exit code 0)
Nodes: 1
Cores per node: 2
CPU Utilized: 00:01:00
CPU Efficiency: 49.18% of 00:02:02 core-walltime
Job Wall-clock time: 00:01:01
Memory Utilized: 5.97 GB
Memory Efficiency: 18.64% of 32.00 GB
```

You can see in yellow, only 50% of the requested CPU resources were used, this means in this case I could go down from 2 CPUs to 1. For CPU efficiency, we want to get as close to 100% as possible.

In blue, the memory usage was also overestimated and could go down a bit too. For memory, it is fine to keep a bit of a buffer, as you don’t want to risk getting an Out Of Memory (OOM) error. I would aim to stay above 70% efficiency.

To see if your time estimation was right, you can compare the requested with the actual time with the sacct command and adjust accordingly. It is fine to have a time buffer, in case there are minor delays in the command. In this example below, it would make sense to adjust the time limit to 2 hours.

```
$ sacct -X -o Timelimit,Elapsed -j <JobID>
 Timelimit    Elapsed
---------- ----------
  04:00:00   01:48:33
```

There is no easy way to get GPU efficiency, but generally speaking if you don’t need GPU, don’t request it! The next section gives a good example on how to achieve maximum GPU efficiency.


## Split up jobs

A job can have multiple steps to it, they don’t always have to run on the same node. Let’s take an example, where I have a script, that processes some data I intend to use for a model using GPUs. If the processing part only uses CPU and takes 3h it would be reasonable to do that on a CPU-node, instead of blocking a GPU node for 3h without using the main resource it provides.

An easy way to achieve this as efficient as possible is with the use of Slurm job-dependency. I have a submission script called myJob_preprocessing.sh:

```
#!/bin/bash

############# SLURM SETTINGS #############
#SBATCH --account=none
#SBATCH --partition=nodes
#SBATCH --time=0-03:00:00
#SBATCH --mem=32G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1     
#SBATCH --cpus-per-task=1

############# LOADING MODULES (optional) #############
#module load apps/xxx

############# MY CODE #############
echo "This is my pre-processing work for myJob"
# INSERT CODE HERE
```

and one called myJob_trainmodel.sh:

```
#!/bin/bash

############# SLURM SETTINGS #############
#SBATCH --account=none
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=0-01:00:00

############# LOADING MODULES (optional) #############
#module load apps/xxx

############# MY CODE #############
echo "Now training the model for myJob"
# INSERT CODE HERE
```

If I submit my job myJob_preprocessing.sh, I can use the jobID I get in return, to schedule my training to start once my preparations have successfully completed, without me having to log into the cluster again:

```
$ sbatch myJob_preprocessing.sh
Submitted batch job 123456
$ sbatch --dependency afterok:123456 myJob_trainmodel.sh
Submitted batch job 123457
$ squeue -u <GUID>
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
            123457     gpu       wrap   js628s PD       0:00      1 (Dependency)
            123456     nodes     wrap   js628s  R       1:12      1 node03
```

As you can see my first submitted job myJob_preprocessing.sh is now running (blue), where myJob_trainmodel.sh is pending due to a dependency (yellow).

There are different type of dependencies and you can also have multiple conditions. More information is in the official [Slurm manual](https://slurm.schedmd.com/sbatch.html#OPT_dependency).


## Don’t unnecessarily congest the queues

Our goal is to have the cluster be in high usage for as much time as possible. However, if you are running a bunch of tests you could prevent important jobs from starting. It is always a good idea to get an overview of the usage of the whole cluster, before queueing up test or training jobs. A good overview can be achieved with this command:

```
sinfo show node -O nodehost,cpusstate,gres,gresused,nodeai
```

This command gives you the following information:

- Hostname: Hostname of the node.
- CPUS(A/I/O/T): How many of the CPUS are **A**llocated / **I**dle / **O**ther / **T**otal.
- GRES: If and what GPU does the node have.
- GRES_USED: Amount of GPUs in use.
- NODES(A/I): When the node has any jobs running it is **A**llocated, otherwise **I**dle.


MARS is a batch processing system and there’s no guarantee when any job is submitted, that it will run immediately. When using the system, you have to be aware, that it can be normal to wait hours or days for your jobs to start. Jobs are queued and managed by the scheduler and the more accurate the information about jobs the better Slurm can do its work.



