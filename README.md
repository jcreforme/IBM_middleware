# IBM ACE and MQ Docker Setup

This project sets up a Docker environment with IBM App Connect Enterprise (ACE) and IBM MQ using Docker Compose.

## Project Structure
project-root/
├── Dockerfile.ace          # Dockerfile for IBM ACE
├── Dockerfile.mq           # Dockerfile for IBM MQ
├── server.conf.yaml        # Configuration file for IBM ACE
├── docker-compose.yml      # Docker Compose file to orchestrate ACE and MQ
└── README.md               # Documentation for the project


## Prerequisites

- Docker installed on your system
- Docker Compose installed
- IBM ACE and MQ Docker images available (e.g., `ibmcom/ace:latest` and `ibmcom/mq:latest`)

## Setup Instructions

1. Clone this repository or copy the files into a directory.
2. Build the Docker images:
   ```bash
   docker-compose build


## Start the COntainer
```bash
docker-compose up
```
## Diagram
flowchart LR
    subgraph ace-mq-network
        ACE[IBM ACE v12 Container]
        MQ[IBM MQ v9.4.0.11 Container]
        Kafka[Apache Kafka Container]
        ZK[Zookeeper]
        DB[(ODBC/JDBC Database)]
        SFTP[(SFTP Server)]
    end

    Client[External Client / REST API Consumer] --> ACE
    ACE --> MQ
    ACE --> DB
    ACE --> Kafka
    ACE --> SFTP
    MQ --> ACE
    Kafka --> ACE
    Kafka --> ZK

🧩 Kafka Integration
🔹 KafkaInput/KafkaOutput nodes in ACE allow real-time streaming integration.
🔹 Kafka is orchestrated with Zookeeper and exposed on port 9092.
🔹 ACE connects to Kafka internally via PLAINTEXT://kafka:9092.

Topics, partitions, and consumer groups can be managed via CLI or ACE configuration.

## Verify that both ACE and MQ are running:
- ACE: Accessible on ports 7600 and 7800.
- MQ: Accessible on ports 1414 and 9443.

## Configuration
- ACE Configuration: The server.conf.yaml file configures the ACE integration server to connect to the MQ queue manager.
- MQ Configuration: The MQ container uses the default queue manager QM1.


## Networking
Both containers are connected via a Docker network (ace-mq-network) to allow communication between ACE and MQ.



## ✅ Prerequisites

- Docker & Docker Compose installed
- IBM ACE and MQ Docker images available:
  - `ibmcom/ace:latest`
  - `ibmcom/mq:latest`


## ⚙️ Setup Instructions

1. Clone this repository or copy the files into a working directory.
2. Build the Docker images:
   ```bash
   docker-compose build
  ```

## Start the Project   
 ```bash
 ```


docker-compose up
## Stopping the Environment
To stop and remove the containers, run:
```bash
docker-compose down
```

## using another mq-container-name
```bash
docker run -d \
  --name mq-container-new \
  -e LICENSE=accept \
  -e MQ_QMGR_NAME=QM2 \
  -p 1415:1414 \
  -p 9444:9443 \
  ibmcom/mq:latest
```

## Purpose of the Project
🔹 Design and develop integration flows using IBM ACE v12 (ESQL and Java). DONE
🔹 Configure connections to external systems via ODBC, JDBC, Kafka, and SFTP.
🔹 Deploy and manage flows in development and production environments using CLI (mqsi) and web console.*
🔹 Administer messaging platforms such as IBM MQ (v9.4.0.11) and Kafka (topics, partitions, consumers).
🔹 Install patches and manage security certificates in ACE, Kafka, and other platforms.
🔹 Monitor the performance of integration systems and apply proactive adjustments.
🔹 onduct functional testing and provide technical support to developers and users.
🔹 Document developed flows, configurations, and integration processes.
🔹 Automate deployments and configurations in enterprise environments.
🔹 Diagnose and resolve incidents in production environments.


## License
Ensure you accept the IBM license agreements for both ACE and MQ before using this setup.

## Author
Juan Carlo Reforme Sueyoshi
Specializing in secure, scalable integrations with WordPress, REST APIs, and enterprise middleware.


## FI Docker Compose version v1.29.2, build 5becea4c
command: docker-compose *

## IF Docker compose V2.39.*
command: docker compose *


## using verbose on the start
docker-compose --verbose up --build --force-recreate


## Check if ACE is running properly
- docker exec -u 0 -it ace-container bash
- source /opt/ibm/ace-11/server/bin/mqsiprofile
- mqsilist

## Check MyApp exists
[aceuser@96bbbbd9d554 ~]$ ls -l /home/aceuser/ace-server/run/
total 4
drwxrwx--- 3 aceuser aceuser 4096 Aug 18 00:00 MyIntegrationApp

## Test MyApp is runing
curl -X POST http://localhost:7800/myFlow -d '{"key":"value"}' -H "Content-Type: application/json"
{"message":"Hello from ESQL!"}juans-MacBook-Pro:IBM_middleware jcarlo$ 



## for local environment
- install mysql connector locally:
brew install mysql-connector-c++ --verbose
brew install unixodbc --verbose 
brew install mysql-client --verbose 

brew list mysql-client

mqsireportdbparms -w /home/aceuser/ace-server


docker cp odbc.ini ace-container:/etc/odbc.ini

docker cp mysql-connector-odbc-9.4.0-linux-glibc2.28-x86-64bit/lib/libmyodbc9a.so ace-container:/tmp/mysql-connector-odbc-9.4.0-linux-glibc2.28-x86-64bit/lib/

cat /etc/os-release

https://www.ibm.com/resources/mrs/assets/DownloadList?source=swg-wmbfd&lang=en_US

## Restart ALL
docker compose down -v
docker compose up -d --build

### ACE CONTANER RESTART
docker stop ace-container
docker rm -f ace-container
docker build -t ace-container -f Dockerfile.ace .
docker run --name ace-container -p 7600:7600 -p 7800:7800 -d ace-container


docker exec -u 0 -it ace-container bash


### ACE Server restart
kill -9 $(pgrep IntegrationServer)
rm -f /home/aceuser/ace-server/config/components/integration_server/servers/*/.lock
rm -rf /home/aceuser/ace-server/run/*
exec /opt/ibm/ace-11/server/bin/IntegrationServer --work-dir /home/aceuser/ace-server/


### Check DB connector
export ODBCINI=/etc/odbc.ini
export ODBCSYSINI=/etc
mqsicvp -n MySQLDatabaseCredentials -u root -p root


## Database configuration
bash
docker exec -it mysql-db mysql -u root -p
Then in the MySQL shell:

sql
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
FLUSH PRIVILEGES;
If you're using aceuser for your flows, also run:

sql
ALTER USER 'aceuser'@'%' IDENTIFIED WITH mysql_native_password BY 'acepass';
FLUSH PRIVILEGES;


/home/aceuser/ace-server/
├── bars/                          # BAR files to deploy
│   ├── MyBar.bar
│   └── MyIntegrationApp.bar
│
├── configuration/                # ACE runtime configuration
│   ├── policies/
│   │   └── JDBCProviders/
│   │       └── MySQLPolicy.policyxml
│   └── odbc.ini                  # Optional: override system-wide ODBC config
│
├── shared-classes/              # JDBC drivers and shared libraries
│   └── mysql-connector-j-9.4.0.jar
│
└── server.conf.yaml             # ACE server configuration
