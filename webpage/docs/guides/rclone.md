# Rclone

Rclone is a command-line program to manage files on cloud storage. Over 70 cloud storage products support Rclone including S3 object stores, business & consumer file storage services, as well as standard transfer protocols.

For more advanced information, please consult the official documentation of the application: 

- [Rclone Documentation](https://rclone.org/docs/)

## Encrypt configuration
To keep all your information safe, you should encrypt your rclone configuration. From there on, you will have to use a password to use rclone, so be sure to store your password in a safe place!

Enter configuration manager:

```
rclone config
```

Enter `s` to set configuration password and confirm by entering `a`:

```
No remotes found, make a new one?
n) New remote
s) Set configuration password
q) Quit config
n/s/q> s
Your configuration is not encrypted.
If you add a password, you will protect your login information to cloud services.
a) Add Password
q) Quit to main menu
a/q> a
```

Enter your password. Keep in mind, that the password will not be shown in the console:

```
Enter NEW configuration password:
password: <your password won’t show when entered>
Confirm NEW configuration password:
password: <your password won’t show when entered>
Password set
```

You can now leave the configuration manager by entering `q`:

```
Your configuration is encrypted.
c) Change Password
u) Unencrypt configuration
q) Quit to main menu
c/u/q> q
```

## Setup for Teams storage
As Teams / OneDrive / SharePoint is the University of Glasgow’s official cloud storage, we’ll walk through on how to configure a remote connection to a Microsoft Team storage through `rclone`. Manuals for other connections can be found in the official documentation of Rclone.

Enter configuration manager:

```
rclone config
```

Create a new remote connection by entering `n`:

```
No remotes found, make a new one?
n) New remote
s) Set configuration password
q) Quit config
n/s/q> n
```

Choose a recognisable name for your remote connection. Something like "Teams_TeamName":

```
Enter name for new remote.
name> Teams_HPC-Admin
```

After you will get a list of connection types. For Teams use "Microsoft OneDrive" by entering `onedrive`:

```
…
26 / Microsoft OneDrive
   \ (onedrive)
…
Storage> onedrive
```

For the next four steps just continue by pressing "return" and choosing the default option:

```
Option client_id.
OAuth Client Id.
Leave blank normally.
Enter a value. Press Enter to leave empty.
client_id>

Option client_secret.
OAuth Client Secret.
Leave blank normally.
Enter a value. Press Enter to leave empty.
client_secret>

Option region.
Choose national cloud region for OneDrive.
Choose a number from below, or type in your own string value.
Press Enter for the default (global).
 1 / Microsoft Cloud Global
   \ (global)
 2 / Microsoft Cloud for US Government
   \ (us)
 3 / Microsoft Cloud Germany
   \ (de)
 4 / Azure and Office 365 operated by Vnet Group in China
   \ (cn)
region>

Edit advanced config?
y) Yes
n) No (default)
y/n>
```

To create your authentication token, we use the browser on your personal device, so enter `n`:

```
Use web browser to automatically authenticate rclone with remote?
 * Say Y if the machine running rclone has a web browser you can use
 * Say N if running rclone on a (remote) machine without web browser access
If not sure try Y. If Y failed, try N.

y) Yes (default)
n) No
y/n> n
```

On your local laptop, download rclone from the official website: [Download](https://rclone.org/downloads/).

Extract the downloaded .zip archive and start a shell from that directory. On Windows you can do it easily by clicking into the navigation, typing `cmd` and pressing "return".

Within your local console run the following command:

```
rclone authorize "onedrive"
```

This will open a browser on your device. If you have a UofG managed device, you should be logged in automatically. If not, log into your UofG account (GUID).

After you give Rclone the required permissions on your account, you should get a "Success!" message in the browser. Switch back to your local console and copy the `access_token` that was printed into the console.

You can now close your local console and delete the Rclone files from your laptop, if you don’t plan to set up more remote connections.

Back in your HPC console, paste the access_token and press "return":

```
For this to work, you will need rclone available on a machine that has
a web browser available.

For more help and alternate methods see: https://rclone.org/remote_setup/

Execute the following on the machine with the web browser (same rclone
version recommended):

        rclone authorize "onedrive"

Then paste the result below:
result> {"access_token":"<string of random
characters>","expiry":"2024-12-16T14:59:27.6563422+01:00"}
```

From the list choose "SharePoint site name or URL" by entering `url`:

```
... 
 3 / Sharepoint site name or URL (e.g. mysite or https://contoso.sharepoint.com/sites/mysite)
   \ "url"
...
Your choice> url
```

Copy the URL of your Team. You can access it, when you open your Teams storage in SharePoint (web). It should look something like "https://gla.sharepoint.com/sites/TeamName". Enter this URL in the Rclone config dialog:

```
Option config_site_url.
Site URL
Example: "https://contoso.sharepoint.com/sites/mysite" or "mysite"
Enter a value.
config_site_url> https://gla.sharepoint.com/sites/MARSAdmin
```

It will show you the drives it found on the Team. Select the one called Documents by entering `0` and confirming with `y`:

```
Found 1 drives, please select the one you want to use:
0: Documents (documentLibrary) id=<string of random characters>
Chose drive to use:> 0
Found drive "root" of type "documentLibrary"
URL: https://gla.sharepoint.com/sites/MARSAdmin/Shared%20Documents
Is that okay?
y) Yes (default)
n) No
y/n> y
```

You will then get a summary of the configuration you just made. Review it and save it by pressing "return"" again:

```
<your config>
Keep this "Team_MARS-Admin" remote?
y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote
y/e/d>
```

You can now use your configured remote connection in rclone commands as either a source or destination. The syntax is as follows:

```
<remote-name>:<path>
```

- `<remote-name>`: The name given to your remote connection in the first step of the configuration process
- `<path>`: The path to the directory in SharePoint where you want to save your data.


## Move data from and to storage
The command to move data is:

```
rclone move <source> <destination>
```

In this example we move data from the HPC to the Teams storage previously configured. The directories specified will be created on the Teams storage if they don’t already exist.

```
rclone move ~/myResearchResults Teams_HPC-Admin:Results/2024-05-01
```

All the files in your source directory will be moved and you should see them your SharePoint site.

To move data back to the HPC, just switch source and destination:

```
rclone move Teams_HPC-Admin:Results/2024-05-01 ~/myResearchResults
```

If you feel uncomfortable, with your data being gone from the source, use `copy` instead of `move`.


## Backing up data
It is important to keep your data on a secondary system, preferably a highly available one like OneDrive. The sync command makes source and destination identical, modifying the destination only!

The command to sync your directory with a remote storage is:

```
rclone sync <source> <destination>
```

In this example we backup data from the HPC to the Teams storage previously configured. The directories specified will be created on the Teams storage if they don’t already exist.

```
rclone sync ~/myData Teams_HPC-Admin:Backup/HPC-Data
```