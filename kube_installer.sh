#!/bin/bash
# echo -n "Please enter a filename: "


read -p "Install kube " tmpKube

if [ "$tmpKube" = "y" ];then
    read -p "Please give the hostname: " hostname_var
fi

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

