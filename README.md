# Vagrant Base Box

## Required Software

To use this box, you need to install the following software.

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 

## Using this Box

On initial load you can run this command:
```
vagrant up
```

To stop vagrant, run this command:
```
vagrant halt
```

## Provisioning

Ansible is the provisioner used for this box. 
* [Ansible Provisioner](https://www.vagrantup.com/docs/provisioning/ansible.html)

If box is running, you can run this command:
```
vagrant provision
```

If the box isn't running, use this command:
```
vagrant up --provision
```

There is some default provisioning set up that covers docker, git, light-weight GUI environment, basic browsers, AWS and SSH credential set up.

## SSH Keys

To use SSH with Git you'll need to create a keygen pair
* [Generating a SSH public key for Git](https://git-scm.com/book/en/v2/Git-on-the-Server-Generating-Your-SSH-Public-Key)

To ensure these files are added to the appropriate place within Vagrant, name the local key file:
* id_rsa_github
* id_rsa_aws 

Instructions on adding an SSH key:
* [Github](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)
* [AWS](https://docs.aws.amazon.com/opsworks/latest/userguide/security-settingsshkey.html)

## Using with AWS

To use with your AWS account, start by copying the config.yml file and name it custom-config.yml.  

*DO NOT commit that file!*

You will add your own secret access key and access_key_id. So heed the warning above and do not commit this file.  It will exist locally only.  Vagrant knows to use the custom-config.yml over the config.yml if you have one.

## Booting with Grub

If you need to boot via the Grub screen once you've successfully run provision the first time and still have the machine up, SSH into vagrant from outside the box and then use these commands.

```
vagrant ssh
```

Go into the Grub file via this command.
```
sudo vi /etc/default/grub
```

Make these changes
```
GRUB_DEFAULT=1
# GRUB_HIDDEN_TIMEOUT=0
GRUB_TIMEOUT=-1
```

After you made the above changes and saved run this command to update.
```
sudo update-grub
```

Now you can exit Vagrant SSH.
```
exit
```
