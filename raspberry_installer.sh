#!/bin/bash
# echo -n "Please enter a filename: "


read -p "Change the hostname: " tmpHN

if [ "$tmpHN" = "y" ];then
    read -p "Please give the hostname: " hostname_var
fi

read -p "add aliases and stuff: " tmpAlias
read -p "update, upgrade?: " tmpUpgrade
read -p "Fresh install (vim, tmux, kitty, git, ...): " tmpFresh
read -p "new ssh-key?: " tmpSsh
# read -p "install chezmoi (this needs ssh-key restart if not done): " tmpChezmoi
read -p "install k3s: " tmpk3s
if [ "$tmpk3s" = "y" ];then
    read -p "Is this the first server?: " tmpk3sFirstServer
    read -p "What is the token: " tmpk3sToken
    read -p "What is the loadbalancer dns name: " tmpk3sDnsName
    read -p "What is the loadbalancer ip: " tmpk3sLB_IP
    if [ "$tmpk3sFirstServer" = "y" ];then
        echo ""
    else
        read -p "What is the first server ip: " tmpk3sFS_IP
    fi
    
        
fi

# Run stuff
if [ "$tmpAlias" = "y" ];then
    echo "alias ll='ls -alFh'" >> ~/.bash_aliases;
    echo "alias la='ls -A'" >> ~/.bash_aliases;
    echo "alias l='ls -CF'" >> ~/.bash_aliases;
fi
if [ "$tmpHN" = "y" ];then
    # echo "sudo hostnamectl set-hostname $hostname_var --static;head -n -3 /etc/hosts > tmp.txt && mv tmp.txt /etc/hosts;echo '127.0.1.1	$hostname_var' >> /etc/hosts";
    sudo su root --session-command="sudo hostnamectl set-hostname $hostname_var --static;head -n -3 /etc/hosts > tmp.txt && mv tmp.txt /etc/hosts;echo '127.0.1.1	$hostname_var' >> /etc/hosts";
fi

if [ "$tmpUpgrade" = "y" ];then
    sudo apt update; sudo apt upgrade -y;
fi

if [ "$tmpFresh" = "y" ];then
    echo "fresh install ";
    sudo apt install -y vim kitty git tmux;
        
fi

if [ "$tmpSsh" = "y" ];then
    cd ~/.ssh;
    ssh-keygen -t ed25519;
fi

if [ "$tmpChezmoi" = "y" ];then
        
    echo "cp key to github: "
    cat .ssh/id_ed25519.pub;
    read -p "have cp key: " tmp
    sudo su root --session-command='cd /; sh -c "$(curl -fsLS chezmoi.io/get)"'

    chezmoi cd;
    chezmoi init git@github.com:/jarneamerlinck/dotconfig;
    git checkout --orphan common;rm *
fi


if [ "$tmpk3s" = "y" ];then
    cd ~;
    if [ "$tmpk3sFirstServer" = "y" ];then
        curl -sfL https://get.k3s.io | sh -s - server \
        --token=$tmpk3sToken \
        --tls-san $tmpk3sDnsName --tls-san $tmpk3sLBIP \
        --cluster-init
    else
        curl -sfL https://get.k3s.io | sh -s - server \
        --token=$tmpk3sToken \
        --tls-san $tmpk3sDnsName --tls-san $tmpk3sLB_IP \
        --server https://$tmpk3sFS_IP:6443
    
    fi
    sudo kubectl get nodes
        

fi

