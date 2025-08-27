🐳 What is Docker?

Docker is a platform that helps developers build, ship, and run applications inside containers.


# Docker Architecture

### 1. **Docker Engine**

* Core part of Docker that enables containerization.
* Includes:

  * **Docker Daemon (`dockerd`)**: Handles Docker objects (images, containers, volumes, networks).
  * **containerd**: Lightweight container runtime used by the Docker daemon.

### 2. **Docker CLI**

* Command-line interface to interact with Docker.
* Sends commands to the Docker daemon via the Docker client.

### 3. **Docker Client**

* Provides an interface (CLI or API) for users.
* Communicates with `dockerd`.

---

# Docker Services

### Docker Application Container Engine

* The full platform that enables developers to build, run, and share containerized applications.

---

# Docker Workflow

```text
Dockerfile → Image → Container
```

### 1. **Dockerfile**

* A text file with instructions to build a Docker image.
* Common instructions: `FROM`, `RUN`, `COPY`, `CMD`, etc.

### 2. **Image**

* A read-only template used to create containers.
* Contains application code + runtime + dependencies.

### 3. **Container**

* A container is a lightweight, standalone, and executable package that includes everything needed to run a piece of software — the code, runtime, libraries, and system tools.

* Think of it as a virtual machine, but much faster and more efficient because it shares the host system’s kernel rather than running its own OS.

---

# ✅ Docker Commands & Flow

### System Setup

```bash
whoami                       # Show current user
docker ps                    # List running containers
sudo systemctl status docker # Check Docker service status

# Add current user to Docker group (to run without sudo)
sudo usermod -aG docker $USER
newgrp docker                # Refresh group membership in current session
```

---

### Docker Login & Pull Image

```bash
docker login                 # Authenticate with Docker Hub
docker pull mysql            # Pull MySQL image
docker images                # List local images
docker ps                    # List running containers
```

---

### Run MySQL Container

```bash
docker run -e MYSQL_ROOT_PASSWORD=root mysql
```

* `-e`: Set environment variable
* `MYSQL_ROOT_PASSWORD=root`: Root password for MySQL

---

### Access Running Container

```bash
docker ps                            # Get container ID
docker exec -it <container-id> bash  # Open bash inside container
```

Inside the container:

```bash
mysql -u root -p                     # Log into MySQL
# Password: root
```

---

### Stop a Container

```bash
docker stop <container-id>
```

---

### Build & Run Custom Docker Image

```bash
docker build -t dotnet-app .         # Build image from Dockerfile in current directory
docker images                        # Verify image exists
docker ps                            # List running containers
docker run dotnet-app                # Run the container
```

---

### Logs, Attach, and Monitoring

```bash
docker logs <container-id>           # View container logs
docker attach <container-id>         # Attach terminal to running container
```

---
