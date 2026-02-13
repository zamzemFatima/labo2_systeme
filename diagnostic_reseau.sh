#!/bin/bash

echo "information systeme"
echo " Nom de l'hote : $(hostname)"
echo " Date et heure : $(date)"
echo "version de systeme : $(uname -a)"
echo ""

echo "=== Configuration Reseau ==="

IP_LOCAL=$(hostname -I | awk '{print $1}')
echo " Adresse IP locale :$IP_LOCAL"

PASSERELLE=$(ip route | grep default | awk '{print$3}')
echo " passerelle : $PASSERELLE "


echo "serveurs DNS configure : "
grep nameserver /etc/resolv.conf
echo ""


echo "=== Test la Connectivite ==="

test_ping() {
    local cible=$1
    local description=$2
    ping -c 2 -w 2 "$cible" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "$description is accesible($cible)"
    else
        echo "$description est pas accesble ($cible)"
    fi
}

test_ping 127.0.0.1 "Localhost"
test_ping 127.0.0.1 "$PASSERELLE"

test_ping 8.8.8.8 "interne)"

DNS_TEST=$(ping -c 1 -w 2 google.com &> /dev/null 2>&1)
if [ $? -eq 0 ]; then 
    echo " dns fonctionne "
else 
    echo " ne fonctionne pas "
fi 
echo ""


echo "=== table ARP ==="
arp -n || echo "la table ne peux etre afficher"
echo ""


echo "=== resolution DNS ==="
grep nameserver /etc/resolv.conf
echo ""








