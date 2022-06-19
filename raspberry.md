# Raspberry

1. via imager username and ssh enablen
2. updaet
3. install vim, kitty, chezmoi (git and ssh key aanmaken)
4. 2FA
5. unattended upgrades




## 2FA for ssh

sudo apt install libpam-google-authenticator -y

auth required pam_google_authenticator.so # on end of /etc/pam.d/sshd
### on /etc/ssh/sshd_config
ChallengeResonseAuthentication yes 
AuthenticationMethods publickey,keyboard-interactive 
Port XXX # just no 22
PermitRootLogin no

### next
google-authenticator
sudo systemctl restart sshd


## bind
sudo apt install -y bind9 bind9utils bind9-doc dnsutils
named -v
cp files

fix for own machine still needed

## unattended upgrades

sudo apt-get install unattended-upgrades apt-listchanges -y

## Port forwarding for k8s
- DNAT

dIp-From dPort-From dIP-To dPort_to
- SNAT

sIp-From SPort-From sIp-To SPort-To
## Tmux


### Work
 
sudo iptables \
 --table nat \
 --append PREROUTING \
 --protocol tcp \
 --destination 192.168.222.146 \
 --dport 80 \
 --jump DNAT \
 --to-destination 192.168.222.249:8080;
 sudo iptables \
 --table nat \
 --append POSTROUTING \
 --protocol tcp \
 --destination 192.168.222.249 \
 --dport 8080 \
 --jump SNAT \
 --to-source 192.168.222.146;

 sudo iptables --table nat --list
 sudo apt-get install iptables-persistent
 sudo su --session-command='iptables-save > /etc/iptables/rules.v4'