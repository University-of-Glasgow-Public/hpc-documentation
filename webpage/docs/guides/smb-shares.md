# SMB Shares

SMB, short for Server Message Block, is a protocol used to communicate with storage devices. On the Linux side you also see CIFS, short for Common Internet File System. Such storage spaces are traditionally mounted onto your personal device, but you may want to access them using SMB from an HPC. 

## Using smbclient on HPC

Using `smbclient` you can download and upload data from and to shares using SMB. 

In the further manuals below we have different examples, based on particular systems you may be interested in accessing from an HPC. You can swap to them using the tabs.

=== "General Example"

    THis is a template with placeholders formatted in angle brackets `<>`. Please replace the whole value, including the brackets with any connection information you may have received from an admin.

=== "CARDS"

    The Central Active Research Data Storage Service, CARDS for short, is a University of Glasgow centrally managed data storage service for staff and PGR students. It is designed for use by in progress research projects. You can find more information on the [University of Glasgow Website](https://www.gla.ac.uk/myglasgow/rcaas/cards/).

=== "Network Home Drive"

    The Network Home drive available to you as staff or student within the University of Glasgow. Information on making it available on you personal device can be found on the [University of Glasgow Website](https://www.gla.ac.uk/myglasgow/it/filesharing/mappingdrive/).


### Browsing

`smbclient` is not the most handy tool to browse or manage data on a share. For bigger management tasks, make sure to mount the share to your personal device.

Run `smbclient` command below that connects to a share interactively. When prompted, enter in your password. The parameter you use in the command are described below. To look at other parameters use `man smbclient` on the console.

- `-U`: The user used to connect to the SMB share. the part before the "\" is the domain and for UofG this is CAMPUS, but may be different. The admin of the storage should be able to give you information on this.

=== "Example"

    ```
    $ smbclient //<server_name>/<share_name> -U <domain>/<username> 
    ```

=== "CARDS"

    ```
    $ smbclient //campus.gla.ac.uk/CARDS -U CAMPUS/<guid>
    ```

=== "Network Home Drive"

    ```
    $ smbclient //campus.gla.ac.uk/SSD_Home_Xtra_D -U CAMPUS/<guid>
    ```

You will now be in a sub-shell for just SMB related commands. Here are some useful commands, that help you browse a share:

- `dir`: List all contents of the current directory you are in. In the list, elements with a "D" next to their name are directories.
- `cd`: change into a different directory.
- `cd ..`: go back one directory.
- `pwd`: show your current working directory.
- `mget <filename>`: download a specific file into your working directory on the HPC (where you started `smbclient` from).
- `exit`: leave the interactive SMB sub-shell.

### Download data

In the example below we will download data from an SMB Share and save it into our `$HOME`. 

Create a directory for the data:

```
$ mkdir $HOME/myData
```

Move into the directory you want the data moved to:

```
$ cd $HOME/myData
```

Run `smbclient` command that copies data. When prompted, enter in your password. The parameter you use in the command are described below. To look at other parameters use `man smbclient` on the console.

- `-U`: The user used to connect to the SMB share. the part before the "\" is the domain and for UofG this is CAMPUS, but may be different. The admin of the storage should be able to give you information on this.
- `-D`: Directory to move into.
- `-c`: command to run. The commands used are described here:
    - `recurse ON`: execute any command recursively.
    - `prompt OFF`: disable individual prompt per file downloaded.
    - `mget *`: download all content in the directory.


=== "Example"

    ```
    $ smbclient //<server_name>/<share_name> -U <domain>/<username> -D my_research_data -c 'recurse ON; prompt OFF; mget *'
    Password for [<domain>/<username>]:
    getting file my_research_data\cat.txt of size 116 as cat.txt (37.8 KiloBytes/sec) (average 37.8 KiloBytes/sec)
    getting file my_research_data\pigeon.txt of size 5828 as pigeon.txt (1897.1 KiloBytes/sec) (average 967.4 KiloBytes/sec)
    ```

=== "CARDS"

    ```
    $ smbclient //campus.gla.ac.uk/CARDS -U CAMPUS/<guid> -D <name_of_cards_dir>/my_research_data -c 'recurse ON; prompt OFF; mget *'
    Password for [CAMPUS/<guid>]:
    getting file my_research_data\cat.txt of size 116 as cat.txt (37.8 KiloBytes/sec) (average 37.8 KiloBytes/sec)
    getting file my_research_data\pigeon.txt of size 5828 as pigeon.txt (1897.1 KiloBytes/sec) (average 967.4 KiloBytes/sec)
    ```

=== "Network Home Drive"

    ```
    $ smbclient //campus.gla.ac.uk/SSD_Home_Xtra_D -U CAMPUS/<guid> -D <guid>/my_research_data -c 'recurse ON; prompt OFF; mget *'
    Password for [CAMPUS/<guid>]:
    getting file my_research_data\cat.txt of size 116 as cat.txt (37.8 KiloBytes/sec) (average 37.8 KiloBytes/sec)
    getting file my_research_data\pigeon.txt of size 5828 as pigeon.txt (1897.1 KiloBytes/sec) (average 967.4 KiloBytes/sec)
    ```


Your data is now in the local directory:
```
$ cat cat.txt
  /\_____/\
 /  o   o  \
( ==  ^  == )
```

### Upload data

In the example below we will upload data from your $HOME on an HPC login node to a SMB Share. 

Move into the directory you want to upload from:

```
$ cd $HOME/myData
```

Run `smbclient` command that copies data. When prompted, enter in your password. The parameter you use in the command are described below. To look at other parameters use `man smbclient` on the console.

- `-U`: The user used to connect to the SMB share. the part before the "\" is the domain and for UofG this is CAMPUS, but may be different. The admin of the storage should be able to give you information on this.
- `-D`: Directory to move into.
- `-c`: command to run. The commands used are described here:
    - `recurse ON`: execute any command recursively.
    - `prompt OFF`: disable individual prompt per file downloaded.
    - `mput *`: download all content in the directory.


=== "Example"

    ```
    $ smbclient //<server_name>/<share_name> -U <domain>/<username> -D my_research_data -c 'recurse ON; prompt OFF; mput *'
    Password for [<domain>/<username>]:
    putting file dog.txt as \js628s\my_research_data\dog.txt (37.8 KiloBytes/sec) (average 37.8 KiloBytes/sec)
    putting file seagull.txt as \js628s\my_research_data\seagull.txt (1897.1 KiloBytes/sec) (average 967.4 KiloBytes/sec)
    ```

=== "CARDS"

    ```
    $ smbclient //campus.gla.ac.uk/CARDS -U CAMPUS/<guid> -D <name_of_cards_dir>/my_research_data -c 'recurse ON; prompt OFF; mput *'
    Password for [CAMPUS/<guid>]:
    putting file dog.txt as \js628s\my_research_data\dog.txt (37.8 KiloBytes/sec) (average 37.8 KiloBytes/sec)
    putting file seagull.txt as \js628s\my_research_data\seagull.txt (1897.1 KiloBytes/sec) (average 967.4 KiloBytes/sec)
    ```

=== "Network Home Drive"

    ```
    $ smbclient //campus.gla.ac.uk/SSD_Home_Xtra_D -U CAMPUS/<guid> -D <guid>/my_research_data -c 'recurse ON; prompt OFF; mput *'
    Password for [CAMPUS/<guid>]:
    putting file dog.txt as \js628s\my_research_data\dog.txt (37.8 KiloBytes/sec) (average 37.8 KiloBytes/sec)
    putting file seagull.txt as \js628s\my_research_data\seagull.txt (1897.1 KiloBytes/sec) (average 967.4 KiloBytes/sec)
    ```

All the data should now be in your share.