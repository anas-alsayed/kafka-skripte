#!/bin/bash
#----------------------------------------------------------------------------------
# File	      : broker-konfiguration.sh.sh
# Version     : 1.0.0.0
# Author      : Anas Al Sayed
# Zweck       : Dieses Skript lise die Konfigurationen aus einer CSV Datei und erstellt die *.properties Dateien für die Brokers.
# erstellt    : 15/05/2019                                       
#set -x
#------------------------------------------------------------------------------------

#Konfigurationadatei über Parameter
file=$1
#Zähler für die While Schleife
zeile=0

#Funktion wird unten gerufen und Parameter übergeben
function konfiguration_Borker()
{
	#Kafka Konfigurationsdateien
	cd /home/r00t/Desktop/kafka/etc/kafka
	#kopiere die Properties Datei mit neuem Namen (Parameter)
	cp server.properties 																														server-${b_name}.properties
	#Mit dem SED(Stream EDitor) werden bestimmte konfigurationen in der Propertiesdatei gesucht und entsprechend den Übergabeparametern geändert.
  	sed -i 	's/broker.id=0/broker.id='${b_id}'/g' 																								server-${b_name}.properties
	sed -i 	's/#listeners/listeners/g' 																											server-${b_name}.properties
	sed -i  '31s/9092/'${port}'/g' 																												server-${b_name}.properties
	
	sed -i  's/tmp\/kafka-logs/var\/kafka\/data1\/'${b_name}',\/var\/kafka\/data2\/'${b_name}',\/var\/kafka\/data3\/'${b_name}',\/var\/kafka\/data4\/'${b_name}',\/var\/kafka\/data5\/'${b_name}'/g' server-${b_name}.properties
	sed -i  's/num.partitions=1/num.partitions='${num_Partition}'/g' 																			server-${b_name}.properties
	sed -i 	'/group.initial.rebalance.delay.ms=0/a '${leader_rebalance}''																		server-${b_name}.properties
	sed -i  's/num.recovery.threads.per.data.dir=1/num.recovery.threads.per.data.dir='${recovery_thread}'/g' 									server-${b_name}.properties
	sed -i  's/offsets.topic.replication.factor=1/offsets.topic.replication.factor='${off_rep_fa}'/g' 											server-${b_name}.properties
	sed -i  's/transaction.state.log.replication.factor=1/transaction.state.log.replication.factor='${log_rep_fa}'/g' 							server-${b_name}.properties
	sed -i  's/zookeeper.connect=localhost:2181/zookeeper.connect='${zookeeper}'/g' 															server-${b_name}.properties
	sed -i  's/#metric.reporters=io.confluent.metrics.reporter.ConfluentMetricsReporter/'${metrics_repo}'/g' 									server-${b_name}.properties
	sed -i  's/#confluent.metrics.reporter.bootstrap.servers=localhost:9092/confluent.metrics.reporter.bootstrap.servers='${repo_server}'/g' 	server-${b_name}.properties
}
#Prüfe ob der Parameter einen Wert hat (CSV-Datei).
if [ -z $1 ]
then	
	echo "Verwendung: [Broker-Konfiguration.sh] [*.csv]"
	echo "Beispiel: Broker-Konfiguration.sh bk-Konfigurationen"
exit
else
#Mit while werden die Konfigurationen aus der CSV-Datei gelesen und in Variablen gespeichert.
while IFS=';' read b_name b_id port num_Partition leader_rebalance recovery_thread off_rep_fa log_rep_fa zookeeper metrics_repo repo_server
do
	#hier wird ab der ersten Zeile gelesen. 
	if [ $zeile -gt 0 ]
	then
	#Parameter werden der Funktion "konfiguration_Borker" übergeben
	konfiguration_Borker $b_name $b_id $port $num_Partition $recovery_thread $off_rep_fa $log_rep_fa $zookeeper $metrics_repo $repo_server
	echo -ne '#######################   (100%)' $b_name
	sleep 1
	echo -ne '\n'
	fi
	#Der Wert mit 1 erhöhen. 
	zeile=$(($zeile +1))

done < $file
echo 
echo "Broker Properties Dateien wurden erstellt und konfiguriert.."

fi
