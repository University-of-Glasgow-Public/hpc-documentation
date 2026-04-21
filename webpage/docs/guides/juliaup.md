# Juliaup
As Julia is still a quite young language, there are a lot of new versions being released regularly with potentially big changes. To make it easy for users to get access to the exact version they need on HPC, you can use Juliaup. Juliaup is a version management tool for Julia language. This allows you to easily install multiple versions and switch seamless between them.

This guide will give you some helpful information on how to use `juliaup` to manage different versions of Julia in your HPC environment. 

For more advanced information, please consult the official documentation of the application:
 
- [Juliaup GitHub](https://github.com/JuliaLang/juliaup)


## Install Julia version

!!! warning "Attention" 
    Please be aware, that installation of multiple versions could use a lot of storage space and push you over quota!

To install a version of Julia, you can use the command `juliaup add` followed by the version to be downloaded. 

```
juliaup add 1.6.7
```

Juliaup will automatically autocomplete any "lower" version number specified. For example, if only `1.6` is supplied, Juliaup will download the latest specific version `1.6.7`. If you want a specific version, you should always supply the full version number. 

You can add special channels that can be specified instead of a version number. A full list is in the official Juliaup documentation, but some helpful ones are:

- `release`: always points to the latest stable version.
- `lts`: always points to the latest long term supported version.
- `nightly`: always points to the latest build from the master branch in the Julia repository.

To get an overview of all currently downloaded versions, you can use the command `juliaup status`. The one marked with `*` is currently set as default:

```
$ juliaup status
 Default  Channel  Version                              Update
---------------------------------------------------------------
          1.6.4    1.6.4+0.x64.linux.gnu
          nightly  Development version 1.14.0-DEV.2064
       *  release  1.12.6+0.x64.linux.gnu
```


## Use Julia through Juliaup
When first installing or loading Juliaup, you will already have a `julia` binary available to you. This is a special binary, that will point to whatever installation is set using Juliaup. the default value is `release`, which will always use the latest stable version of Julia. If not available in your environment, it will be downloaded before running the software.

In the example below, we have no Julia version installed just yet using Juliaup:

```
$ juliaup status
 Default  Channel  Version  Update
-----------------------------------
```

However if we attempt to run something using `julia`, the latest version (At the time of writing this is 1.12.6) is being installed:

```
$ julia -e 'println("Hello World!")'
    Checking for new Julia versions
  Installing Julia 1.12.6+0.x64.linux.gnu
         Add Installed Julia channel 'release'
Hello World!
```

To change the version being used, you can use the `julia default` command followed by the version number:

```
juliaup default 1.6.7
```

If you wanted to run only one command / script using a different installed version you can specify it with the `julia` binary as an additional parameter:

```
julia +1.6.7 -e 'println("Hello World!")'
```


## Move Julia installation directory
Per default, all your Julia versions are saved within your `$HOME` directory here `~/.julia`. In addition to Julia environments, Juliaup will create a directory called `juliaup` and save all data for the different version channels in there. 

If you wanted to specify a custom location, you can do that via the environment variable `$JULIAUP_DEPOT_PATH`. The location has to be an absolute path, meaning it hast to start with `/`, and the directory has to exist already. In this example, we change the location to a personal scratch space:

```
export JULIAUP_DEPOT_PATH="/users/<GUID>/sharedscratch/software"
```

To ensure your `$JULIAUP_DEPOT_PATH` variable is always set correctly, you should add the command above (adjusted for your path) to your `~/.bashrc`.

After this, when first running `julia` or `juliaup`, it will create a directory called `juliaup` (`/users/<GUID>/sharedscratch/software/juliaup`) and save all data for the different version channels in there.

Alternatively, if you want to move an existing library of versions, you can move all data from your old Juliaup depot, to the new one defined in `$JULIAUP_DEPOT_PATH`:

```
mv .julia/juliaup /users/<GUID>/sharedscratch/software/
```


## Delete Julia versions
To avoid unnecessary storage usage, the admins would be glad if any unused Julia versions could be regularly deleted. You can delete installations using the command `juliaup remove` followed by the version number:

```
juliaup remove 1.6.7
```
