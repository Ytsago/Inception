# User Documentation: Inception Web Stack

This document provides a clear guide for administrators and users to manage, access, and monitor the **Inception** project services.

---

## 1. Provided Services
[cite_start]The stack consists of several interconnected containers running on a private Docker network[cite: 152, 184].

| Service | Description |
| :--- | :--- |
| **Nginx** | [cite_start]The entry point of the stack, providing secure HTTPS access[cite: 226]. |
| **WordPress** | [cite_start]The primary Content Management System (CMS)[cite: 279]. |
| **MariaDB** | [cite_start]The relational database used to store website data[cite: 217]. |
| **Redis** | [cite_start]A high-performance cache to speed up WordPress performance[cite: 210, 282]. |
| **Adminer** | [cite_start]A lightweight web interface for database management[cite: 216]. |
| **vsFTPD** | [cite_start]An FTP server for manual file management[cite: 232]. |
| **Static Site** | [cite_start]A secondary static website accessible via a subfolder[cite: 229, 231]. |

---

## 2. Managing the Project
A **Makefile** is provided in the root directory to simplify management. [cite_start]You must have `sudo` privileges to execute these commands[cite: 154, 186].

### Starting the Stack
* **Initial Setup**: Run `make` or `make all`. [cite_start]This creates the necessary data directories, builds the images, and starts all containers[cite: 155, 187].
* [cite_start]**Standard Start**: Run `make up` to start the containers[cite: 155, 187].

### Stopping the Stack
* [cite_start]**Pause Services**: Run `make stop` to stop the containers without destroying them[cite: 156, 188].
* [cite_start]**Remove Services**: Run `make down` to stop and completely remove the containers[cite: 155, 187].
* [cite_start]**Full Reset**: Run `make fclean` to remove all images, containers, and persistent volumes[cite: 156, 188].

---

## 3. Accessing the Services
[cite_start]All web services are served through **Nginx** on port **4242** via HTTPS[cite: 215, 226].

* [cite_start]**Main Website**: `https://secros.42lyon.fr:4242/` [cite: 226]
* **WordPress Admin**: `https://secros.42lyon.fr:4242/wp-admin`
* [cite_start]**Database Management (Adminer)**: `https://secros.42lyon.fr:4242/adminer.php` [cite: 216]
* [cite_start]**Static Website**: `https://secros.42lyon.fr:4242/website/` [cite: 229]
* [cite_start]**FTP Server**: Access via IP on port **2100**[cite: 210].

---

## 4. Credentials & Data Management
[cite_start]Credentials for the services are managed through a `.env` file located in the project root[cite: 162, 195].

### Locating Credentials
Open the `.env` file to find the following variables:
* [cite_start]**Database**: `DB_NAME`, `DB_USER`, `DB_PASS`[cite: 208, 209].
* [cite_start]**WordPress Admin**: `WP_ADMIN`, `WP_ADMIN_PASS`, `WP_ADMIN_MAIL`[cite: 209, 213].
* [cite_start]**WordPress User**: `WP_USER`, `WP_USER_PASS`[cite: 209, 213].
* [cite_start]**FTP User**: Default user is `Damien` with password `Hello` (configured in `setup.sh`)[cite: 232, 233].

### Data Locations
[cite_start]Persistent data is stored on the host machine in the following directories[cite: 175, 207]:
* [cite_start]**Web Files**: `/home/secros/data/web` [cite: 211, 214]
* [cite_start]**Database Files**: `/home/secros/data/db` [cite: 211, 214]

---

## 5. System Health Check
To ensure the stack is functioning correctly, use the following tools:

1.  [cite_start]**Status Command**: Run `make status` to view a list of running containers, images, and active volumes[cite: 156, 188].
2.  [cite_start]**Container Logs**: Run `make logs DOCK=<container_name>` (e.g., `make logs DOCK=nginx`) to view the real-time output of a specific service[cite: 156, 188].
3.  [cite_start]**Direct Shell Access**: Run `make shell DOCK=<container_name>` to log into a container and inspect its internal state[cite: 156, 188].
