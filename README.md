# WinApps for Linux
Run Windows apps such as Microsoft Office in Linux (Ubuntu) and GNOME as if they were a part of the native OS, including Nautilus integration for right clicking on files of specific mime types to open them.

<img src="demo/demo.gif" width=1000>

## How it works and why WinApps exists
Back in April, Hayden Barnes [tweeted](https://twitter.com/unixterminal/status/1255919797692440578?lang=en) what appeared to be native Windows apps in a container or VM inside Ubuntu. However, no details have emerged on how this was accomplished, though it is likely a similar method to this but with an insider build Windows Container.

Rather than wait around for this, WinApps was created as an easy, one command way to include apps running inside a VM (or on any RDP server) directly into GNOME as if they were native applications. WinApps works by:
- Running a Windows RDP server in a background VM container
- Checking the RDP server for installed applications such as Microsoft Office
- If those programs are installed, it creates shortcuts leveraging FreeRDP for both the CLI and the GNOME tray
- Files in your home directory are accessible via the `\\tsclient\home` mount inside the VM
- You can right click on any files in your home directory to open with an application, too

## App support and "To Do"
Currently supported apps
- Microsoft Word
- Microsoft Excel
- Microsoft PowerPoint
- Internet Explorer (just because)

To Do
- Add additional app configurations (Outlook, OneNote, IE, Edge, Photoshop, Acrobat, etc)
- Subsystem support: Add a script to remove (and re-add) the Explorer shell and other non-required Windows features to minimize overhead
- Automate the Windows elements of the install

## Installation

### Creating your WinApps configuration file
You will need to create a `~/.config/winapps/winapps.conf` configuration file with the following information in it:
``` bash
RDP_USER="MyWindowsUser"
RDP_PASS="MyWindowsPassword"
#RDP_IP="192.168.123.111"
```
If you are using Option 2 below with a pre-existing non-KVM RDP server, you can use the `RDP_IP` to specify it's location. If you are running a VM in KVM with NAT enabled, leave `RDP_IP` commented out and WinApps will auto-detect the right local IP.

### Option 1 - Running KVM
You can refer to the [KVM](https://www.linux-kvm.org) documentation for specifics, but the first thing you need to do is set up a Virtual Machine running Windows 10 Professional (or any version that supports RDP). First, clone WinApps and install KVM and FreeRDP:
``` bash
git clone https://github.com/Fmstrat/winapps.git
cd winapps
sudo apt-get install -y virt-manager freerdp2-x11
```

Now set up KVM to run as your user instead of root and allow it through AppArmor (for Ubuntu 20.04 and above):
``` bash
sudo sed -i "s/#user = "root"/user = "$(id -un)"/g" /etc/libvirt/qemu.conf
sudo sed -i "s/#group = "root"/group = "$(id -gn)"/g" /etc/libvirt/qemu.conf
sudo usermod -a -G kvm $(id -un)
sudo usermod -a -G libvirt $(id -un)
sudo systemctl restart libvirtd
sudo ln -s /etc/apparmor.d/usr.sbin.libvirtd /etc/apparmor.d/disable/

sleep 5

sudo virsh net-autostart default
sudo virsh net-start default
```
**You will likely need to reboot to ensure your current shell is added to the group.**

Next, define a VM called RDPWindows from the sample XML file with:
``` bash
virsh define kvm/RDPWindows.xml
virsh autostart RDPWindows
```

You will now want to change any settings on the VM and install Windows and whatever programs you would like, such as Microsoft Office. You can access the VM with:
``` bash
virt-manager
```

After the install process, you will want to:
- Go to the Start Menu
    - Type "About"
    - Open "About"
    - Change the PC name to "RDPWindows" (This will allow WinApps to detect the local IP)
- Go to Control Panel
    - Under "System," allow remote connections for RDP
- Merge `kvm/RDPApps.reg` into the registry to enable RDP Applications

And the final step is to run the installer:
``` bash
$ ./install.sh
[sudo] password for fmstrat: 
Installing...
  Checking for installed apps in RDP machine...
  Checking for installed apps in RDP machine...
  Configuring Excel... Finished.
  Configuring PowerPoint... Finished.
  Configuring Word... Finished.
  Configuring Windows... Finished.
Installation complete.
```

### Option 2 - I already have an RDP server or VM
If you already have an RDP server or VM, using WinApps is very straight forward. Simply create your `~/.config/winapps/winapps.conf` configuration file, and run:
``` bash
$ git clone https://github.com/Fmstrat/winapps.git
$ cd winapps
$ sudo apt-get install -y freerdp2-x11
$ ./install.sh
[sudo] password for fmstrat: 
Installing...
  Checking for installed apps in RDP machine...
  Configuring Excel... Finished.
  Configuring PowerPoint... Finished.
  Configuring Word... Finished.
  Configuring Windows... Finished.
Installation complete.
```
You will need to make sure RDP Applications are enabled, which can be set by merging in `kvm/RDPApps.reg` into the registry.

### enable activex 

You first want to go into your vm. and do as followed:

press Win logo + R, type regedit.exe, press OK, go to ```HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office```, then press Edit on the top (header) > Find, type COM Compatibility, press OK, wait, open ```COM Compatibility folder```, look for ```8856F961-340A-11D0-A96B-00C04FD705A2``` and click it, then double click Compatibility Flags, type ```0``` and finally press OK

## Adding applications
Adding applications to the installer is easy. Simply copy one of the application configurations in the `apps` folder, and:
- Edit the variables for the application
- Replace the `icon.svg` with an SVG for the application
- Re-run the installer
- Submit a Pull Request to add it to WinApps officially

When running the installer, it will check for if any configured apps are installed, and if they are it will create the appropriate shortcuts on the host OS.
