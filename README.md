# ExFAT for Mac OS X 10.4 Tiger and 10.5 Leopard (via Homebrew and Fuse OS X)
This Homebrew formula enables `command line` ExFAT filesystem support on older PPC Macs running 10.5 Leopard or 10.4 Tiger (not tested) via [Tigerbrew](https://github.com/mistydemeo/tigerbrew), [fuse-exfat](https://github.com/relan/exfat), and [Fuse for macOS](https://osxfuse.github.io/). MacFUSE requires Terminal commands to mount and eject ExFAT drives, they won't automatically appear in the Finder.

## What's in the box
After installation, you'll get a number of command-line utilities that enable you to mount ExFAT formatted drives using UNIX `mount` commands. However, you *won't* get full automatic Finder support for ExFAT drives, your Leopard or Tiger Mac will still complain that it can't understand an ExFAT drive when it's first connected. After mounting the ExFAT drive with these command line tools, you'll be able to see the drive in the Finder and interact with it like normal.

Command-line utilities included:
* mount.exfat
* fsck.exfat
* mkfs.exfat
* mkexfatfs
* exfatlabel
* dumpexfat

At the Terminal, run `mount.exfat` with no options for usage syntax, and see the [exfat project on GitHub](https://github.com/relan/exfat) for further information.

## Tigerbrew/Homebrew installation instructions
If you already have Tigerbrew or Homebrew installed, then just run `brew tap daniel-toman/exfat` and then `brew install --HEAD exfat`.

Or install via URL (which will not receive updates):
```
brew install --HEAD https://raw.githubusercontent.com/daniel-toman/homebrew-exfat/master/exfat.rb
```

## Complete guide to adding ExFAT support to OS X 10.5 Leopard and 10.4 Tiger
1. Download and Install [XCode 3.1.4](https://download.developer.apple.com/Developer_Tools/xcode_3.1.4_developer_tools/xcode314_2809_developerdvd.dmg) (for Leopard) or [XCode 2.5](https://download.developer.apple.com/Developer_Tools/xcode_2.5_developer_tools/xcode25_8m2558_developerdvd.dmg) (for Tiger). I'm not sure if this is strictly required.
1. Download and install [Fuse for macOS](https://osxfuse.github.io/) (for Leopard) and choose MacFUSE compatibility layer. On Tiger, try using [MacFUSE](https://code.google.com/archive/p/macfuse/downloads).
1. Install [Tigerbrew](https://github.com/mistydemeo/tigerbrew) *quick install commands in Terminal:*
	1. `cat - >> ~/.bash_profile` (after hitting Return, it waits for user input, then enter the next item)
	1. `export PATH=/usr/local/sbin:/usr/local/bin:$PATH`
	1. `Ctrl+D` to save
	1. `ruby -e "$(curl -fsSkL raw.github.com/mistydemeo/tigerbrew/go/install)"` (press Return to accept & install)
	1. `brew doctor` after installation. Note any warnings and address as needed.
	1. `brew install curl` (if recommended by brew doctor)
	1. `brew install git` (if recommended by brew doctor)
	1. `brew update`
1. Add this repo: `brew tap daniel-toman/exfat`
1. Finally, install fuse-exfat: `brew install --HEAD exfat`

## Usage
1. Connect your ExFAT-formatted drive. Finder will complain "The disk you inserted was not readable" - click **Ignore.**
1. In Terminal, run `diskutil list` and note the name of the drive you inserted. It may be labeled as "Windows_NTFS" format. For example, my 32GB ExFAT flash drive appeared thus:
```
/dev/disk3
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *29.2 Gi    disk3
   1:               Windows_NTFS                         29.2 Gi    disk3s1
```
1. Create a folder to serve as a mount point for this drive. For example a folder called "exfat" in your Home folder: `mkdir ~/exfat`
1. Then mount the ExFAT partition into this folder, ie `mount.exfat /dev/disk3s1 ~/exfat` (Note: you must refer to the specific ExFAT partition (ie **/dev/disk3s1**), just **/dev/disk3** will not work.)
1. If all is working, the drive will then be aliased to the mount point (ie *~/exfat*) as well as appear as a network drive "OSXFUSE Volume 0" on the Desktop and under *Go > Computer* in Finder.
1. To eject or unmount the drive, use the **umount** command plus the drive name or mount point, ie: `umount ~/exfat` The FUSE drive can't be ejected from the Finder.

Kudos to @gmerlino for the original (Mavericks-only) [ExFAT Homebrew formula](https://github.com/gmerlino/homebrew-exfat), @relan for [exfat](https://github.com/relan/exfat), @mistydemeo for [Tigerbrew](https://github.com/mistydemeo/tigerbrew), @osxfuse for continuing to support Leopard and PPC, and of course the creators of [Homebrew](https://brew.sh/), [MacFUSE](https://code.google.com/archive/p/macfuse/), and [FUSE](https://github.com/libfuse/libfuse).
