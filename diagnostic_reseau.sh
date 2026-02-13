#!/bin/bash

echo "information systeme"
echo " Nom de l'hote : $(hostname)"
echo " Date et heure : $(date)"
echo "version de systeme : $(uname -a)"
echo ""

echo "configuration reseaux"

IP_LOCAL=$(hostname -I | awk '{print $1}')
echo " Adresse IP locale :$IP_LOCAL"

PASSERELLE=$(ip route | grep default | awk '{print$3}')
echo " passerelle : $PASSSERELLE "


echo "serveurs DNS configure : "
cat /etc/resolv.conf | grep nameserver
echo ""


echo " test la connectivite "

test_ping() {
local cible=$1
local description=$2
ping -c 2 -w 2 "$cible" &> dev/null
if [$? -eq 0 ]; then
    echo "$description is accesible($cible)"
else
    echo "$description est pas accesble ($cible)"
    fi
    }

test_ping 127.0.0.1 "$PASSSERELLE"

test_ping 8.8.8.8 "internet(8.8.8.8)"

DNS_TEST=$(ping -c 1 -w 2 google.com &> /dev/null)
if [ $? -eq 0 ]; then 
    echo " dns fonctionne "
else 
    echo " ne fonctionne pas "
fi 
    echo ""


echo " table ARP "

arp -n || echo "la table ne peux etre afficher"
echo ""


echo " resolution DNS "







