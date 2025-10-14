# PBS to Slurm Cheat Sheet
## User Commands
|Purpose|PBS|Slurm|
|---|---|---|
|Submit a job via script|`qsub myScript.sh`|`sbatch myScript.sh`|
|Cancel a job|`qdel <JobID>`|`scancel <JobID>`|
|List all running jobs|`qstat`|`squeue`|
|List all your running jobs|`qstat -u <GUID>`|`squeue -u <GUID>`|
|Advanced job information|`qstat -f <JobID>`|`sacct -j <JobID>`|

## Environment Variables
|Purpose|PBS|Slurm|
|---|---|---|
|Job ID|`$PBS_JOBID`|`$SLURM_JOBID`|
|Submit directory|`$PBS_O_WORKDIR`|`$SLURM_SUBMIT_DIR`|
|Allocated node list|`$PBS_NODEFILE`|`$SLURM_JOB_NODELIST`|
|Current node name|`-`|`$SLURMD_NODENAME`|
|Array job index|`$PBS_ARRAY_INDEX`|`$SLURM_ARRAY_TASK_ID`|
|Number of CPUs|`$PBS_NUM_PPN * $PBS_NUM_NODES`|`$SLURM_NPROCS`|


## Job Parameters
|Purpose|PBS|Slurm|
|---|---|---|
|Job name|`#PBS -N myJob`|`#SBATCH --job-name=myJob`|
|Wallclock limit|`#PBS -l walltime=hh:mm:ss`|`#SBATCH --time=dd-hh:mm:ss`|
|CPU Time|`#PBS -l cput=hh:mm:ss`|`-`|
|Number of nodes and CPUs|`#PBS -l nodes=2:ppn=8`|`#SBATCH --nodes=2 --ntasks-per-node=1 --cpus-per-task=8`|
|Memory|`-`|`#SBATCH --mem=8G`|
|GPU|`-`|`#SBATCH --gres=gpu:1`|
|Array|`#PBS -t 1-100`|`#SBATCH --array=1-100`|
|Select queue / partition|`#PBS -q <QueueName>`|`#SBATCH --partition=<PartitionName>`|
|Working directory|`-`|`#SBATCH --workdir=/path/to/file`|
|STDOUT file|`#PBS -o /path/to/file`|`#SBATCH --output=/path/to/file`|
|STDERR file|`#PBS -e /path/to/file`|`#SBATCH --error=/path/to/file`|
|Email notifications|`#PBS -m a\|b\|e`|`#SBATCH --mail-type=NONE\|BEGIN\|END\|FAIL\|ALL`|
|Email recipient|`#PBS -M <Email>`|`#SBATCH --mail-user=<Email>`|
