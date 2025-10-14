# Conda
This guide will give you some helpful information on how to use `conda` to manage different software environments on HPC. The HPC admin team recommends to use [Miniforge](https://conda-forge.org/download/) as your preferred conda installation.

For more advanced information, please consult the official documentation of the application:
 
- [Conda Documentation](https://docs.conda.io/en/latest/)

## Create environment
Create your environment and give it a fitting name, for example the project you are working on or the software you are intending to use with it.

```
conda create -n demo-env 
```

Next activate your environment. This should add a prefix to your prompt with your environment name chosen above.

```
conda activate demo-env 
```

Now you can install software to be available within your environment. The syntax is `<software-name>=<software-version>`. If you don’t provide a version, the latest will be pulled.

```
conda install python=3.9 
```

All changes you make while in the environment will be saved to it. So, if you deactivate, they will no longer be available. In turn, they will be available the same you left it, when you reactivate.

## List and export environment
To get a list of all available environments use the command below. In the list you can also find where the environment is stored. This means all packages and libraries are within that sub-path.

```
conda env list
```

To get a list of all installed packages within an environment use this command

```
conda list -n demo-env
```

You can also create an export for your environment:

```
conda env export > demo-env.yml
```

You can now move this `.yml` file onto another system or share it with a colleague, where they can rebuild your environment using the below command:

```
conda env create -f demo-env.yml
```

## Delete environment
Conda environments can grow large and its important to keep your workspace clean. Therefore, make sure to delete old environments you don’t use anymore.

```
conda env remove -n demo-env
```

## Set up diffrent environment location
!!! info

    The paths and names used here are examples. Please adjust them to what fits for the environment you are working in

It could be, that for quota reasons, or to be able to share environments with colleagues, you want to have environments in a different location, than the default `~/.conda/envs`.

For this create a directory in a different location, for your environments to sit in:

```
mkdir /mnt/myproject/software/conda-envs
```

You can now add this directory to your config, so `conda` reads it as a new location to fetch environments from:

```
conda config --add envs_dirs /mnt/myproject/software/conda-envs
```

To verify your configuration is correct run:

```
conda config --show
```

!!! note

    The directory shown at the top of the list is the default. The directory last added will be the new default. If you wanted to change that, adjust the order in the file `~/.condarc`.


With this config you might get very long shell prompts showing the whole path to the environment. To avoid that run:

```
conda config --set env_prompt '({name})'
```

