# Cluster Local Scratch Use for Jobs

Local scratch, as the name implies, is local to each node. This means the local scratch on headnode01 is not the same as node001. Since the storage is server local, you get the best speed possible for I/O operations. Shared scratch is a space on an NFS server, that is shared across the cluster. This makes it easy to use, with the downside of network latency for I/O operations. If your job is not very I/O heavy, then there is no real need to use the local scratch. But feel free to do some testing, to see what fits best for your work!

 
The idea for the local scratch is that you move your data there in the beginning of your job:

1.	You have your data in your home, for example ~/myData. 

2.	At the beginning of your job, you can move the data into the local scratch.

3.	Then you can run your I/O intensive work and write all the outputs into your localscratch to a directory, for example ~/localscratc/myResults.

4.	When your work is done, you can move your results directory back to your normal home area and clean up your localscratch.

 
 
This could be an example job submission script:

```
#!/bin/bash
 
############# SLURM PARAMETERS #############
#SBATCH --job-name=”Test-Job-1”
#SBATCH --partition=cpu
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time 00-05:00:00
 
############# LOADING MODULES #############
module load python
 
############# MY CODE #############
mkdir ~/localscratch/jobdir-$SLURM_JOBID
cp -r ~/myDataDir ~/localscratch/jobdir-$SLURM_JOBID/
python3 ~/localscratch/jobdir-$SLURM_JOBID/myDataDir/myCode.py
cp ~/localscratch/jobdir-$SLURM_JOBID/myDataDir/results.txt ~/myResultsDir/results-$SLURM_JOBID.txt
rm -rf ~/localscratch/jobdir-$SLURM_JOBID
 
```
