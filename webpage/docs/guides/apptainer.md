# Apptainer
This guide will help you familiarise yourself with Apptainer (formerly known as Singularity) and some of its utilities. This can hopefully kickstart you to the usage of images (containers) for easily reproducible work.

For more advanced information, please consult the official documentation of the application: 

- [Apptainer Documentation](https://apptainer.org/documentation/)


## Run images
You can run images you made yourself, or run images provided by colleagues or software developers. Please make sure the images you are using are from trusted sources!

You can run a container using the `apptainer run` command. The `<image>` part can either be the path to a `.sif` file you have saved locally or it can be a link to an image stored in a repository online.

```
apptainer run <options> <image>
```

As an example we will use the image hosted on the GitHub container registry by the Apptainer developers: `docker://ghcr.io/apptainer/lolcow`. All you need to do is provide the link and Apptainer will run the %runscript code of the image. In our example this will be a cow, telling you the current time and date:

```
$ apptainer run docker://ghcr.io/apptainer/lolcow
 ________________________
< Tue Feb 11 14:02:52 GMT 2025 >
 ------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

If you want to run a command outside of the workflow defined in `%runscript`, you can use the `apptainer` exec command:

```
apptainer exec <options> <image> <command>
```

This will not run the code within `%runscript` and instead run the code you provide on the command line:

```
$ apptainer exec docker://ghcr.io/apptainer/lolcow echo "I won't do what I was made for!"
I won't do what I was made for!
$
```

If you want to test and debug, you can run an interactive shell from within a container, using the `apptainer shell` command. 

```
apptainer shell <options> <image>
```

To leave just use exit:

```
$ apptainer shell docker://ghcr.io/apptainer/lolcow
Apptainer> echo $SHELL
/bin/bash
Apptainer> echo "Hello, world!"
Hello, world!
Apptainer> exit
$
```

All three of these commands have similar parameters. If you want to see all available options for the command run `man apptainer <run/exec/shell>` in your console. Below we explain some options we see as important:

|Option|Template|Example|Description|
|------|--------|-------|-----------|
|`-B, --bind=[]`|`-B <src>:<dest>`|`-B ~/mydata:/datadir`|Binds the local directory `~/mydata` to `/datadir` within the container.|
|`--nv`|`--nv`|`--nv`|Enables Nvidia support. Use this option when working on GPU-servers to ensure you have the GPU available within your container.|

## Create images 
You won't always be able to create images on the HPC, we recommend you install apptainer on your local device. Information on how to install can be found [here](https://apptainer.org/docs/admin/main/installation.html#).

Once you have an installation of apptainer working on your device, you can build images to then use on a HPC or any other device. For our simple example, we’ll build an image to install and run the test package `hello` from the Ubuntu upstream repository.

All we need is to create a [Definition File](https://apptainer.org/docs/user/main/definition_files.html) outlining which OS we want to make use (`#Header`), install the packages we want (`%post`) and the action to run (`%runscript`). We will call this file `hello.def`:

```
#Header
BootStrap: docker
From: ubuntu:latest

%post
    apt-get update
    apt-get -y install hello
    apt-get clean

%runscript
    hello
```

We can then create a image file (`.sif`) from that definition file. The `.sif` file will be the image, from which our container will be started. We can move and run it on other systems like an HPC. We will call our image `hello.sif`:

```
apptainer build hello.sif hello.def
```

If we copy `hello.sif` over to an HPC for example, we can now run it using apptainer:

```
$ hello
-bash: hello: command not found
$ apptainer run hello.sif
Hello, world!
```