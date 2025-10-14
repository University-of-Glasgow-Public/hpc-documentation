#!/bin/bash -l

############# SLURM SETTINGS #############
#SBATCH --job-name=myjob        # some descriptive job name of your choice
#SBATCH --partition=gpu         # which partition to use, default "cpu"
#SBATCH --time=0-01:00:00       # time limit for the whole run, in the form of d-hh:mm:ss
#SBATCH --mem=1G                # memory required per node, in the form of [num][M|G|T]
#SBATCH --nodes=1               # number of nodes to allocate, default is 1
#SBATCH --ntasks=1              # number of Slurm tasks to be launched, increase for multi-process runs ex. MPI
#SBATCH --cpus-per-task=1       # number of processor cores to be assigned for each task, default is 1, increase for multi-threaded runs
#SBATCH --ntasks-per-node=1     # number of tasks to be launched on each allocated node
#SBATCH --gres=gpu:gtx1080:1    # type and number of GPU, in the format gpu:[type]:[num]

############# SOFTWARE SETUP #############
#module load xxx
#export PATH="$PATH:/mnt/home/guid/software/xxx/bin"

############# MY CODE #############
echo "Hello from $SLURM_JOB_NODELIST"
nvidia-smi