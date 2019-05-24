#!/bin/bash
#----------------------------------------------------------------------------------
# File        : bk-stop.sh
# Version     : 1.0.0.0
# Author      : Anas Al Sayed
# Zweck       : Broker werden mithilfe dieses Skripts gestoppt
# erstellt    : 16/05/2019                                     
# set -x
#------------------------------------------------------------------------------------

#Broker-Name Parameter
b_name=$1

#Prüfe ob der Parameter einen Wert hat (Broker-Name).
if [ -z $b_name ]
then
	echo "Broker-Name fehlt"
	echo "Beispiel: broker-stop.sh stgtcl1b1"
	exit
else

echo $b_name 'wird gestopt..'

sleep 1

#Prozess-ID des Brokers wird gesucht und gestoppt.
PIDS=$(ps -ef | grep -i $b_name | grep java | grep -v grep | awk '{print $2}')

if [ -z "$PIDS" ]; then
   echo "kein Kafka Broker mit dem Namen ${b_name} zu stoppen..!"
 else
    kill -9 $PIDS
fi
fi



