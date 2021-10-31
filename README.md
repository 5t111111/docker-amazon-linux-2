# Docker Amazon Linux 2

EC2-like Amazon Linux 2 container.

## Usage

### Basic

Start:

```text
docker-compose up --build -d
```

Connect via SSH:

```text
ssh ec2-user@localhost -p 22222 -i ./ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
```

### VS Code Remote-Containers

Run `Remote-Containers: Open Folder in Container`


## Port mapping

- 22222:22
- 18880:80
