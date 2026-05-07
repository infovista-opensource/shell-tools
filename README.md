# shell-tools

![GitHub Tag](https://img.shields.io/github/v/tag/infovista-opensource/shell-tools)
![Alpine](https://img.shields.io/badge/alpine-3.23.4-brightgreen)
![License](https://img.shields.io/badge/license-Apache%202.0-blue)

A lightweight, Alpine-based Docker image bundling essential CLI tools for testing, debugging, and troubleshooting in Kubernetes and cloud-native environments.

## Table of Contents

- [Included Tools](#included-tools)
- [Quick Start](#quick-start)
- [Usage Examples](#usage-examples)
- [Security](#security)
- [License](#license)

## Included Tools

### From Package Manager

| Tool | Description |
|---|---|
| `psql` (PostgreSQL 18 Client) | PostgreSQL interactive terminal |
| `jq` | Lightweight JSON processor |
| `yq` (yq-go) | YAML/JSON/XML processor |
| `curl` | Data transfer tool |
| `bash` | Bourne Again Shell |
| `bind-tools` | DNS utilities (`dig`, `nslookup`, `host`) |

### From External Releases

| Tool | Version | Source |
|---|---|---|
| `wait-for` | 1.0.0 | [GitHub](https://github.com/mrako/wait-for/releases) |
| `wait4x` | 3.6.0 | [GitHub](https://github.com/wait4x/wait4x/releases) |
| `kubectl` | 1.36.0 | [Kubernetes](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) |
| `helm` | 4.1.1 | [Helm](https://github.com/helm/helm/releases) |
| `mc` (MinIO Client) | RELEASE.2025-08-13T08-35-41Z | [MinIO](https://dl.min.io/client/mc/release/linux-amd64/) |

## Quick Start

```bash
# Run a one-off command
docker run --rm piccio/shell-tools:1.11.0 <command>

# Open an interactive shell
docker run --rm -it piccio/shell-tools:1.11.0 /bin/bash

# Run as an ephemeral pod in Kubernetes
kubectl run shell-tools --image=piccio/shell-tools:1.11.0 -it --rm -- /bin/bash
```

## Usage Examples

### PostgreSQL Client

Connect to a PostgreSQL instance directly:

```bash
docker run --rm piccio/shell-tools:1.11.0 psql -h <host> -p 5432 -U <user> -d <database>
```

Use within a Kubernetes cluster to reach an internal PostgreSQL service:

```bash
kubectl -n <namespace> run shell-tools --image=piccio/shell-tools:1.11.0 -it --rm -- \
  psql -h <postgres-service>.<namespace>.svc -p 5432 -U postgres
```

### MinIO Client

```bash
docker run --rm piccio/shell-tools:1.11.0 mc alias set myminio http://<minio-host>:9000 <access-key> <secret-key>
```

### DNS Troubleshooting

```bash
docker run --rm piccio/shell-tools:1.11.0 dig <domain>
docker run --rm piccio/shell-tools:1.11.0 nslookup <service>.<namespace>.svc.cluster.local
```

### Service Readiness Checks

Wait for a TCP port to become available:

```bash
docker run --rm piccio/shell-tools:1.11.0 wait-for <host>:<port> -- echo "Service is up"
```

Advanced readiness check with `wait4x`:

```bash
docker run --rm piccio/shell-tools:1.11.0 wait4x http http://<host>:<port>/health
```

### Helm & Kubectl

```bash
docker run --rm -v ~/.kube:/home/iv/.kube:ro piccio/shell-tools:1.11.0 kubectl get pods -A
docker run --rm -v ~/.kube:/home/iv/.kube:ro piccio/shell-tools:1.11.0 helm list -A
```

## Security

- The image runs as a **non-root user** (`iv`, UID/GID `1001`) by default.
- All external binaries are versioned and symlinked (e.g., `kubectl-v1.36.0` → `kubectl`), enabling easy auditing and rollback.
- Base image is kept minimal with Alpine and the APK cache is purged after installation.

## License

This project is licensed under the [Apache License 2.0](LICENSE).
