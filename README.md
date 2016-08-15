# ADBSDL

This is a C/C++ package for working on the Arduboy. The library supports
building a hex file and uploading to an Arduboy using the
[Arduino-Makefile](https://github.com/sudar/Arduino-Makefile) project.

## Starting

Make sure all instructions in this section are followed to start using the
project.

### Vagrant

Vagrant is used to provision a virtual-machine.

Instructions for installing and using Vagrant can be found through the project
website, https://vagrantup.com.

#### Vagrant Plugins

Install the following Vagrant plugins,

> <b>plugins</b>
> - vagrant-vbguest

using the following command.

~~~~~~~~~
vagrant plugin install vagrant-vbguest
~~~~~~~~~

## Develop

To develop this project start by cloning the repository and checking out the
`develop` branch.

~~~~~~~~~
git clone https://github.com/rogosher/adbsdl.git
~~~~~~~~~

To View all of the branches available:

~~~~~~~~~
git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/develop
  remotes/origin/master
~~~~~~~~~

Select and checkout an available branch to a local tracking branch. Below we
checkout and start using the `develop` branch.

~~~~~~~~~
git checkout -b develop origin/develop
~~~~~~~~~

## Use

To us the Vagrant instance provided, change you working directory to the location where this project was cloned. Run `vagrant` with the command `up`:

~~~~~~~~~
vagrant up
~~~~~~~~~

After which the machine should attempt to boot.

### Using Vagrant

A short guide to using Vagrant.

#### Connecting to a Vagrant Instance

From the directory `vagrant up` was succesfully executed in, use the `vagrant` sub-command, `ssh`, to connect a that Vagrant machine.
~~~~~~~~~
vagrant ssh
~~~~~~~~~

#### Reloading and Provisioning

To reload a vagrant box and run the any provision blocks, us the `vagrant` sub-command, `reload`, with the `--provision` paramate.

~~~~~~~~~
vagrant reload --provision
~~~~~~~~~

This will allow you to test any changes made to the `Vagrantfile`.

##### SSH to Quick Provision with `vagrant ssh`

~~~~~~~~~
vagrant ssh -c 'cd /opt/Arduboy && sudo su - -c "scripts/provision_vagrant.sh"'
~~~~~~~~~

#### Other Vagrant Commands

~~~~~~~~~
help
status
global-status
halt
destroy
~~~~~~~~~

#### Windows and Unix 

The characters used to create line endings in DOS/Windows files differ from
those found in files created on Unix/Linux machines.

**Fix in Vim**

In Vim, set the file format for a file in Vim.

~~~~~~~~~
# unix/linux
:set ff=unix
# dos/windows
:set ff=dos

# write
:w
~~~~~~~~~

### Compiling a Project

Currently the project is stored in `/opt/.../`. Please run `make` from this directory.

