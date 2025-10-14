# Jupyter
This guide will help you how to use a jupyter server through HPC.

For more advanced information, please consult the official documentation of the application: 

- [Jupyter Documentation](https://docs.jupyter.org/en/latest/)

## Install Jupyter
Jupyter can easily be installed by yourself using `conda`. The manual for `conda` can be found [here](conda.md). However you are free to use any other installation method you prefer for this. Below is a step by step manual on how to create a new environment with jupyter installed.

First we create a new environment:

```
conda create -n jupyter-env
```

Once that is through, we can activate our new environment:

```
conda activate jupyter-env
```

Now we can install jupyter and any other packages, we may need into this environment:

```
conda install jupyter
```

## Use Jupyter on HPC
Using Jupyter server is a quite inconvenient way to schedule your work, and we would recommend where possible to run your code directly without the interactive use of the server.

First, you should establish where your jupyter working directory is. This is where all your scripts you intend to run are. In the case, you are starting from scratch, we will create one:

```
mkdir ~/my-jupyter-work-dir
```

To standardise access to the Jupyter server without a randomly created access token, we’ll set a password. This removes the need to remember the generated token later on. To do this use the command below and enter a password (remember that on UNIX, you won’t see password inputs).

```
jupyter server password
```

Please be sure to save your password in a password manager, so you don’t lose it. To change your password just run the command again. This will overwrite the old one. The password is saved as a hash into `$HOME/.jupyter/jupyter_server_config.json`. If you want to remove the password configuration, you can delete it from the file.

When starting the jupyter server, we will be using three parameters. They ara the following:

|Parameter|Value|Note|
|---|---|---|
|`--no-browser`||This starts a jupyter server, without trying to open a browser.|
|`--ip`|`0.0.0.0`|This makes, so the jupyter server listens from external sources, in our case this is the login-node.|
|`--port`|<5 digit number>|Port under which your server is available. This should be unique on the cluster, so choose 5 digits at random, but not higher than 65535.|

The jupyter command would look something like this. As mentioned above, please ensure to customise your ==port==. If you get an error, try changing the port and start again.

```
jupyter server --no-browser --ip=0.0.0.0 --port=12365
```

We will now package this in an easily reusable batch submission script. For this choose a template of your chose from [here](../references/submission-script-templates.md), and add the following lines of code to the bottom:

```
#Load any modules or activate any environment you need to run Jupyter
conda activate jupyter-env

#Move to your jupyter working directory
cd ~/my-jupyter-work-dir

#Start your Jupyter server
jupyter server --no-browser --ip=0.0.0.0 --port=12365
```

We can now submit this via the `sbatch` utility:

```
sbatch myJupyterServerJob.sh
```

We will now need to figure our the ==nodeName==, where our Jupyter server is running from. You can do that using `squeue` and either using the JobID or your GUID. The `nodeName` is the value below `NODELIST`:

!!! info

    Ensure that `ST` (status) is `R` (running). If the cluster is in high demand, you might not get your allocation right away!

```
$ squeue -j <JobID>
JOBID    PARTITION    NAME      USER    ST   TIME  NODES  NODELIST(REASON)
<JobID>  nodes        Jupyter-  <GUID>  R    0:14      1  node05
$ squeue -u <GUID>
JOBID    PARTITION    NAME      USER    ST   TIME  NODES  NODELIST(REASON)
<JobID>  nodes        Jupyter-  <GUID>  R    0:44      1  node05
```

We will now setup a SSH port forwarding to the HPC login node, so we can seamlessly use our local browser, to work with the server. To do this, open a command line from your local device, and enter the command below, replacing `<port>`, `<nodeName>` and `<GUID>` with the values we saved.

```
ssh -L <port>:<nodeName>:<port> <GUID>@mars-login.ice.gla.ac.uk
```

You should be asked for your password and logged into the HPC, however you can ignore this console from now on and minimise it.

Now you can start a browser of your choice on your local device and navigate to this link and customise `<port>` it with your port: `http://localhost:<port>/tree?`

To log into the server, you can use the password you set earlier.

After you are done with your work, you can close the browser, and exit the session in your minimised console, you used for the SSH port forwarding. If you finish your work, before your jupyter server job is done running, please kill it by using `scancel`, followed by the JobID:

```
scancel <JobID>
```

!!! warning

    Jupyter servers, that are found to be running for long periods of time on idle nodes might be killed by HPC administrators. Leaving an unused Jupyter server running is wasting resources other users may be waiting to use on the cluster!