#!/bin/bash
#----------------------------------------------------------------------------------
# File	      : zookeeper-konfiguration.sh
# Version     : 1.0.0.0
# Author      : Anas Al Sayed
# Zweck       : Mithilfe dieses Skript werden Konfigurationen aus einer CSV Datei gelesen und die *.properties Dateien für die ZooKeeper erstellt.
# erstellt    : 16/05/2019                                         
#set -x
#------------------------------------------------------------------------------------

#Konfigurationadatei über Parameter
file=$1
#Zähler für die While Schleife
zeile=0
#Funktion wird unten gerufen und Parameter übergeben
function Konfiguration_zookeeper()
{	
	cd /home/r00t/Desktop/kafka/etc/kafka
	cp zookeeper.properties  																					zookeeper-${z_name}.properties
	sed -i  "\$atickTime="${tickTime}																			zookeeper-${z_name}.properties
	sed -i  "\$a#the directory where the Data_Log is stored"													zookeeper-${z_name}.properties
  	sed -i  's/tmp\/zookeeper/var\/keeper\/data\/snapshots\/'${z_name}'/g'										zookeeper-${z_name}.properties
	sed -i  "\$adataLogDir=/var\/keeper\/data\/dataLog\/"${z_name} 												zookeeper-${z_name}.properties
	sed -i 	's/clientPort=2181/clientPort='${z_clientPort}'/g'													zookeeper-${z_name}.properties
	sed -i  "\$a# Zookeepers"																					zookeeper-${z_name}.properties
	sed -i 	"\$aserver.1="${zo1}																				zookeeper-${z_name}.properties
	sed -i 	"\$aserver.2="${zo2}																				zookeeper-${z_name}.properties
	sed -i 	"\$aserver.3="${zo3}																				zookeeper-${z_name}.properties
	sed -i  "\$a#how long following ZooKeeper servers can take to initialize with the current leader"			zookeeper-${z_name}.properties
	sed -i 	"\$a initLimit="${initLimit}																		zookeeper-${z_name}.properties
	sed -i  "\$a#how long they can be out of sync with the leader"												zookeeper-${z_name}.properties
	sed -i 	"\$asyncLimit="${syncLimit}																			zookeeper-${z_name}.properties
	sed -i  "\$a#Number of snapshots and the corresponding transaction logs to keepp.the rest will be deleted"	zookeeper-${z_name}.properties
	sed -i 	"\$aautopurge.snapRetainCount="${snapRetainCount}													zookeeper-${z_name}.properties
	sed -i  "\$a#The time interval in hours for which the purge task has to be triggered"						zookeeper-${z_name}.properties
	sed -i 	"\$aautopurge.purgeInterval="${purgeInterval} 														zookeeper-${z_name}.properties				

}
#Prüfe ob der Parameter einen Wert hat (CSV-Datei).
if [ -z $1 ]
then	
	echo "Verwendung: [zookeeper-Konfiguration.sh] [*.csv]"
	echo "Beispiel: zookeeper-Konfiguration.sh zk-Konfigurationen.csv"
exit
else
#Mit while werden die Konfigurationen aus der CSV-Datei gelesen und in Variablen gespeichert.	
while IFS=";" read z_name z_hosts z_clientPort z_leaderPort z_electionport tickTime initLimit syncLimit snapRetainCount purgeInterval
do
	if [ $zeile -gt 0 ] 
	then
		#Der Pfad, wo die PRopertiesdatei liegt
		cd /home/r00t/Desktop/Skripte-Projekt-Final
		#Suche in der CSV-Datei nach allen Hosts, desen Name mit z. B. "stg" anfängt.
		#Speichere in der Variable "Zookeepers" die Host-Namen und jeweils die Ports.
		#Danach trenne die Werte der Variable "Zookeepers" in ein Array
		Zookeepers=$(awk '$1 ~ /^'${z_name:0:3}'/ {split($0,a,";"); print a[2]":"a[4]":"a[5]}' $file)
		#Variable "Zookeepers" hat jetzt 3 Hosts jeweils mit seinen Ports.
		#In zo1 speichere den ertsten Host mit seien Ports.
		zo1=$(echo $Zookeepers | awk ' { print substr($1,0) }')
		zo2=$(echo $Zookeepers | awk ' { print substr($2,0) }')
		zo3=$(echo $Zookeepers | awk ' { print substr($3,0) }')
		Konfiguration_zookeeper $z_name $z_hosts $z_clientPort $zo1 $zo2 $zo3 $tickTime $initLimit $syncLimit $snapRetainCount $purgeInterval
		echo -ne '#######################   (100%)' $z_name
		sleep 1
		echo -ne '\n'
	fi
	zeile=$(($zeile + 1))
	sleep 1
done < $file		
fi
