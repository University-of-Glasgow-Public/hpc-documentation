# UNIX for Beginners

This small tutorial should give you a start to the world of UNIX console! If you have any questions or issues, feel free to contact us! We help novice and expert users alike to get settled.

For this whole tutorial you will find code snippets, these are displayed as interactions on a console. Lines with a preceding $ are the commands entered, ones without, are the output of these commands.

```
$ <command-entered-by-user>
<command-output>
```

For all commands mentioned in the tutorial and most other UNIX commands, you can find a manual page with all the information about it. To access it just run `man` followed by the command. Here an example with `ls`:

```
$ man ls
```

Use the arrow keys to move up and down on the manual and press `q` on your keyboard to exit.

---

## Lesson 1: Filesystem
The Filesystem is build hierarchically. When first logging into the system with SSH, you’ll get put into your home directory. In our example, this is `/users/<GUID>`, where `users` is the parent directory of your home. The prepending `/` (root) signifies that it is a *full path* rather than a *relative path*, which starts from where you are currently at in the hierarchy.

As an example for this lesson, let’s take this directory structure:

```
/
└ users
  └ 999999x
  └ xx999x
    └ Documents
      └ myFile.txt
    └ Images
└ mnt
  └ data
└ tmp
```

You are user `xx999x` and therefore your journey starts in your home `/users/xx999x`.

The *full path* to the file `myFile.txt` is: `/users/xx999x/Documents/myFile.txt`

The *relative path* from your position after logging in is: `Documents/myFile.txt`

### Listing Files and Directories
To list the contents of a directory use the `ls` command, where ls stands for list:. Using it without arguments will show you the contents of the directory you are currently in:

```
$ ls
Documents Images
```

Files with a prepending `.` are hidden files and will not be listed by default. To also show hidden files use the `-a` parameter:

```
$ ls -a
. .. .bashrc Documents Images
```

You can supply a path to a directory you wish to list the contents of after the `ls` command:

```
$ ls Documents
myFile.txt
```

### Changing Directories
To show the full path of the directory you are currently in you can use the `pwd` command, where pwd stands for print working directory:

```
$ pwd
/users/xx999x
```

If you want to move around in the file system you can use the `cd` command, where cd stands for change directory. Using `cd` without arguments puts you back into your home directory.

```
$ pwd
/users/xx999x/Documents
$ cd
$ pwd
/users/xx999x
```

If you want to move into a specific directory you have to give the path to that directory as an argument:

```
$ pwd
/users/xx999x
$ cd Documents
$ pwd
/users/xx999x/Documents
```

Within every directory there are two directories, `.` for the current working directory and `..` for the parent directory. So if you want to go back, you can change into this directory:

```
$ pwd
/users/xx999x/Documents
$ cd ..
$ pwd
/users/xx999x
```

The symbol `~` (tilde) is used to refer to the home directory of a user. You can refer to this in your paths:

```
$ cd Images
$ pwd
/users/xx999x/Images
$ cd ~/Documents
$ pwd
/users/xx999x/Documents
```

## Lesson 2: Managing Files
As an example for this lesson, let’s take this structure:

```
/
└ users
  └ 999999x
  └ xx999x
    └ Data
      └ oldFile.txt
      └ ImportantFiles
        └ importantFile.txt
    └ Documents
      └ myFile.txt
    └ Images
└ mnt
  └ data
└ tmp
```

You are user `xx999x` and therefore your journey starts in your home `/users/xx999x`.

### Creating Directories
You can also expand the file structure by creating your own directories, as long as you have permission to do so, which within your home you should always have!

For this use the `mkdir` command, where mkdir stands for make directory.

```
$ ls
Documents Images
$ mkdir Data
$ ls
Data Documents Images
```

### Copying Files
To copy a file you can use the `cp` command, where cp stands for copy. The first argument after the command is the *source file*, which you want to copy. The second argument is the *destination*, that can be a directory or a path to a filename, which the copied file will get renamed to:

```
$ cp Documents/myFile.txt Data/
$ ls Data
myFile.txt
$ cp Documents/myFile.txt Data/copyOfMyFile.txt
$ ls Data
copyOfMyFile.txt myFile.txt
```

### Moving / Renaming Files
To move files around use the `mv` command, where mv stands for move. The first argument after the command is the *source file*, which you want to move. The second argument is the *destination*, that can be a directory or a path to a name, which the moved file will get renamed to:

```
$ mv Documents/myFile.txt Data/
$ ls Data
myFile.txt
```

You can also use the `mv` utility to rename a file, by moving it into the same place but choosing a different destination name:

```
$ ls Data
myFile.txt
$ mv Data/myFile.txt Data/myFileMoved.txt
$ ls Data
myFileMoved.txt
```

### Removing Items
To remove files and directories you can use the `rm` command, where rm stands for remove. Be careful though, as this action can not be undone!

For a single file you can just supply it as an argument:

```
$ ls Data
ImportantFiles oldFile.txt 
$ rm Data/oldFile.txt
$ ls Data
ImportantFiles
```

If you want to remove a whole directory you have to use the `-r` parameter, to remove recursively.

```
$ ls Data
ImportantFiles
$ rm -r /Data/ImportantFiles
$ ls Data
```

## Lesson 3: Manipulating Text Files
As an example for this lesson, let’s take this structure:

```
/
└ users
  └ 999999x
  └ xx999x
    └ Data
      └ petData.csv
    └ Documents
    └ Images
└ mnt
  └ data
└ tmp
```

You are user `xx999x` and therefore your journey starts in your home `/users/xx999x`.

### Creating empty files
To create empty files you can use the `touch` utility. `touch` is a software that changes a file’s timestamp, but if the file supplied does not exist already, it will create it.

```
$ ls
Data Documents Images
$ touch myFile.txt
$ ls
Data Documents Images myFile.txt
```

### Viewing files
You don’t have to open a file in an editor to see its contents, you can use the `cat` utility, where cat stands for concatenate.

```
$ cat Data/petData.csv
name,animal,age
Fluffy,dog,3
Milky,cat,8
Rudolph,duck,2
Hank,cat,6
Princess,horse,12
Snickers,dog,6
```

If you only want to see the beginning of a file, you can use the `head` command. With `-` and any number you can choose how many lines from the top you want to display:

```
$ head -2 Data/petData.csv
name,animal,age
Fluffy,dog,3
$ head -4 Data/petData.csv
name,animal,age
Fluffy,dog,3
Milky,cat,8
Rudolph,duck,2
```

If you only want to see the end of a file, you can use the `tail` command. With `-` and any number you can choose how many lines from the bottom you want to display:

```
$ tail -2 Data/petData.csv
Princess,horse,12
Snickers,dog,6
$ tail -4 Data/petData.csv
Rudolph,duck,2
Hank,cat,6
Princess,horse,12
Snickers,dog,6
```

To remember these three commands, just think of the silhouette of a cat. If you want to see the whole cat, use `cat`. If you only want to see the top, use `head`. And if you only want to see the bottom use `tail`:

### Search in file
To search for a term or phrase within a file use the `grep` command. It returns you each line within a file, that matches the term you searched for and depending on your console settings also marks the word. Use the `-i` parameter to search case-insensitive:

```
$ cat Data/petData.csv
name,animal,age
Fluffy,dog,3
Milky,cat,8
Rudolph,duck,2
Hank,cat,6
Princess,horse,12
Snickers,dog,6
$ grep -i "dog" Data/petData.csv
Fluffy,dog,3
Snickers,dog,6
```

You can chain additional `grep` commands, to further search your results, just separate them with `|`.

```
$ grep -i "dog" Data/petData.csv
Fluffy,dog,3
Snickers,dog,6
$ grep -i "dog" Data/petData.csv | grep "6"
Snickers,dog,6
```

### Writing output to file
You can save output of a command in UNIX to a file, instead of printing it to the console. This is helpful, when you run a command, that creates a lot of output you’ll need to analyse later.

The following example with `>` writes the output (called `STDOUT`) of a command to a file and *overwrites* all existing content in that file. If the file does not exist already, it will be created.

```
$ ls
Data Documents Images
$ ls > myWorkDirectory.txt
$ ls
Data Documents Images myWorkDirectory.txt
$ cat myWorkDirectory.txt
Data Documents Images
$ ls > myWorkDirectory.txt
$ cat myWorkDirectory.txt
Data Documents Images myWorkDirectory.txt
```

The example below with `>>` writes the output (called `STDOUT`) of a command to a file and *appends* it to the existing content in that file. If the file does not exist already, it will be created.

```
$ ls
Data Documents Images
$ ls >> myWorkDirectory.txt
$ ls
Data Documents Images myWorkDirectory.txt
$ cat myWorkDirectory.txt
Data Documents Images
$ ls >> myWorkDirectory.txt
$ cat myWorkDirectory.txt
Data Documents Images
Data Documents Images myWorkDirectory.txt
```

### Edit file
To edit files, you can use a file editor. The most beginner friendly file editor is `nano`. If you run `nano` you will get put into an interactive program and lose access to the console:

```
$ nano Data/petData.csv
```

In your interactive editor, you can move around the file using the arrow keys on your keyboard and edit the file.

After you are done making your changes, you can press `ctrl + X`, this will prompt the application to exit. Press `Y` and then `Enter` to save your changes or `N` to discard them.

## Lesson 4: Filesystem Permissions
As an example for this lesson, let’s take this structure:

```
/
└ users
  └ 999999x
  └ xx999x
    └ Data
      └ myFile.txt
└ mnt
  └ data
    └ project9999
      └ ourResearchFile.txt
└ tmp
```

You are user `xx999x` and therefore your journey starts in your home `/users/xx999x`.

Every file and directory in UNIX has permissions. They are separated in three levels:

- *The User* (`u`) is usually the creator of the file or directory, only root can change this.
- *The Group* (`g`) is used to potentially share data with other groups of users.
- *Other* (`o`) is any other user on the system, this should be the layer that is most restricted.

Permissions are denoted in a string of 10 characters. The first 1 is to identify the type of file. This can be either of those:

- `d` for directories
- `l` for symbolic links
- `-` for an ordinary file

The other 9 to determine the permission for every level described above. Each level has 3 characters dedicated:

- `r` for read permission
- `w` for write permission
- `x` for execute permission (needed to run scripts or enter directories)

If any of the characters are a `-` instead, that means that this permission is not granted on that level.

Lets look at some examples of this:

|Permission|Explanation|
|----------|------------|
|`drwx------`|This is a directory with full permissions only on the *user* level. This is the permission your home directory would have.|
|`lrwxrwxrwx`|This is a symbolic link. Due to the nature of them always inheriting the permission of the resource they link to, they show as having full permission on all levels.|
|`-rw-rw-r--`|This is a file with read + write permissions on the *user* and *group* level, and only read permissions on the *other* level. This is the default permission if you create a new file.|

If you use the `-l` parameter for `ls`, you will get a long list output for a file or the components of a directory.

```
$ ls -l Data/myFile.txt
-rw-rw-r-- 1 <user> <group> <size> <date-time> Data/myFile.txt
```

Here you can see who is the *user* / *group* level owner and the 10 character string in action!

### Changing permissions
To change the permissions you can use the `chmod` command, where chmod stands for change mode. Define the level you want to modify (if nothing is provided, all levels get adjusted), the type of modification you are doing (`+`/`-`) and the permissions.

```
$ ls -l Data/myFile.txt
-rw-rw-r-- 1 xx999x clusterusers <size> <date-time> Data/myFile.txt
$ chmod o-r Data/myFile.txt
$ ls -l Data/myFile.txt
-rw-rw---- 1 xx999x clusterusers <size> <date-time> Data/myFile.txt
$ chmod ug+rwx Data/myFile.txt
$ ls -l Data/myFile.txt
-rwxrwx--- 1 xx999x clusterusers <size> <date-time> Data/myFile.txt
$ chmod -x Data/myFile.txt
$ ls -l Data/myFile.txt
-rw-rw---- 1 xx999x clusterusers <size> <date-time> Data/myFile.txt
```

As mentioned earlier, you can’t change the *owner* of a file without `root` permissions, however you can change *group*. For this use the `chown` command, where chown stands for change owner. When changing the group permission you have to put a `:` before the owner group name:

```
$ ls -l /mnt/data/project9999/ourResearchFile.txt
-rw-rw-r-- 1 xx999x clusterusers <size> <date-time> Data/ourResearchFile.txt
$ chown :project9999 /mnt/data/project9999/ourResearchFile.txt
$ ls -l /mnt/data/project9999/ourResearchFile.txt
-rw-rw-r-- 1 xx999x project9999 <size> <date-time> Data/ourResearchFile.txt
```

This can be used to share files with your fellow project members.

### Special permissions
Special permissions are used to manipulate permission functionality to a file or directory and can be set on all three levels, each with different effects:

#### User (suid)
When set, the file is always run as the user owning the file, no matter who runs it. A well known example would be `/usr/bin/passwd`, which always runs as `root`.

This configuration is shown as an `s` instead of an `x` on the user level:

```
$ ls -l /usr/bin/passwd 
-rwsr-xr-x. 1 root root <size> <date-time> /usr/bin/passwd
```

#### Group (sgid)
If set on a file, the file can be run as the group. The more common way to use it is on a directory, where if sgid is set, group ownership of files created is set the the directory group owner. You will find this configuration is standard in shared directories.

This configuration is shown as an `s` instead of an `x` on the group level:

```
$ ls -l /mnt/data/
drwxrws--- 4 root project9999 <size> <date-time> project9999
```

#### Other (sticky bit)
This permission does not affect files. On directories however, it restricts file deletion and renaming. Only the owner user of a file can remove them within such a directory. This is most commonly used in `/tmp`, to allow everybody to write in it, but prevent others from deleting your work.

This configuration is shown as a `t` instead of an `x` on the other level:

```
$ ls -la /
drwxrwxrwt. 1980 root root <size> <date-time> tmp
```

To set these special permissions, you can also use the `chmod` command. On either the user or group level set `s` for suid or sgid. For the sticky bit you need to use `t`:

```
$ ls -l Data/myFile.txt
-rwxrwxrwx 1 xx999x clusterusers <size> <date-time> Data/myFile.txt
$ chmod ug+s Data/myFile.txt
$ ls -l Data/myFile.txt
-rwsrwsrwx 1 xx999x clusterusers <size> <date-time> Data/myFile.txt
$ chmod +t Data/myFile.txt
$ ls -l Data/myFile.txt
-rwsrwsrwt 1 xx999x clusterusers <size> <date-time> Data/myFile.txt
```