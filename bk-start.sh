#!/bin/bash
#----------------------------------------------------------------------------------
# File	      : bk-start.sh
# Version     : 1.0.0.0
# Author      : Anas Al Sayed
# Zweck       : Broker werden mithilfe dieses Skripts gestartet
# erstellt    : 16/05/2019                                      
# set -x
#------------------------------------------------------------------------------------

#Broker-Name Parameter
b_name=$1

#Prüfe ob der Parameter einen Wert hat (Broker-Name)..
if [ -z $b_name ]
then
	echo "Broker-Name fehlt"
	echo "Beispiel: broker-start.sh stgtcl1b1"
	exit
#Prüfe ob die Properties-Datei des Brokers vorhanden ist.
elif [ ! -f  ${KAFKA_HOME}/etc/kafka/server-${b_name}.properties ]
then
	
	echo "Properties Datei ist nicht vorhandend"
	exit
else
#LOG-Pfad setzen. Hier werden die Log-Datein gespeichert.
export LOG_DIR=${KAFKA_LOG_DIR}/$b_name

echo 'Broker Log_Dir gesetzt auf' $LOG_DIR

echo $b_name'wird gestartet..'
#Starte den gewählten Broker
${KAFKA_HOME}/bin/kafka-server-start -daemon ${KAFKA_HOME}/etc/kafka/server-${b_name}.properties

sleep 1
#Zeige die Prozess-ID des Brokers
pid=`ps -ef | grep -i $b_name | grep -v $0 | grep -v grep | awk '{print $2}'`

       		if [ -n "$pid" ]
        	then
          	echo "Kafka Broker Startet unter: $pid"
        	else
          	echo "Kafka Broker wurde nicht gestartet"
        	fi
fi







