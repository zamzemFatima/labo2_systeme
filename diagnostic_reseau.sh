#!/bin/bash

echo "information systeme"
echo"------------------------"
echo " Nom de l'hote : $(hostname)"
echo " Date et heure : $(date)"
echo "version de systeme : $(uname -a)
echo ""

echo "configuration reseaux"

IP_LOCAL=$(hostname -I | awk '{print $1}')
echo " Adresse IP locale :$IP_LOCAL"

PASSSERELLE=$(ip route | grep default | awk '{print$3}')
echo "





