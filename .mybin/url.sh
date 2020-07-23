#!/bin/bash
#url
urlopenstack(){
openstack[0]="https://www.rdoproject.org/install/packstack/"
openstack[1]="https://baijiahao.baidu.com/s?id=1617520630408423500&wfr=spider&for=pc%20in%205%20mins"
name[1]="官方"
name[2]="百家号"
lengh=${#name[*]}
lengh2="[1-${#name[*]}]"

for ((i=1; i<=$lengh; i=i+1));do
    echo -e "[\033[33m$i\033[0m] ${name[$i]}"
done
read -p "输入0则全部打开，输入编号则打开对应网址: " n
if [ $n == "0" ]; then
    for ((i=0; i<$lengh; i=i+1));do
        xdg-open "${openstack[$i]}" &> /dev/null
    done
elif [[ $n =~ $lengh2 ]]; then
    xdg-open "${openstack[$n-1]}" &> /dev/null
else
    echo -e "[\033[31m ERROR \033[0m请输入0到$lengh的编号"
    return 1
fi
}

urlbash(){
bash[0]="https://wangdoc.com/bash/intro.html"
bash[1]="https://developer.ibm.com/zh/tutorials/l-lpic1-map/"

name[1]="ruanyif"
name[2]="IBM"
lengh=${#name[*]}
lengh2="[1-${#name[*]}]"

for ((i=1; i<=$lengh; i=i+1));do
    echo -e "[\033[33m$i\033[0m] ${name[$i]}"
done
read -p "输入0则全部打开，输入编号则打开对应网址: " n
if [ $n == "0" ]; then
    for ((i=0; i<$lengh; i=i+1));do
        xdg-open "${bash[$i]}" &> /dev/null
    done
elif [[ $n =~ $lengh2 ]]; then
    xdg-open "${bash[$n-1]}" &> /dev/null
else
    echo -e "[\033[31m ERROR \033[0m请输入0到$lengh的编号"
    return 1
fi
}

ohmyfish="https://linux.cn/article-9515-1.html?pr"
ranger="http://ranger.github.io/"
fzf="https://github.com/junegunn/fzf"
zyplay="https://github.com/Hunlongyu/ZY-Player"
miniet="https://developer.ibm.com/zh/articles/1404-luojun-sdnmininet/"
termux="https://www.sqlsec.com/2018/05/termux.html"
case $1 in
    fzf ) xdg-open "$fzf" &> /dev/null;;
    minnet ) xdg-open "$minnet" &> /dev/null;;
    zyplay ) xdg-open "$zyplay" &> /dev/null;;
    ranger ) xdg-open "$ranger" &> /dev/null;;
    ohmyfish ) xdg-open "$ohmyfish" &> /dev/null;;
    termux ) xdg-open "$termux" &> /dev/null;;

    bash ) urlbash;;
    openstack ) urlopenstack;;
    * ) echo -e "\033[31m ERROR \033[0m$1还没有收录"
esac
