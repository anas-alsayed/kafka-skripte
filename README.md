# kafka-skripte

zookeeper-konfiguration.sh

Dieses skript hilft dabei, Properties-Datein für eine beliebige Anzahl von ZooKeeper zu erstellen.
Die Konfigurationen werden aus einer CSV-Datei gelsesen. Ein Muster CSV-Datei ist auch im Repository zu finden (zkeeper-Konfiguration.csv).


broker-konfiguration.sh

Dieses skript hilft dabei, Properties-Datein für eine beliebige Anzahl von Brokern zu erstellen.
Die Konfigurationen werden aus einer CSV-Datei gelsesen. Ein Muster CSV-Datei ist auch im Repository zu finden (Broker-Konfiguration.csv).

bk-start.sh

Siese skript startrt den Broker anhand von seinem Namen. Der Name wird aus der Properties-Datei entnommen.

bk-stop.sh

Siese skript stoppt den Broker anhand von seinem Namen. Der Name wird aus der Properties-Datei entnommen.

zk-start.sh	

Siese skript startet den ZooKeeper anhand von seinem Namen. Der Name wird aus der Properties-Datei entnommen.

zk-stop.sh	

Siese skript stoppt den ZooKeeper anhand von seinem Namen. Der Name wird aus der Properties-Datei entnommen.
