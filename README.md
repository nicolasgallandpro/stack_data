# Goal
The goal of this project is to help mounting a data stack with :
- Apache Airflow
- Apache Druid
- A python 3 install with pandas / scikit / numpy / ... 
- Jupyter 
- Apache Zeppelin (an alternative to Jupyter)
- Dataiku dss (a Tableau alternative)
- Apache superset

Airflow, Jupyter and Zeppelin are installed in the same container (in order to share python libs easily)

Each other tool is installed in his own container

The containers share a volumne (shared_volume/) and a local network. Each container has a simple host name in this container (druid, superset, ...) to make it easy to communicate between containers.

Critical directories of each tools are stored in a docker volume in order to persist data when containers are destructed.

You can find more informations in the docker-compose.yml files.

If you want to enter into one of this docker container's shell, use the `ssh.sh`script.


# Step 1 : create shared volume and network
Before launching docker-compose up on each container you want, you should execute create_network_and_shared_volume.sh

# Step 2 : docker-compose 
Execute: `docker-compose up & ` for each container you want to use

# Step 3 : get the Jupyter token
First time you connect to jupyter, it will ask for a token. You can get the token by executing `jupyter_token.sh`

# Step 4 : Inject sample data into Druid (wikipedia comments)
More informations here : https://druid.apache.org/docs/latest/tutorials/index.html

# Step 5 : Superset init
There is no default user in superset. To create the first user, execute this script : `superset_init.sh`

# Step 6 : Connect Superset to Druid
In this install, Superset and Druid share the same network, and the hostname of druid is "druid". 
So, if you want to connect Superset to Druid, define a Druid Cluster in the superset UI : 
Verbose name : druid_local
Coordinator Host : druid
Coordinator Port : 8081
Coordinator Endpoint : druid/coordinator/v1/metadata
Broker Host : druid
Broker Port : 8082
Broker Endpoint : druid/v2



Have fun :)