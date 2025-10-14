# Slurm Parameters

You can use a whole lot of parameters to specify your resource request to the scheduler. We will cover the most common parameters here, but if you want a full overview of all available ones and extra information, you can run `man sbatch` or `man srun` when logged into the system. 

|Parameter|Example|Description|
|---|---|---|
|`-J, --job-name=<jobname>`|`--job-name="Test-Job-1"`|Specify a name for the job. The specified name will appear along with the job id number when querying running jobs on the system. The default is the supplied executable program's name.|
|`-p, --partition=<partition_names>`|`--partition=gpu`|Request a specific partition for the resource allocation. If the job can use more than one partition, specify their names in a comma separate list. If the parameter is not set it defaults to configured "default partition".|
|`-o, --output=<path>`|`--output=/path/to/file/%x-%j.out`|Write all output of `STDOUT` to file. You can use dynamic parameters for filenames, like `%x` for job name and `%j` for jobID.|
|`-e, --error=<path>`|`--error=/path/to/file/%x-%j.err`|Write all output of `STDERR` to file. You can use dynamic parameters for filenames, like `%x` for job name and `%j` for jobID. See "filename pattern" in manual for more information.|
|`-D, --chdir=<directory>`|`--chdir=/path/to/workdir`|Set the working directory of the batch script to the specified relative or full path before it is executed|
|`-t, --time=<dd-hh-mm-ss>`|`--time 00-01:00:00`|Set a limit on the total run time of the job allocation. When the time limit is reached, each task in each job step is sent a kill signal.|
|`-b, --begin=<time>`|`--begin=2025-01-01T12:00:00`|If you want a job to run at a specific time, you can set a start time. The start time is not guaranteed.|
|`-d, --dependency=<condition>:<jobID>`|`--dependency=afterok:9999`|Set a dependency for your job to run. In the example, the job will run if job 9999 finished successfully. Read the manual for more configuration opetions.|
|`-N, --nodes=<num>`|`--nodes=2`|Number of servers you want your job to run on. Use only if your code supports parallel processing.|
|`-c, --cpus-per-task=<num>`|`--cpus-per-task=8`|Request the number of CPUs to be allocated per process. This may be useful if the job is multithreaded and requires more than one CPU per task for optimal performance.|
|`--gres=gpu:<type>:<num>`|`--gres=gpu:gtx1080:1`|Specify the type and number of GPUs for your allocation.|
|`--mem=<num><unit>`|`--mem=16G`|Specify the real memory required per node. Default units are megabytes. Different units can be specified using the suffix [K|M|G].|
|`--mail-user=<email>`|`--mail-user="example@example.co.uk"`|Email address to send notifications to. Only University of Glasgow managed emails are accepted.|
|`--mail-type=<type>`|`--mail-type="BEGIN,END,FAIL"`|Comma separated list of event types `--mail-user` gets notified for.  Valid type values are NONE, BEGIN, END, FAIL, RE‐QUEUE, ALL|