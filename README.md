---
# Docker Cheat Sheet & Quick Reference

## Table of Contents
1. [What is Docker?](#what-is-docker)
2. [Docker Architecture](#docker-architecture)
3. [Docker Workflow](#docker-workflow)
4. [Essential Docker Commands](#essential-docker-commands)
5. [Docker Networking](#docker-networking)
6. [Common Scenarios](#common-scenarios)

---

## 🐳 What is Docker?
Docker is a platform for building, shipping, and running applications inside containers. Containers are lightweight, portable, and efficient, sharing the host OS kernel.

---

## Docker Architecture

### 1. Docker Engine
* Core part of Docker enabling containerization
   * **Docker Daemon (`dockerd`)**: Manages images, containers, volumes, networks
   * **containerd**: Container runtime used by Docker daemon

### 2. Docker CLI
* Command-line interface to interact with Docker
* Sends commands to Docker daemon

### 3. Docker Client
* CLI or API interface for users
* Communicates with `dockerd`

---

## Docker Workflow

```text
Dockerfile → Image → Container
```

1. **Dockerfile**: Instructions to build a Docker image (`FROM`, `RUN`, `COPY`, `CMD`, etc.)
2. **Image**: Read-only template with app code, runtime, dependencies
3. **Container**: Executable package with everything needed to run the software

---

## Essential Docker Commands

### System Setup
```bash
whoami                       # Show current user
docker ps                    # List running containers
sudo systemctl status docker # Check Docker service status
sudo usermod -aG docker $USER # Add user to Docker group
newgrp docker                # Refresh group membership
```

### Login & Pull Image
```bash
docker login                 # Authenticate with Docker Hub
docker pull mysql            # Pull MySQL image
docker images                # List local images
docker ps                    # List running containers
```

### Run MySQL Container
```bash
docker run -e MYSQL_ROOT_PASSWORD=root mysql
# -e sets environment variable
# MYSQL_ROOT_PASSWORD=root sets MySQL root password
```

### Access Running Container
```bash
docker ps                            # Get container ID
docker exec -it <container-id> bash  # Open bash inside container
```
Inside container:
```bash
mysql -u root -p                     # Log into MySQL
# Password: root
```

### Stop a Container
```bash
docker stop <container-id>
```

### Build & Run Custom Docker Image
```bash
docker build -t dotnet-app .         # Build image from Dockerfile
docker images                        # Verify image exists
docker run dotnet-app                # Run the container
```

### Logs & Monitoring
```bash
docker logs <container-id>           # View container logs
docker attach <container-id>         # Attach terminal to running container
```

---

## Docker Networking

### Network Types
* **Host**: Shares host network (e.g., `80:80`)
* **Bridge (Default)**: Container-to-container communication on same bridge
* **User-defined Bridge**: Custom, secure, recommended for multi-container apps
* **None**: Disables networking
* **MACVLAN**: Assigns MAC address, appears as physical device
* **IPVLAN**: Assigns IP from host network
* **Overlay**: Multi-host networking

### Network Commands
```bash
docker network create -d bridge <network_name> # Create custom bridge network
docker network ls                             # List all networks
```

---

## Common Scenarios

### Run SQL Server Container
```bash
docker run -d --name sqlserver2022 --network <network_name> \
   -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Your@StrongPassword" \
   mcr.microsoft.com/mssql/server:2022-latest
```

### Connect to SQL Server Inside Container
```bash
docker exec -it sqlserver2022 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Your@StrongPassword'
```

### Build a Docker Image
```bash
docker build -t <application_name>:<tag_name> .
```

### Run an Application Container
```bash
docker run -d -p <port_number>:<port_number> --network <network_name> <application_name>:<tag_name>
```
## 📦 Docker Volumes & Storage

Manage persistent storage in Docker using volumes.

---

### 🔍 Volume Commands

```bash
docker volume ls
```
> List all Docker volumes.

```bash
docker volume create <volume_name>
```
> Create a new volume.

```bash
docker volume inspect <volume_name>
```
> View detailed info about a volume (e.g., MountPoint).

---

### 📦 MountPoint

To find the **MountPoint** (where the volume is stored on the host), inspect the volume:

```bash
docker volume inspect <volume_name>
```

Look for the `"Mountpoint"` field in the output.

---

### 🧼 Container Cleanup

```bash
docker ps
```
> Show running containers.

```bash
docker stop <container_id> && docker rm <container_id>
```
> Stop and remove a container.

---

### 🐳 Run SQL Server with Volume

```bash
docker run -d \
   --name sqlserver2022 \
   --network <network_name> \
   -v <volume_name>:/var/opt/mssql \
   -e "ACCEPT_EULA=Y" \
   -e "MSSQL_SA_PASSWORD=Your@StrongPassword" \
   mcr.microsoft.com/mssql/server:2022-latest
```
> Run SQL Server 2022 in a container with volume for persistent storage.
