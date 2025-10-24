# Parallel
If you want to run code in parallel, HPC is perfect, as you have a lot of resource available, to efficiently scale your work!

!!! tip "Important"

    The software or code you are using has to be capable to run in parallel. Not every software can do that and code has to be specifically written for it!

## Automatic scaling from Slurm allocation
Some programs, will try to use all CPU a node (server) has available, when trying to run in parallel, but depending on your submission, you won't always have all CPUs per server available.

If you want to easily adjust your parallel program, to spawn processes based on your submission, you can do that using Slurm environment variables, set in every submission.

|Variable|Explanation|
|---|---|
|`SLURM_NNODES`|Amount of nodes (servers) your job is running on.|
|`SLURM_CPUS_ON_NODE`|Amount of CPU available per node (server).|
|`SLURM_NTASKS`|Amount of tasks available per server (server).|

Here an example with a simple parallel processing python script. The script creates eight processes that each sleep for four seconds:

```
import multiprocessing
import time
import os

slurm_threads = os.environ['SLURM_CPUS_ON_NODE']


data = ('A','B','C','D','E','F','G','H')

def sleeper(id):
    print("Processs %s started" % id)
    time.sleep(4)
    print("Process %s finished" % id)

def mp_handler():
    pool = multiprocessing.Pool(int(slurm_threads))
    pool.map(sleeper, data)

if __name__ == '__main__':
    mp_handler()
```

By saving the value of the environment variable `SLURM_CPUS_ON_NODE` into the python variable `slurm_threads`, we won't need to touch our python script anymore to upscale our work, but rather just adjust our submission. 

This run will take 32 seconds:

```
srun --cpus-per-task=1 --pty python3 ~/parallel.py
```

This run will take 8 seconds:

```
srun --cpus-per-task=4 --pty python3 ~/parallel.py
```

This run will take 4 seconds:

```
srun --cpus-per-task=8 --pty python3 ~/parallel.py
```


## OpenMPI Example
The example source code is written in C below and saved to a file called `hello_mpi.c`:

```
#include <stdio.h>
#include <mpi.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
        int threadid,totalthreads;
        char hostname[80];

        // Start MPI processes on each node
        MPI_Init(&argc,&argv);

        // Get thread ID from the MPI master process
        MPI_Comm_rank(MPI_COMM_WORLD, &threadid);

        // Get the number of processes launched by MPI
        MPI_Comm_size(MPI_COMM_WORLD, &totalthreads);

        // Get the hostname from the node running the task
        gethostname(hostname,80);

        // Print a statement to standard output
        printf("Hello from process %i on machine %s, of %i processes\n", threadid, hostname, totalthreads);


        MPI_Finalize();

        return 0;
}
```

Compile the code above into an executable called `hello_mpi`:

```
mpicc hello_mpi.c -o hello_mpi
```

You can now write a submission script to run your MPI program `hello_mpi` over multiple nodes. First you can copy a template from [here](../references/submission-script-templates.md) and adjust as described below.

Adjust the `--nodes` to `2` to run the job across two servers and the `--ntasks-per-node` to `4` to spawn four processes per node, so eight in total. MPI will automatically spawn as many processes, as tasks are available in the allocation.

```
...
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
...
```

Run the program compiled with the `mpirun` utility:
```
...
############# MY CODE #############
mpirun hello_mpi
```

Your output file will contain something like this:

```
Hello from process 0 on machine node001, of 8 processes
Hello from process 1 on machine node001, of 8 processes
Hello from process 2 on machine node001, of 8 processes
Hello from process 3 on machine node001, of 8 processes
Hello from process 6 on machine node002, of 8 processes
Hello from process 7 on machine node002, of 8 processes
Hello from process 4 on machine node002, of 8 processes
Hello from process 5 on machine node002, of 8 processes
```