# Python3

Python is a remarkably powerful dynamic programming language that is used in a wide variety of application domains. Python is often compared to Tcl, Perl, Ruby, Scheme or Java.

For usage information run the following command after loading the module:

```
python3 -h
```

## Run python code in batch submission

In a batch submission, you will not be able to access the console, so you cannot run your commands from the console as you are used to. The easiest way to run your python code on the MARS cluster is to save your code in a file.

Here is our example python script file, we named it myPythonCode.py:

```
print("Hello World!")
```

Now if you want to execute this within your Slurm job submission, just use one of our [templates](https://hpc.gla.ac.uk/references/submission-script-templates/) and edit it as described below. We named our example submission script mySlurmJob.sh.

As you can see below we load the python3 module and in the code section run our previously saved script with the `python3` utility:

```
...
############# LOADING MODULES (optional) #############
module load apps/python3


############# MY CODE #############
python3 myPythonCode.py
```

Now we can just submit our submission script with the Slurm `sbatch` utility:

```
sbatch mySlurmJob.sh
```

You will find the generated console output in the file you specified in the --output parameter within your Slurm submission.

## Install software in project space

If you are running out of space in your home for your python environments, you can move the installation path into your project storage, so you don’t exceed your quota.


1. Load python module (if available)
2. Create a software directory in your shared project space:

```
mkdir -p /mnt/data/projectXXXX/software/python
```

3. Install packages into shared directory:

```
pip3 install --target /mnt/data/projectXXXX/software/python <package-name>
```

4. Add shared directory to $PYTHONPATH:

```
export PYTHONPATH="$PYTHONPATH:/mnt/data/projectXXXX/software/python"
```

This last step has to be done, whenever you want to use the software. You can either do it at the beginning of your job, or add it to your ~/.bashrc profile script.


## External Resources

[Python Documentation](https://www.python.org/doc/)
