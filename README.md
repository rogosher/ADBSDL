# ADBSDL

This is a C/C++ package for working on the Arduboy. The library supports
building a hex file and uploading to an Arduboy using the
[Arduino-Makefile](https://github.com/sudar/Arduino-Makefile) project.

## Develop

To develop this project start by cloning the repository and checking out the `develop` branch.

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

Select and checkout an available branch to a local tracking branch. Below we checkout and start using the `develop` branch.

~~~~~~~~~
git checkout -b develop origin/develop
~~~~~~~~~

## Using

To us the Vagrant instance provided, change you working directory to the location where this project was cloned. Run `vagrant` with the command `up`:

~~~~~~~~~
vagrant up
~~~~~~~~~

After which the machine should attempt to boot.

### Compiling a Project

Currently the project is stored in `/opt/.../`. Please run `make` from this directory.

