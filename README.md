Linux on Windows Setup
======

Linux on Windows Setup is a script to set up a Windows machine for web and mobile development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

Requirements
------------

We support:

* Windows 10 with Windows Subsystem for Linux installed using a debian variant like Ubuntu
* Windows 11 with Windows Subsystem for Linux installed using a debian variant like Ubuntu

Install
-------

Download the script:

```sh
curl --remote-name https://raw.githubusercontent.com/robspages/windowslinuxsetup/main/windows.sh 
```

Review the script (avoid running scripts you haven't read!):

```sh
less windows.sh
```

Execute the downloaded script:

```sh
sh windows.sh 2>&1 | tee ~/WSLsetup.log
```

Optionally, review the log:

```sh
less ~/WSLsetup.log
```
