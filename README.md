# LiveG OS Bootstrap Toolchain
Bootstrapping toolchain for building LiveG OS installation disk images.

Licensed by the [LiveG Open-Source Licence](LICENCE.md).

## Prerequisites
Before bootstrapping LiveG OS, you'll need to run this command on a Debian host system to install the required tools:

```bash
$ sudo apt-get install qemu netcat grub-common grub-pc-bin xorriso rsync
```

`sudo` commands will be run throughout the bootstrapping process. To ensure continuity, set the `NOPASSWD` option for `sudo` for your user/group by editing the file provided by running `sudo visudo`.

## Ports that must be open
To allow the toolchain to work properly, please keep the following ports open:

* `8000`: used for hosting files on a web server under the `host` directory
* `8001`: used for hosting a TCP server for communicating with QEMU

## Expected time to bootstrap
Bootstrapping LiveG OS will take around 8 minutes with KVM or 37 minutes without KVM, though this will depend on the specifications of the host system:

### With KVM
* It takes 1 minute to download the base system installer (dependent on speed of internet connection)
* It takes 4 minutes to install the base system to a virtual disk drive
* It takes 0 minutes to to boot the disk drive to the firstboot script
* It takes 2 minutes to run the firstboot script to completion (dependent on speed of internet connection)
* It takes 1 minute to build the ISO file

### Without KVM
* It takes 1 minute to download the base system installer (dependent on speed of internet connection)
* It takes 29 minutes to install the base system to a virutal disk drive
* It takes 1 minute to boot the disk drive to the firstboot script
* It takes 5 minutes to run the firstboot script to completion (dependent on speed of internet connection)
* It takes 1 minute to build the ISO file

Many parts of the bootstrapping process are cached in the `cache/` folder, and so once fully-bootstrapped, bootstrapping again will be quicker to perform.

## Bootstrapping
To bootstrap LiveG OS, run the following:

```bash
$ ./bootstrap.sh
```
