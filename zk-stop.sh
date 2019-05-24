#!/bin/bash
#----------------------------------------------------------------------------------
# File		  : zk-stop.sh
# Version     : 1.0.0.0
# Author      : Anas Al Sayed
# Zweck       : ZooKeeper werden mithilfe dieses Skripts gestoppt
# erstellt    : 16/05/2019                                      
#set -x
#------------------------------------------------------------------------------------

#ZooKeeper-Name Parameter
z_name=$1

#Prüfe ob der Parameter einen Wert hat (ZooKeeper-Name).
if [ -z $z_name ]
then
	echo "Zookeeper-Name fehlt"
	echo "Beispiel: Zookeeper-stop.sh stgtcl1z1"
	exit
else

	echo $z_name 'wird gestoppt..'

	sleep 1
	#Prozess-ID des ZooKeepers wird gesucht und gestoppt.
	PIDS=$(ps -ef | grep -i $z_name | grep java | grep -v grep | awk '{print $2}')

	if [ -z "$PIDS" ]; then
	echo "kein Kafka ZooKeeper mit dem Namen ${z_name} zu stoppen..!"
		else
		kill -9 $PIDS
	fi
fi






