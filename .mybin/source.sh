#!/bin/bash
#源修改
pipsource(){
if [ ! -f ~/.pip/pip.conf ]; then
    echo "正在更换pip源"
    if [ ! -d ~/.pip ]; then
        mkdir ~/.pip
    fi
    aliyun='[global]
    trusted-host=mirrors.aliyun.com
    index-url=https://mirrors.aliyun.com/pypi/simple/'
    echo $aliyun > ~/.pip/pip.conf
fi
}
npmsource() {
    echo "正在更换npm源"
npm config set registry https://mirrors.huaweicloud.com/repository/
npm config set disturl https://repo.huaweicloud.com/nodejsnpm/
npm config set sass_binary_site https://repo.huaweicloud.com/n
npm config set phantomjs_cdnurl https://repo.huaweicloud.com/phantomjs
npm config set chromedriver_cdnurl https://repo.huaweicloud.com/chromedriver
npm config set operadriver_cdnurl https://repo.huaweicloud.com
npm config set electron_mirror https://repo.huaweicloud.com/electron/
npm config set python_mirror https://repo.huaweicloud.com/python /operadriverode-sass
}

debsource() {
    echo "正在更换ubuntu18.04源"
cp /etc/apt/sources.list sources.list.bak
sudo echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" > /etc/apt/sources.list 
}

case $1 in
    npm*) npmsource ;;
    pip*) pipsource ;;
    * ) echo "$i还有收录";;
esac
