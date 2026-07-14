# Open MPI

The Open MPI Project is an open source Message Passing Interface implementation that is developed and maintained by a consortium of academic, research, and industry partners. Open MPI is therefore able to combine the expertise, technologies, and resources from all across the High Performance Computing community in order to build the best MPI library available.

For usage information run the following command after loading the module:

```
mpirun -h
```

## Example

The example source code is written in C below and saved to a file called hello_mpi.c:

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

Compile the code above into an executable called hello_mpi:

```
mpicc hello_mpi.c -o hello_mpi
```

You can now write a submission script to run your MPI program hello_mpi over multiple nodes. The example below runs over **2** nodes with **4** tasks each:

```
#!/bin/bash

############# SLURM SETTINGS #############
#SBATCH --account=none  # account name (mandatory), if the job runs under a project then it'll be the project name, if not then it should =none
#SBATCH --job-name=myjob        # some descriptive job name of your choice
#SBATCH --time=0-01:00:00       # time limit for the whole run, in the form of d-hh:mm:ss, also accepts mm, mm:ss, hh:mm:ss, d-hh, d-hh:mm
#SBATCH --mem=5G                # memory required per node, in the form of [num][M|G|T]
#SBATCH --nodes=2               # number of nodes to allocate, default is 1
#SBATCH --ntasks-per-node=4     # number of tasks to be launched on each allocated node

############# LOADING MODULES (optional) #############
module load mpi/openmpi


############# MY CODE #############
mpirun hello_mpi
```

Your slurm-<jobID>.out file will contain something like this:

```
Hello from process 0 on machine node01.pri.mars.alces.network, of 8 processes
Hello from process 1 on machine node01.pri.mars.alces.network, of 8 processes
Hello from process 2 on machine node01.pri.mars.alces.network, of 8 processes
Hello from process 3 on machine node01.pri.mars.alces.network, of 8 processes
Hello from process 6 on machine node02.pri.mars.alces.network, of 8 processes
Hello from process 7 on machine node02.pri.mars.alces.network, of 8 processes
Hello from process 4 on machine node02.pri.mars.alces.network, of 8 processes
Hello from process 5 on machine node02.pri.mars.alces.network, of 8 processes
```

## External Resources

[OpenMPI Website](https://www.open-mpi.org/)
