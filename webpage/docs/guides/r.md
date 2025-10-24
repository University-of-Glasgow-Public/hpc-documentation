# R
This guide will help you familiarise yourself with R on HPC.

For more advanced information, please consult the official documentation of the application: 

- [R Documentation](https://cran.r-project.org/doc/manuals/R-intro.pdf)

## Run code autonomous
The easiest way to run your R code on HPC is to save your code in a file and run it with the `Rscript` utility.

Here a very simple example R script file, it's named `myRCode.R`:

```
print("Hello World!")
```

Now if you want to execute this within your Slurm job submission, just use one of our templates [here](../references/submission-script-templates.md) and edit it as described below. The example submission script is named `mySlurmJob.sh`.

In our submission script, we will now run the code autonomously via `Rscript` by supplying it as a simple parameter:

```
...
############# MY CODE #############
Rscript myRCode.R
```

Now we can just submit our submission script with the Slurm `sbatch` utility:

```
sbatch mySlurmJob.sh
```

You will find the generated console output in the file you specified in the `--output` parameter within your Slurm submission.

## Install packages in custom space
Per default, your downloaded R packages are saved within your `$HOME` directory in `.R/<version>`. If you are running out of space, you can move the installation path into a different directory.

!!! info

    The paths and names used here are examples. Please adjust them to what fits for the environment you are working with.

Create a software directory:

```
mkdir -p /mnt/myproject/software/R
```

Install packages into the new directory within `R`:

```
install.packages("<package-name>", lib="/mnt/myproject/software/R")
```

Add the new directory to `$R_LIBS_USER` variable. With this set, R will expand its software search to the directory specified:

```
export R_LIBS_USER="/mnt/myproject/software/R:$R_LIBS_USER"
```

`$R_LIBS_USER` has to be set like this whenever you want to use the software in your custom directory. You can either do this at the beginning of your job, in your submission script or add it to your `~/.bashrc` profile script, to make it available at every login.