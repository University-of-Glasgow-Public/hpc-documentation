# Submission Script Templates

The scripts below can be run on the platform as is. You can expand them with parameters from [Slurm Parameters](./slurm-parameters.md) and your own workflows!

All Scripts are also available on GitHub [here](https://github.com/University-of-Glasgow-Public/hpc-documentation/tree/main/downloads).

If you want to download a specific script you can right click the link below the script of choice and choose "Save link as" to download on your local device, or choose "Copy link" and then download it from a login node using `wget` followed by the link:

```
wget <copied-link>
```

Important: When you use the templates below please do not increase the values of --nodes, –ntasks, --cpus-per-task or --ntasks-per-node randomly to any value >1, especially if your job can’t run in parallel. Your job may wait longer in the queue for resources you don’t need, also your priority factor will decrease, affecting the start time of your future jobs.

You can comment out (adding another #) or just remove any #SBATCH line you don’t need as long as it’s not mandatory, then the default values will apply.



## CPU Job

=== "Lochan"

    ``` Lochan
    --8<-- "https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/lochan-script-templates/lochan-cpu-job.sh"
    ```

    [Download :material-mouse-right-click:](https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/lochan-script-templates/lochan-cpu-job.sh){:target="_blank"}

=== "GES-Petrarch"

    ``` GES-Petrarch
    --8<-- "https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/gespetrarch-script-templates/gesp-cpu-job.sh"
    ```

    [Download :material-mouse-right-click:](https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/gespetrarch-script-templates/gesp-cpu-job.sh){:target="_blank"}

=== "MARS"

    ``` MARS
    --8<-- "https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/mars-script-templates/mars-gpu-job.sh"
    ```

    [Download :material-mouse-right-click:](https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/mars-script-templates/mars-gpu-job.sh){:target="_blank"}



## GPU Job

=== "Lochan"

    ``` Lochan
    --8<-- "https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/lochan-script-templates/lochan-gpu-job.sh"
    ```

    [Download :material-mouse-right-click:](https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/lochan-script-templates/lochan-gpu-job.sh){:target="_blank"}

=== "GES-Petrarch"

    ``` GES-Petrarch
    --8<-- "https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/gespetrarch-script-templates/gesp-gpu-job.sh"
    ```

    [Download :material-mouse-right-click:](https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/gespetrarch-script-templates/gesp-gpu-job.sh){:target="_blank"}

=== "MARS"

    ``` MARS
    --8<-- "https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/mars-script-templates/mars-gpu-job.sh"
    ```

    [Download :material-mouse-right-click:](https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/mars-script-templates/mars-gpu-job.sh){:target="_blank"}



## Array Job

=== "Lochan"

    ``` Lochan
    --8<-- "https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/lochan-script-templates/lochan-array-job.sh"
    ```

    [Download :material-mouse-right-click:](https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/lochan-script-templates/lochan-array-job.sh){:target="_blank"}

=== "GES-Petrarch"

    ``` GES-Petrarch
    --8<-- "https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/gespetrarch-script-templates/gesp-array-job.sh"
    ```

    [Download :material-mouse-right-click:](https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/gespetrarch-script-templates/gesp-array-job.sh){:target="_blank"}

=== "MARS"

    ``` MARS
    --8<-- "https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/mars-script-templates/mars-array-job.sh"
    ```

    [Download :material-mouse-right-click:](https://github.com/University-of-Glasgow-Public/hpc-documentation/raw/refs/heads/main/downloads/mars-script-templates/mars-array-job.sh){:target="_blank"}

