# Modules
This guide will give you some helpful information on how to use Environment Modules to manage different software installations on HPC. This is the software used, to provide the system modules managed by the admin team. You can create your own modules for personal or shared installations.

For more advanced information, please consult the official documentation of the application:
 
- [Environment Modules Website](https://envmodules.io/)
- [Environment Modules Documentation](https://modules.readthedocs.io/en/latest/)

## What are modules?
Modules are TCL scripts, that prepare your Linux environment for the usage of a software installed on a system. Typical task include:

- Add any executables to your environment. 
- Add any runtime libraries to your environment.
- Set any required environment variables.
- Ensure dependencies are present.

With modules you can easily have multiple installations of the same software available to use. This eases the use of software on shared systems like an HPC.

## Using modules

This section will give you a better overview of how to use already established modules on a cluster. The later section is more aimed at users who are interested in setting up own modules.

### Search modules
You can show all available modules by using the command `module available`. This will give you a list of all modules available to you. Where there are multiple sources for modulefiles (defined via the `$MODULEPATH` variable), they will be grouped by these sources. The output is also alphabetically sorted, this means if you have multiple versions of one software within a source, they will appear together. 

```
$ module available
----- /mnt/software/modules -----
cuda/13.1.0/gcc11.5.0   paraview/5.12.0/gcc13.2.0_openmpi5.0.2_python3.11.8     python/3.11.8/gcc13.2.0
```

You can filter through the available modules with the command `module search` followed by a search term. If you use the software name as the search term you will get a list of all available versions for that software. The module creators can give some additional information for a module, this text will also be considered for searches.

```
$ module search gcc
----- /mnt/software/modules -----
    gcc/10.5.0: loads GCC version 10.5.0
    gcc/13.2.0: loads GCC version 13.2.0
```

### Load modules
You can load modules using the `module load` command, followed by the module name. It is recommended to always specify the full module name. 

```
$ module load gcc/10.5.0
```

If only the software name is supplied, the system will load the most recent version.

```
$ module load gcc
$ module list
Currently Loaded Modulefiles:
 1) gcc/13.2.0
```

Some modules have dependencies. They are usually listed as the last part of the module name. This means another module has to be loaded, for the current module to work correctly. If this is set up correctly by the module creator, this is automatic.

```
$ module load paraview/5.12.0/gnu1320_openmpi502_python3118
Loading requirement: gcc/13.2.0 openmpi/5.0.2/gnu1320 python/3.11.8/gnu1320
```

### Remove modules
To remove a module from your environment, you can use the `module unload` command followed by the module name. Depending on the implementation and age of the module system, this may or may not remove unused dependencies. 

```
$ module unload paraview/5.12.0/gnu1320_openmpi502_python3118
```

To reduce the risk of complications, it is generally recommended, to unload unused modules. To ensure a clean environment every time, you can use `module purge` to get rid of all modules loaded and start from scratch.

```
$ module purge
```


## Modulepath
Within your environment you will see you have a variable called `$MODULEPATH`, which tells the module utility where to look for modulefiles.
You can expand this variable with your own created modulefile hierarchy. Ensure, you add to it and not overwrite it, or you lose access to the modules installed by admins!

```
MODULEPATH="$MODULEPATH:/path/to/my/modulefiles"
```

## Modulefile hierarchy
The modulefile hierarchy is a directory structure, that ends in a file. This hierarchy will be referred to as the module name when loading the module. With the help of directories, you can create this hierarchy, which allows for easy grouping of the same software if installed in multiple versions or configurations. The best practice way to set up your hierarchy like in the examples below:

```
/path/to/my/modulefiles <--directory: Directory referred to in $MODULEPATH
└ software              <--directory: Name of the software
    └ version           <--directory: Version number of the software
        └ build         <--file: Build dependencies
```

So the module would be loaded as such:

```
module load software/version/build
```

All modules managed by the admin team follow this principle, so feel free to look at them for inspiration on how to define your hierarchy! Here a couple of examples:

|Module name|Note|
|---|---|
|cuda/13.1.0/gcc11.5.0|This module provides the NVIDIA CUDA Toolkit in the version 13.1.0 and was built using gcc version 11.5|
|python/3.11.8/gcc13.2.0|This module provides python in the version 3.11.8 and was built using gcc version 13.2.0|
|paraview/5.12.0/gcc13.2.0_openmpi5.0.2_python3.11.8|This module provides the software ParaView in the version 5.12.0 and was built using gcc version 13.2.0. In addition for the software to function correctly, python in the version 3.11.8 and openMPI version 5.0.2 has to be available.|

!!! tip "Software installation directory"

    It is recommended to store your software installations in a similar hierarchy to your module files. This avoids chaos and confusion!

## Modulefiles
The modulefile is a TCL script, that sets up your environment to accommodate your software. Below you can find a example template, feel free to use this and adjust for your software.

!!! warning "Important"

    The first line of the file has to start with `#%Module`. This is called the "magic cookie" and without it, the file will not be interpreted. 

``` linenums="1"
#%Module
#
# APPNAME APPVERSION modulefile
#
#

proc ModulesHelp { } {
        puts stderr {This module makes APPNAME version APPVERSION available to use.

This module was created by CREATOR,for any help please get in contact through CONTACT.
        }
}

# The information provided below is used to give more information about the software and is considered in the module search.
module-whatis   "loads APPNAME version APPVERSION."

# Set a variable for the base / prefix of your installation, this makes it easier to later manage all the PATHs you want to export.
set APPDIR /path/to/my/modulefiles/APPNAME/APPVERSION/BUILD

# Load Module dependencies (if applicable)
# for example if you used a compiler module to build that installation and you need to load that for your installation to work
module load MODULENAME

# Tcl special configuration
## for example, you can add conflicts with other modules if you don't want this module to be loaded if any APPNAME modules are already loaded
conflict MODULENAME

# more modules-specific tcl commands can be found here https://modules.readthedocs.io/en/v4.1.0/modulefile.html

# Set environment variables
## these are the variables needed for the installation to work, like exporting the binaries directory to the PATH environment variable, exporting the run-time libraries (libxx.a or libxx.so) to the LD_LIBRARY_PATH, exporting the generated header files (for example xxx.c) to the CPATH, C_INCLUDE_PATH,..
## you can use "prepend-path", to ensure this software is used before any pervious installations, or use "append-path" to ensure user specific configurations are prioritised. 

prepend-path    PATH                $APPDIR/bin
prepend-path    LD_LIBRARY_PATH     $APPDIR/lib
prepend-path    LIBRARY_PATH        $APPDIR/lib
prepend-path    PKG_CONFIG_PATH     $APPDIR/lib/pkgconfig
prepend-path    CPATH               $APPDIR/include
prepend-path    C_INCLUDE_PATH      $APPDIR/include
prepend-path    MANPATH             $APPDIR/share/man
setenv          APP_HOME            $APPDIR
```



## (GES-Petrarch Specific Configurations) Install Software Tools and Module Files 

This guide is to explain how GES members can set up software installations, and create module files for them.
 
In order to enable that, RCaaS has applied these configurations:
 
1- Created `ges-dev` unix group, members of this group should have the needed permissions to add software and modules.

2- Created `/mnt/software/ges-dev` directory, where the GES members can add software installations.

3- Created `/mnt/software/ges-dev-modules`, where module files for the installations can be created.

4- Added a template module file `/mnt/software/ges-dev-modules/.module_template` (hidden file), this template can be copied and adjusted to activate various installations.
 

 
More details on each point:
 
1- Members who are supposed to add software should contact RCaaS through Ivanti and request to be added to that group.
 
 
2- In general, to perform a software installation, you should follow the relevant installation guide, whether it's in the official documentation, a README file with the source distribution or on a GitHub page,.. Etc
 
You can start experimenting in your local dirs (home or scratch), or you can directly use `/mnt/software/ges-dev` and create subdirs for your installations, whatever you feel comfortable with.
 
There's a convention for the directory structure and its naming that we recommend following which looks like `/software_root/app_name/app_version/build_or_dependencies`
 
For example, if you're installing Open MPI 5.0.6 using GCC 13.2.0, the installation path should be
`/mnt/software/ges-dev/openmpi/5.0.6/el9_gnu1320`
Where el95 refers to Enterprise Linux (an OS that's based off Red Hat Enterprise Linux, which on our system is Oracle Linux) of version 9
(As you can see we removed the dots in the build name to make it more compact)
 
This convention helps to have multiple flavours of the same tool and easily identify them.
 
 
3- The directory `/mnt/software/ges-dev-modules` is already configured to be part of the module path, meaning any modules added there will appear in the "module avail" command output and can be used like the other ones. 
 
It's recommended to follow the same convention for directory structure and naming as explained earlier.
 
 
4- In the template module file (.module_template) we tried to cover as much configurations for a software installation as we can. 
 
The most important change (sometimes it could be the only one) needed to configure a software module would be where you set up the installation path. This is later used to easily set up your environment variables:
```
set APPDIR /mnt/software/ges-dev/APPNAME/APPVERSION/BUILD
```
Any dependencies used to build and are needed for the runtime of the software should be loaded in the module file. The command is similar to what you run on the terminal: 
```
module load app/version/build
``` 
The configured environment variables in the template are the most commonly used, please remove the ones that are not needed for your installation. As an example, the location of the generated binaries/executables of an installation should be appended to the PATH env var in order to run it directly without the need to use the full path:
```
prepend-path    PATH                $APPDIR/bin
```
 
A full documentation of modulefiles from the developer of Environment Modules can be found here: https://modules.readthedocs.io/en/stable/modulefile.html

