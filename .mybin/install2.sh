#!/bin/bash
# set -x
sshserver(){
if rpm -q openssh; then
    echo "ssh已安装,免密码正在安装"
else
    echo "正在安装ssh"
    $install install -y openssh
fi
echo "PermitRootLogin yes
StrictModes no
RSAAuthentication yes
PubkeyAuthentication yes
PasswordAuthentication no"

sed -i '/PubkeyAuthentication/cPubkeyAuthentication yes' /etc/ssh/sshd_config
sed -i '/PasswordAuthentication/cPasswordAuthentication no' /etc/ssh/sshd_config
sed -i "/^PermitRootLogin/cPermitRootLogin yes" /etc/ssh/sshd_config
sed -i '/RSAAuthentication/cRSAAuthentication yes' /etc/ssh/sshd_config
sed -i '/StrictModes/cStrictModes no' /etc/ssh/sshd_config
}
sshclient(){
    echo "ssh免密码登录正在安装"
    read -p "enter serverip: " serverip
    ssh-keygen -t rsa
    scp ~/.ssh/id_rsa.pub root@$serverip:/root/.ssh/authorized_keys
}
epelinstall(){
if rpm -q epel-release; then
    echo "epel已安装"
    return
fi
echo "正在安装epel"
yum install -y epel-release
mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup
mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup
curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
# yum clean all
# yum makecache
}

#extra
exinstall(){
$install install -y git wget make
$install install -y python2 python3

pip3 install ranger-fm
}
#fish
fishinstall(){
if rpm -q fish; then
    echo "fish已安装"
    return 1
fi
echo "正在安装fish"
cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/shells:fish:release:3/CentOS_8/shells:fish:release:3.repo
yum install -y fish
}
oh-my-fishinstall(){
    curl -L https://get.oh-my.fish | fish
}
fzfinstall(){
if type fzf; then
    echo "fzf已安装"
    return 1
fi
echo "正在安装fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
}

adbconnect(){
adb -s 192.168.1.111:5555 connect 192.168.1.111:5555
sleep 1
adb -s 192.168.1.111:5555 forward tcp:10808 tcp:10808
export ALL_PROXY=socks5://127.0.0.1:10808
export NO_PROXY="mirrors.aliyun.com,registry.npm.taobao.org,npm.taobao.org,docker.mirrors.ustc.edu.cn,mirrors.aliyuncs.com,mirrors.cloud.aliyuncs.com"
}

monitorinstall() {
#CPU
$install atop htop
$install netdata
}

if [ -f /usr/bin/lsb_release ]; then
    install="apt-get"
    check="dpkg -l"
elif [ -f /etc/redhat-release ];then
    install="yum"
    check="rpm -q"
elif uname -a | grep Android;then
    install="pkg"
    check="pkg show"
fi

for i in "$@"; do
    case $i in
        adb ) adbconnect;;
        fzf ) fzfinstall;;
        epel ) epelinstall;;
        fish ) fishinstall;;
        extra ) exinstall;;
        monitor ) monitorinstall;;
        sshserver ) sshserver;;
        sshclient ) sshclient;;
        openstack ) source openstack.sh && openstackinstall;;

        *config ) source config.sh && config.sh $i;;
        *source ) source source.sh && source.sh $i;;
        list ) set | grep "()";;
        * ) read -p "$i暂时没收录，是否使用$install安装:[y/n] " y
            if [ $y == y ]; then
                sudo $install install -y $i
            else
                exit 1
            fi
            ;;
    esac
done
