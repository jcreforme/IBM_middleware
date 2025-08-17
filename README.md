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
    subgraph Docker Network [ace-mq-network]
        ACE[IBM ACE v12 Container]
        MQ[IBM MQ v9.4.0.11 Container]
        DB[(ODBC/JDBC Database)]
        Kafka[(Apache Kafka)]
        SFTP[(SFTP Server)]
    end

    Client[External Client / REST API Consumer] --> ACE
    ACE --> MQ
    ACE --> DB
    ACE --> Kafka
    ACE --> SFTP
    MQ --> ACE
    Kafka --> ACE


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
🔹 Design and develop integration flows using IBM ACE v12 (ESQL and Java).
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

