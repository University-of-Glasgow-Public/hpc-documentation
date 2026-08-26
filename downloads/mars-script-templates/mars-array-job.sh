#!/bin/bash -l

############# SLURM SETTINGS #############
#SBATCH --account=none          # account name (mandatory), if the job runs under a project then it'll be the project name, if not then it should =none
#SBATCH --job-name=myjob        # some descriptive job name of your choice
#SBATCH --time=0-01:00:00       # time limit for the whole run, in the form of d-hh:mm:ss, also accepts mm, mm:ss, hh:mm:ss, d-hh, d-hh:mm
#SBATCH --mem=1G                # memory required per node, in the form of [num][M|G|T]
#SBATCH --ntasks=1              # number of Slurm tasks to be launched, increase for multi-process runs ex. MPI
#SBATCH --cpus-per-task=1       # number of processor cores to be assigned for each task, default is 1, increase for multi-threaded runs
#SBATCH --ntasks-per-node=1     # number of tasks to be launched on each allocated node
#SBATCH --array=1-10            # create job array of 10 tasks numbered 1 through 10

############# LOADING MODULES (optional) #############
#module load apps/xxx
#module load libs/xxx

############# MY CODE #############
echo "Hello from $SLURM_JOB_NODELIST"
echo "This is task $SLURM_ARRAY_TASK_ID out of $SLURM_ARRAY_TASK_COUNT"
echo "Jobs are between $SLURM_ARRAY_TASK_MIN and $SLURM_ARRAY_TASK_MAX"
