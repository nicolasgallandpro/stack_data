# 1. création du volume et du réseau partagé
avant de lancer les docker-compose, créez les volume et réseau nécessaires en executant ccreate_network_and_shared_volume.sh

# 2. docker-compose up &
pour chaque machine 

# 3. récupération du token jupyter 
Pour récupérer le token demandé dans l'ui, executer le script jupyter_token.sh

# 4. ajout de données de test dans Druid 
Pour remplir une datasource avec des données exemple (wikipedia) suivre : https://druid.apache.org/docs/latest/tutorials/index.html
( quickstart/tutorial/   wikiticker-2015-09-12-sampled.json.gz )

# 5. initialisation de Superset et connexion à Druid
Afin de pouvoir se connecter, il faut executer le script superset_init.sh

Pour connecter superset à druid : configurer un cluster druid tel que : 
Verbose name : druid_local
Coordinator Host : druid
Coordinator Port : 8081
Coordinator Endpoint : druid/coordinator/v1/metadata
Broker Host : druid
Broker Port : 8082
Broker Endpoint : druid/v2

# help
pour entrer dans le bash des conteneurs, utiliser la commande ssh.sh
airflow, jupyter, et zeppelin sont dans le même conteneur afin de partager la même install de python (python3)
