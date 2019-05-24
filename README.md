# kafka-skripte

# zookeeper-konfiguration.sh
Dieses skript hilft dabei, Properties-Datein für eine beliebige Anzahl von ZooKeeper zu erstellen.
Die Konfigurationen werden aus einer CSV-Datei gelsesen. Ein Muster CSV-Datei ist auch im Repository zu finden (zkeeper-Konfiguration.csv).<br/>
zum Beispiel: ./zookeeper-konfiguration.sh zkeeper-Konfiguration.csv


# broker-konfiguration.sh
Dieses skript hilft dabei, Properties-Datein für eine beliebige Anzahl von Brokern zu erstellen.
Die Konfigurationen werden aus einer CSV-Datei gelsesen. Ein Muster CSV-Datei ist auch im Repository zu finden (Broker-Konfiguration.csv).<br/>zum Beispiel:./broker-konfiguration.sh Broker-Konfiguration.csv

# zk-start.sh	
Das skript startet den ZooKeeper anhand von seinem Namen. Der Name wird als Parameter übergeben.<br/>
zum Beispiel : ./zk-start.sh brcl1z1

# zk-stop.sh	
Das skript stoppt den ZooKeeper anhand von seinem Namen. Der Name wird als Parameter übergeben.<br/>
zum Beispiel : ./zk-stop.sh brcl1z1

# bk-start.sh
Das skript startet den Broker anhand von seinem Namen. Der Name wird als Parameter übergeben.<br/>
zum Beispiel : ./bk-start.sh brcl1b1

# bk-stop.sh
Das skript stoppt den Broker anhand von seinem Namen. Der Name wird als Parameter übergeben.<br/>
zum Beispiel : ./bk-stop.sh brcl1b1


