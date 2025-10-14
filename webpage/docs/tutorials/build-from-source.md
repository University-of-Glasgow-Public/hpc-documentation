# Building Software from Source
Open source software developers, often give you the option to build their software from the source code. This allows you to install a software yourself with all the customisations fit for your work.

These installations are very individual to each software, so pay close attention to the developers documentation and installation manual. The page here is to explain some core concepts and to build your first installation from source.

For our example we will be building `python3` from source. The instructions are from the README.md file of the [cpython repository](https://github.com/python/cpython?tab=readme-ov-file#build-instructions).

Let’s create a directory where we want the installation to sit. This is going to be the directory where all your binaries and application files for python3 will reside:

```
mkdir --parents ~/mysoftware/python3/3.13.2
```

For larger installations we recommend doing them within an interactive batch job if possible!

## Dependencies
Sometimes software requires preinstalled dependencies to be built. These packages are often called `*-devel` and contain the header files for common libraries used during the build process. But it can also be other dependant software like `openMPI` or `nvidia-cuda`. In some cases you might be able to just load the appropriate modules on the cluster.

As you don’t have `sudo` / `root` access on the cluster, you won’t be able to install any dependencies through the package manager (`dnf`, `yum`, `apt`), as some installation manuals make you believe. To get around this you have some options:

- You can also build all the dependencies yourself from source.
- You can make use of conda environments or containers.
- You can contact the RCaaS HPC admin team for help, who can look to install missing packages.

For our `python3` example, no dependencies have to be installed.

## Download source code
Source code is often made available through a tarball. This is a usually compressed archive containing all the source code. To download this, you can use the `wget` utility followed by the link to the tarball file. In our case this is:

```
wget https://www.python.org/ftp/python/3.13.2/Python-3.13.2.tgz
```

To then unpack this archive, you can use the `tar` utility:

```
tar --extract --file Python-3.13.2.tgz
```

Please be aware, that archives might be `.zip` and therefore require the `unzip` utility to unpack. Some software might also expect you to download their source from a git repository. For this you can use the `git` utility.

## Compile the code
Python3 is using the [GNU Autotools](https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html) as its build tool, which is very popular. Another one you might come across quite often is [Cmake](https://cmake.org/cmake/help/latest/guide/tutorial/index.html). Just follow the developers installation manual.

First we move into the directory we unpacked above:

```
cd Python-3.13.2
```

Now, we will prepare the `Makefile`, using the `.configure` script provided by the developers. This step will ensure dependencies are satisfied and sets desired build options. This is where you can customise your installation!

To get a list of all available build options you can run:

```
./configure --help
```

You will see there is a big list! You can read up on what all of these options mean and decide for yourself what you want to change. For our example, there is only one we will be using, `--prefix`. This parameter decides where our installation will reside. As a default it will try to install the software in the system directories, which only `root` has access to. This is the parameter you will most likely need to adjust for all your installations, to ensure you can do installations without requiring elevated privileges.

For our prefix, we choose the directory we created at the beginning:

```
./configure --prefix=$HOME/mysoftware/python3/3.13.2
```

Now we can run `make`, to compile the software based on the information gathered in the `Makefile`. This step can take a long time depending how complicated the software you are building is:

```
make
```

As a last step, this will copy the binaries and other application files into the directory we set as our `--prefix`, from where we can then make use of them:

```
make install
```

To test if our installation was successful, lets run the `python3` binary we built!

```
$ $HOME/mysoftware/python3/3.13.2/bin/python3 --version
Python 3.13.2
```

If we are confident our installation was successful, we can delete all our build files and source code, to save storage:

```
rm -rf Python-3.13.2
```

## Adjust Environment
To make the application files seamlessly available in your environment, you have to change some environment variables. The environment variables are set as such:

```
export <var-name>="<path1>:<path2>:<path3>"
```

For all these variables, it works on a first match basis. The system goes through all paths listed and the first match it finds will be the executable run. So to ensure, our own installation is used before the system installation, our newly added paths have to be before the system paths. Ensure, to always add the current `$<var-name>` when updating your variables, to ensure you don’t lose access to any software!

For the executables, we will add the created bin directory to the `$PATH` variable:

```
export PATH="$HOME/mysoftware/python3/3.13.2/bin:$PATH"
```

For our libraries, we add the lib path to the `$LD_LIBRARY_PATH` variable:

```
export LD_LIBRARY_PATH="$HOME/mysoftware/python3/3.13.2/lib:$LD_LIBRARY_PATH"
```

And to make sure we have the right manual pages for our version we add the path to the `man` pages to `$MANPATH`:

```
export MANPATH="$HOME/mysoftware/python3/3.13.2/share/man:$MANPATH"
```

Now your installation should be seamlessly included in your software stack.

```
$ python3 --version
Python 3.13.2
```

If you don’t want this to get lost when you next log in, you can add it to your `~/.bashrc` file.

```
$ cat ~/.bashrc
...
export PATH="$HOME/mysoftware/python3/3.13.2/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/mysoftware/python3/3.13.2/lib:$LD_LIBRARY_PATH"
export MANPATH="$HOME/mysoftware/python3/3.13.2/share/man:$MANPATH"
...
```