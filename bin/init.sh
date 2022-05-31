#!/usr/bin/env bash

path_script="$(cd "$(dirname "$0")" && pwd)"

command -v virt-manager || sudo apt-get install -y virt-manager

virsh define "$path_script"/../docs/RDPWindows.xml
virsh autostart RDPWindows

# sudo sed -i 's/#user = "root"/user = '"\"$(id -un)\""'/g' /etc/libvirt/qemu.conf
# sudo sed -i 's/#group = "root"/group = '"\"$(id -gn)\""'/g' /etc/libvirt/qemu.conf
sudo usermod -a -G kvm "$(id -un)"
sudo usermod -a -G libvirt "$(id -un)"
sudo systemctl restart libvirtd
sudo ln -s /etc/apparmor.d/usr.sbin.libvirtd /etc/apparmor.d/disable/
# sudo reboot

# https://www.microsoft.com/en-us/software-download/windows10ISO
# echo "Download windows.iso"
# curl -LO https://software.download.prss.microsoft.com/pr/Win10_21H2_Chinese(Simplified)_x64.iso?t=ffd42f27-7d9b-4277-9786-65483cb1d0c1&e=1651293649&h=0ec86971df8e383322e7ba2026d2becd931ccd3b913f7b413bc0b8291d651f48
echo "Download virtio-win.iso..."
curl -LO https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
