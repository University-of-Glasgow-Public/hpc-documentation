# SSH Key Authentication

SSH keys across the cluster can be already set up by the Administrators upon creation of your account, if not you can easily set up SSH authentication. It is recommended for easy and secure access from your local device.

## Creating a key pair
Open a command line console on your personal device and use the ssh-keygen utility as shown below.

Save your key pair as a recognisable name, so you don’t get your keys confused. You have to submit the full path to the key, for that just copy the suggested one in brackets and change the filename. The example below is for Windows:

```
> ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (C:\Users\<GUID>/.ssh/id_rsa): C:\Users\<GUID>/.ssh/id_rsa-Petrarch
```

We highly recommend securing your key with a passphrase. Please choose one that adheres to the University of Glasgow password requirements. We recommend using different passphrases for every key and also every service in general.

```
Enter passphrase (empty for no passphrase): <your passphrase>
Enter same passphrase again: <your passphrase>
```

Your key-pair is now created and can be used to set up authentication.

```
Your identification has been saved in C:\Users\<GUID>/.ssh/id_rsa-Petrarch.
Your public key has been saved in C:\Users\<GUID>/.ssh/id_rsa- Petrarch.pub.
```

## Setting up SSH authentication

From a command line from your local computer, copy the public key to the remote system.

### Windows:

```
type C:\Users\<GUID>\.ssh\id_rsa-Petrarch.pub | ssh <GUID>@ petrarch_esd.hpc.gla.ac.uk "cat >> .ssh/authorized_keys"
```

### Mac / Linux:

```
ssh-copy-id -i ~.ssh/id_rsa-Petrarch <GUID>@petrarch_esd.hpc.gla.ac.uk
```


Now you can log into the Cluster login-node using SSH key authentication.

```
ssh -i C:\Users\<GUID>/.ssh/id_rsa-Petrarch <GUID>@petrarch_esd.hpc.gla.ac.uk
```

## Protection Principles

To make sure your keys are protected, please follow these principles:

•	Secure your private key with a passphrase that adheres to the University of Glasgow password requirements.

•	Use different key pairs for each system or cluster.

•	Treat your private key like a password, meaning you don’t share it with anyone.

•	If you think your private key might have been compromised, create a new key pair.

•	Delete unused public keys from your `$HOME/.ssh/authorized_keys` regularly on remote systems.



