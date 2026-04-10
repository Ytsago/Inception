# Developer Documentation: Inception Infrastructure

[cite_start]This documentation is designed for developers to understand the internal architecture, build process, and management of the Inception infrastructure[cite: 10, 42].

---

## 1. Environment Setup

### Prerequisites
* [cite_start]**Operating System**: A Linux-based environment (Debian 12 is used for container bases)[cite: 72, 73].
* [cite_start]**Docker & Docker Compose**: Must be installed on the host machine[cite: 11, 43].
* [cite_start]**Sudo Privileges**: Required to manage Docker resources and directory permissions[cite: 12, 44].

### Configuration & Secrets
[cite_start]The project uses **Environment Variables** for configuration and **Secrets** for sensitive data[cite: 19, 51].
* [cite_start]**File**: A `.env` file must be located in the parent directory of the `srcs` folder[cite: 20, 52].
* [cite_start]**Contents**: Must define variables for `DB_NAME`, `DB_USER`, `DB_PASS`, `DB_HOST`, and various WordPress credentials (`WP_ADMIN`, `WP_USER`, etc.)[cite: 66, 67, 71].

### Directory Structure
Before building, the project requires a specific directory structure on the host for persistent data:
* [cite_start]`/home/secros/data/db`: For MariaDB relational data[cite: 69, 72].
* [cite_start]`/home/secros/data/web`: For WordPress files and the static website[cite: 69, 72].

---

## 2. Build and Launch
[cite_start]The project is orchestrated using a **Makefile** that targets specific Docker Compose files located in `./srcs/`[cite: 1, 33].

### Standard Execution
* [cite_start]**Build and Start**: Run `make` or `make all`[cite: 1, 33]. [cite_start]This executes `set_dir` to create local paths, followed by `docker compose build` and `up -d`[cite: 2, 34].
* [cite_start]**Force Rebuild**: Run `make re` to perform a full clean and fresh build[cite: 14, 46].

### Bonus Services
[cite_start]The infrastructure supports an extended stack (Redis, Adminer, FTP, Static Site)[cite: 68].
* [cite_start]**Build Bonus**: `make build_bonus`[cite: 3, 35].
* [cite_start]**Launch Bonus**: `make bonus`[cite: 3, 35].

---

## 3. Container & Volume Management
Developers can interact with the running environment using integrated Makefile rules:

* [cite_start]**Monitoring**: `make status` displays all active images, containers, and volumes[cite: 5, 37].
* [cite_start]**Debugging**: Use `make shell DOCK=<container_name>` to open a bash/sh session inside a specific service[cite: 14, 46].
* [cite_start]**Logs**: Use `make logs DOCK=<container_name>` to troubleshoot service-specific initialization scripts[cite: 14, 46].
* **Cleanup**: 
    * [cite_start]`make clean`: Removes containers and images[cite: 6, 38].
    * [cite_start]`make vclean`: Removes Docker volumes and deletes physical data from `/home/secros/data/`[cite: 8, 40].
    * [cite_start]`make cclean`: Prunes the Docker builder cache to free up disk space[cite: 9, 41].

---

## 4. Data Persistence & Networking

### Storage Strategy
[cite_start]The project utilizes **Docker Volumes** with the `local` driver and `bind` options[cite: 29, 61, 62]. This links internal container paths to the host's physical storage:
* [cite_start]**MariaDB**: Internally `/var/lib/mysql` maps to the host's `db` directory[cite: 66, 70].
* [cite_start]**WordPress**: Internally `/var/www/html` maps to the host's `web` directory[cite: 67, 71].

### Network Isolation
[cite_start]All services communicate over a private bridge network named **Inception**[cite: 24, 56, 69].
* [cite_start]**Internal Communication**: Services like WordPress and Adminer connect to MariaDB via the internal network using the container name as the hostname[cite: 27, 59, 137].
* [cite_start]**External Exposure**: Only the **Nginx** container exposes a port to the host (Port **4242** mapped to **443**)[cite: 27, 59, 66]. [cite_start]All other services remain unreachable from outside the Docker network for security[cite: 26, 58].
