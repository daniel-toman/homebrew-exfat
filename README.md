# exFAT support for Mac OS X 10.5 Leopard and 10.4 Tiger (via Homebrew and Fuse for macOS)
This Homebrew formula enables *command line* exFAT filesystem support on older PPC Macs running 10.5 Leopard or 10.4 Tiger (not tested) via [Tigerbrew](https://github.com/mistydemeo/tigerbrew), [fuse-exfat](https://github.com/relan/exfat), and [Fuse for macOS](https://osxfuse.github.io/). 

Fuse for macOS requires Terminal commands to mount and eject exFAT drives, they won't automatically appear in the Finder when you first connect your exFAT drive.

## What's in the box
After installation, you'll get a number of command line utilities that enable you to work with exFAT formatted drives using UNIX `mount` commands. However, you *won't* get full automatic Finder support for exFAT drives, your Leopard or Tiger Mac will still complain that it can't understand an exFAT drive when it's first connected. After mounting the exFAT drive with these command line tools, you'll be able to see the drive in the Finder and interact with it normally.

Command-line utilities included:
* mount.exfat
* fsck.exfat
* mkfs.exfat
* mkexfatfs
* exfatlabel
* dumpexfat

At the Terminal, run `mount.exfat` to see basic usage syntax, and see the [fuse-exfat project on GitHub](https://github.com/relan/exfat) for further information.

## Tigerbrew / Homebrew installation instructions
[Tigerbrew](https://github.com/mistydemeo/tigerbrew) is a version of the [Homebrew](https://brew.sh/) package manager for PowerPC Macs running OS X 10.5 Leopard or 10.4 Tiger. 

Homebrew, similar to [MacPorts](https://www.macports.org/), is a great way to add software to your Mac, particularly open source, command line, and developer tools. Especially for older PowerPC Macs, it can enable you to run more recent versions of today's software by compiling it yourself from the source code, even though most software is no longer offered with PowerPC support. It automates the process of compiling source code, making it easy for non-developers to use.

If you already have Tigerbrew / Homebrew installed, then:
1. Download [Fuse for macOS](https://osxfuse.github.io/) (for Leopard) and install with MacFUSE compatibility layer. On Tiger, try using [MacFUSE](https://code.google.com/archive/p/macfuse/downloads) instead (untested).
1. `brew tap daniel-toman/exfat`
1. `brew install --HEAD exfat`

Or install via URL (won't receive updates):
```
brew install --HEAD https://raw.githubusercontent.com/daniel-toman/homebrew-exfat/master/Formula/exfat.rb
```

## Complete installation guide (from scratch)
If you don't already have Homebrew / Tigerbrew installed on your Mac, here is a quick guide to all the necessary steps to enable exFAT support. It will take roughly an hour or two on a G4 to download and compile all the code needed.

1. Download and Install [XCode 3.1.4](https://download.developer.apple.com/Developer_Tools/xcode_3.1.4_developer_tools/xcode314_2809_developerdvd.dmg) (for Leopard) or [XCode 2.5](https://download.developer.apple.com/Developer_Tools/xcode_2.5_developer_tools/xcode25_8m2558_developerdvd.dmg) (for Tiger). *May not be strictly required, but helpful.*
1. Download [Fuse for macOS](https://osxfuse.github.io/) (for Leopard) and install with MacFUSE compatibility layer. On Tiger, try using [MacFUSE](https://code.google.com/archive/p/macfuse/downloads) instead (untested).
1. Install [Tigerbrew](https://github.com/mistydemeo/tigerbrew) following their instructions. 
	* **Tigerbrew installation command cheat sheet:**
	* `echo export PATH=/usr/local/sbin:/usr/local/bin:\$PATH >> ~/.bash_profile`
	* `ruby -e "$(curl -fsSkL raw.github.com/mistydemeo/tigerbrew/go/install)"`
	* `brew doctor` after installation. Note any warnings and address as needed.
	* `brew install curl` (if recommended by brew doctor)
	* `brew install git` (if recommended by brew doctor)
	* `brew update`
1. `brew tap daniel-toman/exfat` to add this repo
1. `brew install --HEAD exfat` to install fuse-exfat. You're done!

## Usage
1. Connect your exFAT-formatted drive. When Finder complains "The disk you inserted was not readable" click **Ignore.**
1. In Terminal, run `diskutil list` and note the IDENTIFIER of your exFAT drive partition. It might be incorrectly labeled as "Windows_NTFS" format. For example, my 32GB exFAT flash drive showed up like this:
	```
	/dev/disk3
	   #:                       TYPE NAME                    SIZE       IDENTIFIER
	   0:     FDisk_partition_scheme                        *29.2 Gi    disk3
	   1:               Windows_NTFS                         29.2 Gi    disk3s1
	```
1. Create a folder to serve as a mount point for this drive. For example a folder called "exfat" in your Home folder: `mkdir ~/exfat` (This only needs to be done once.)
1. To mount the exFAT partition into this folder, run `mount.exfat /dev/disk3s1 ~/exfat` (Note: you must refer to your specific exFAT partition (ie **/dev/disk3s1**), just **/dev/disk3** will not work.)
1. If all is working, that mount point (ie *~/exfat*) will become an alias to the drive, and it will appear as a network drive "OSXFUSE Volume 0" on the Desktop, and under **Go > Computer** in Finder.
1. To eject or unmount the drive, use the **umount** command, ie: `umount ~/exfat` The FUSE drive can't be ejected from the Finder.

After initial setup, whenever you connect an exFAT drive you'll just enter `mount.exfat /dev/disk3s1 ~/exfat` to mount the drive, and when you want to eject it later, enter `umount ~/exfat`. (Where /dev/disk3s1 is the name of your particular exFAT drive's partition.)

> Kudos to @gmerlino for the original (Mavericks-only) [exFAT Homebrew formula](https://github.com/gmerlino/homebrew-exfat), @relan for [exfat](https://github.com/relan/exfat), @mistydemeo for [Tigerbrew](https://github.com/mistydemeo/tigerbrew), @osxfuse for continuing to support [Fuse for macOS](https://github.com/osxfuse/osxfuse) on Leopard and PPC, and of course the creators of [Homebrew](https://brew.sh/), [MacFUSE](https://code.google.com/archive/p/macfuse/), and [FUSE](https://github.com/libfuse/libfuse).
