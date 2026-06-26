# MATLAB

MATLAB combines a desktop environment tuned for iterative analysis and design processes with a programming language that expresses matrix and array mathematics directly.

MATLAB will run as a GUI, if X is configured, otherwise it will run within your console.

```
matlab
```

Information on how to work with GUI applications on MARS see [GUI / X applications]().

## Use Console Interface

To run MATLAB within your console even when X is configured, use the following options

```
matlab -nodisplay -nodesktop
```

## Run Script

You can save your MATLAB code in a script file and run it using the -batch option. In our example the script is called myMatlabCode.m. If your script is not in the same directory you are currently in, please provide the path to the file.

```
matlab -batch 'run("myMatlabCode.m")'
```

Please ensure your script has an exit at the end, otherwise MATLAB will continue to run idle until the walltime of your job has run out. If that is not the case you can also supply it through the command line:

```
matlab -batch 'run("myMatlabCode.m";exit)'
```

## Show Add-Ons

To list all add-ons installed and licensed on the system use:

```
matlab -batch "matlab.addons.installedAddons"
```

## External Resources

[MATLAB Website](https://uk.mathworks.com/products/matlab.html)

[MATLAB Documentation](https://uk.mathworks.com/help/index.html?s_tid=CRUX_lftnav)
