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

## Verify that both ACE and MQ are running:
- ACE: Accessible on ports 7600 and 7800.
- MQ: Accessible on ports 1414 and 9443.

## Configuration
- ACE Configuration: The server.conf.yaml file configures the ACE integration server to connect to the MQ queue manager.
- MQ Configuration: The MQ container uses the default queue manager QM1.


## Networking
Both containers are connected via a Docker network (ace-mq-network) to allow communication between ACE and MQ.

## Stopping the Environment
To stop and remove the containers, run:
```bash
docker-compose down
```

## License
Ensure you accept the IBM license agreements for both ACE and MQ before using this setup.

