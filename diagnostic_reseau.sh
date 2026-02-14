#!/bin/bash
#Nom: Unaiza Ali Bhatti et Fatima Zamzam.
#ce script bash effectue ub dagnistic complet du reseau. Elle effiche les info ssteme et reseau, test la conectivite, la table ARP et effectue des resolutions DNS 
#afficher les info systems
echo "information systeme"
echo " Nom de l'hote : $(hostname)"
echo " Date et heure : $(date)"
echo "version de systeme : $(uname -a)"
echo ""

#afficher la confugiration reseau
echo "=== Configuration Reseau ==="

#adresse ip locale
IP_LOCAL=$(hostname -I | awk '{print $1}')
echo " Adresse IP locale :$IP_LOCAL"

#passerelle par defaut
PASSERELLE=$(ip route | grep default | awk '{print$3}')
echo " passerelle : $PASSERELLE "

#serveur DNS
echo "serveurs DNS configure : "
grep nameserver /etc/resolv.conf
echo ""


echo "=== Test la Connectivite ==="

#tester la connectivite
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

#test de localhost
test_ping 127.0.0.1 "Localhost"
#test de passerelle
test_ping 127.0.0.1 "$PASSERELLE"

#test de google
test_ping 8.8.8.8 "interne)"

#test de resolution DNS
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








