# Quota

Quotas are used to prevent users from using over a certain amount of a shared storage space. You can put quotas on storage size of filecount. Quotas can be set per user or per group and counts across a storage space and not just within a single directory.

## Quota Terminology

|Term|Explanation|
|---|---|
|**Soft Limit**|Users are still able to use the system normally and write files until either the Grace period runs out or they reach the hard limit, whichever comes first. Referred to as "quota" in the quota command output.|
|**Hard Limit**|When reached users won't be able to further write files. Referred to as "limit" in the quota command output.|
|**Grace Period**|Time until the user's quota turns from a soft limit to a hard limit. You have to act during this period on reducing your quota to be lower than the soft limit again to avoid any issues logging into or using the system.|

## Investigate your Quota

To see if or how close you are to reaching your quota, you can use `quota -s` on the login node:

```
[<GUID>@login1 ~]$ quota -s
Disk quotas for user <GUID> (uid <UID>):
     Filesystem   space   quota   limit   grace   files   quota   limit   grace
storage:/exports/home    8280K    100G    120G            1775       0       0
storage:/exports/scratch    291G    500G    550G              16       0       0

```
In the first column "Filesystem" you see the name of the filesystem, if this is a share it will be in the format `<server>:/path/to/export`. If you want to see which local filesystem this equates to, you can add the `--show-mntpoint` parameter.
 
The second column "space" shows the currently used space on the filesystem. The sixth column "files" shows you the number of files on the filesystem. This will give you an idea of how close you are to reaching either your quota or your limit. If you are over your quota, you will see an asterisk (`*`) next to the number too. If there are no quotas set, you can tell by the `quota` and `limit` columns being either empty or set to 0.
 
If you have an elaborate directory structure and you are unsure where the bulk of your data is the command `du` (from disk usage) can help you narrow that down. Here a couple of helpful commands:
 
Show size of all subdirectories in a directory:

```
du -h -d 1  /path/to/dir
```

Show all directories and files over 50GiB throughout a whole filesystem:
```
du -h -t 50G -a /path/to/dir
```

For both of these command you can pipe (`|`) the result to `sort –h` to sort them by size. To reverse this sort also use the `-r` parameter:
```
du -h -d 1  /path/to/dir | sort -h
```

