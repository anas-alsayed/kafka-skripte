#!/bin/bash
#----------------------------------------------------------------------------------
# File	      : zk-start.sh
# Version     : 1.0.0.0
# Author      : Anas Al Sayed
# Zweck       : ZooKeeper werden mithilfe dieses Skripts gestartet
# erstellt    : 16/05/2019                                      
#set -x
#------------------------------------------------------------------------------------
#Zookeeper-Name Parameter
z_name=$1
#Die ID des ZooKeepers wird aus dem Namen entnommen.
myid=$1
#Prüfe ob der Parameter einen Wert hat (ZooKeeper-Name).
if [ -z $z_name ]
then
	echo "Zookeeper-Name fehlt"
	echo "Beispiel: Zookeeper-start.sh stgtcl1z1"
	exit
#Prüfe ob die Properties-Datei des ZooKeepers vorhanden ist.
elif [ ! -f  ${ZOO_HOME}/etc/kafka/zookeeper-${z_name}.properties ]
then
	
	echo "Properties Datei ist nicht vorhandend"
	exit
else
#LOG-Pfad setzen. Hier werden die Log-Datein gespeichert.
export LOG_DIR=${ZOO_LOG_DIR}/$z_name

echo 'Zookeeper Log_Dir gesetzt auf' $LOG_DIR

#erstelle unter "snapshots" einen Ordner mit dem Namen des ZooKeepers
mkdir -p ${ZOO_DATA_DIR}/snapshots/$z_name

cd ${ZOO_DATA_DIR}/snapshots/$z_name

#Nimm die letzte Zahl aus dem Name-Parameter und schreibe es in die Datei "myid"
echo $myid | awk '{print substr($0,length,1)}' > myid

echo $z_name 'wird gestartet..'
#Starte den gewählten ZooKeeper
${ZOO_HOME}/bin/zookeeper-server-start -daemon ${ZOO_HOME}/etc/kafka/zookeeper-${z_name}.properties

sleep 1
#Zeige die Prozess-ID des ZooKeepers
pid=`ps -ef | grep -i $z_name | grep -v $0 | grep -v grep | awk '{print $2}'`

       		if [ -n "$pid" ]
        	then
          	echo "Zookeeper Startet unter: $pid"
        	else
          	echo "Zookeeper wurde nicht gestartet"
        	fi
fi








