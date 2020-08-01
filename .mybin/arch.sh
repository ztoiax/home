archinstall(){
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
# 编辑/etc/locale.gen 然后移除需要的 地区 前的注释符号
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo "LC_ALL=en_US.utf-8" >> /etc/environment
pacman -Sy dhcpcd
pacman -Sy networkmanager
systemctl enable dhcpcd
systemctl enable NetworkManager
pacman -Sy zsh fish git wget bash-completion go base-devel
passwd
}

aur(){
# git clone https://aur.archlinux.org/aurman.git
# cd aurman
# makepkg -si
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
}

bspwm(){
mkdir ~/.config/bspwm
mkdir ~/.config/sxhkd
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
}

deepininstall(){
pacman -S deepin deepin-extra file-roller firefox
useradd -m -g wheel tz
passwd tz
# systemctl enable lightdm
}

ip(){
$ip='
interface=eth0\n
address=192.168.21.170\n
netmask=255.255.255.0\n
broadcast=192.168.21.255\n
gateway=192.168.21.2'
echo -e $ip >> /etc/rc.conf

$dns='
nameserver 8.8.8.8\n
nameserver 8.8.4.4'
echo -e $dns >> /etc/resolv.conf
}