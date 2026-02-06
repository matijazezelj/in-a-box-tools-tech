---
layout: product
title: "AIB - Assets in a Box"
tagline: "Infrastructure asset discovery and dependency mapping. Parse Terraform, Kubernetes, and Ansible — see what depends on what, and what breaks if it fails."
icon: "🗺️"
github: "https://github.com/matijazezelj/aib"
docs: "https://github.com/matijazezelj/aib#readme"
permalink: /products/aib/
---

<section class="product-intro">
  <p class="lead">Your infrastructure is spread across Terraform, Kubernetes, and Ansible — but do you know what depends on what? AIB parses your IaC sources, builds a unified dependency graph, and answers the question that matters most: "what breaks if X fails?"</p>
</section>

## ⚡ Quick Start

```bash
# Build from source
git clone https://github.com/matijazezelj/aib.git && cd aib
make build

# Scan your Terraform state files
./bin/aib scan terraform /path/to/terraform.tfstate

# See what you have
./bin/aib graph show

# Analyze blast radius
./bin/aib impact node tf:network:prod-vpc

# Start the web UI
./bin/aib serve
```

Open [http://localhost:8080](http://localhost:8080) and explore your infrastructure graph.

---

## 📋 Prerequisites

| Requirement | Minimum |
|-------------|---------|
| Go | 1.22+ |
| Docker | 20.10+ (for Docker deployment) |
| terraform CLI | Required for remote state scanning |
| kubectl | Required for live cluster scanning |
| helm | Required for Helm chart scanning |

---

## 🧠 How It Works

![AIB Architecture](/assets/images/aib/architecture.svg)

1. **Parse**: Scan Terraform state files, Kubernetes manifests, Helm charts, and Ansible inventories
2. **Map**: Build a unified dependency graph with automatic cross-state edge resolution
3. **Analyze**: Run blast radius queries, track certificates, and export graphs
4. **Visualize**: Interactive web UI with search, filtering, and impact highlighting

---

## 🗺️ What You Get

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Parsers** | Go | Terraform, Kubernetes/Helm, Ansible source scanning |
| **Graph Engine** | SQLite + Memgraph | Asset storage with graph traversal queries |
| **Blast Radius** | BFS / Cypher | "What breaks if X fails?" analysis |
| **Cert Tracker** | TLS Prober | Certificate expiry monitoring and alerting |
| **Web UI** | Cytoscape.js | Interactive graph visualization |
| **REST API** | Go HTTP | Full CRUD, scan triggers, auth, rate limiting |
| **Alerting** | Webhooks | Certificate expiry and scan notifications |
| **Export** | JSON / DOT / Mermaid | Graph export for documentation and CI/CD |

---

## 🏗️ Supported Sources

### Terraform

Scan local state files, directories (recursive), or pull from remote backends:

```bash
# Local state files
aib scan terraform terraform.tfstate
aib scan terraform /path/to/terraform/directory/

# Multiple paths — cross-state edges resolve automatically
aib scan terraform networking.tfstate compute.tfstate data.tfstate

# Remote backends (S3, GCS, Azure, etc.)
aib scan terraform --remote project-networking/ project-compute/

# All workspaces across projects
aib scan terraform --remote --workspace='*' project-a/ project-b/
```

| Provider | Resources |
|----------|-----------|
| **GCP** | Compute instances, Cloud SQL, Redis, networks, subnets, firewalls, DNS, storage buckets, load balancers |
| **AWS** | EC2, RDS, VPCs, subnets, security groups, Route53, S3, ALB/ELB |
| **Azure** | VMs, SQL servers, PostgreSQL, virtual networks |
| **Cloudflare** | DNS records |
| **TLS** | Self-signed certs, ACME certificates |

### Kubernetes / Helm

```bash
# Manifest files and directories
aib scan k8s deployment.yaml
aib scan k8s /path/to/manifests/

# Helm charts
aib scan k8s /path/to/chart --helm
aib scan k8s /path/to/chart --helm --values=values-prod.yaml

# Live cluster scanning
aib scan k8s --live
aib scan k8s --live --context=prod-cluster --namespace=app
```

Discovers: Deployments, StatefulSets, DaemonSets, Services, Ingresses, Secrets, ConfigMaps, Namespaces, Certificates (cert-manager).

### Ansible

```bash
# INI or YAML inventories
aib scan ansible /etc/ansible/hosts
aib scan ansible staging.ini production.ini

# With playbook analysis
aib scan ansible inventory.ini --playbooks=./playbooks/
```

Discovers: Hosts, Docker containers, system services, group memberships.

---

## 💥 Blast Radius Analysis

The core feature. Ask "what breaks if this asset fails?" and get a tree of affected resources:

```
$ aib impact node tf:network:prod-vpc

Impact Analysis: tf:network:prod-vpc
   Type: network | Provider: google | Source: terraform

   Blast Radius: 4 affected assets

   tf:network:prod-vpc (network)
   ├── [connects_to] tf:subnet:prod-subnet (subnet)
   │   └── [connects_to] tf:vm:web-prod-1 (vm)
   │       └── [depends_on] tf:dns_record:web.example.com (dns_record)
   └── [depends_on] tf:database:cloudsql-prod (database)
```

AIB discovers 30+ asset types and 9 relationship types across all sources. When scanning multiple state files, **cross-state edges resolve automatically** — a VM in one state file links to a network defined in another.

---

## 🔐 Certificate Management

Track TLS certificates across your infrastructure:

```bash
# Probe a TLS endpoint
aib certs probe example.com:443

# List all tracked certificates
aib certs list

# Show certificates expiring within 30 days
aib certs expiring --days=30

# Re-probe all known endpoints from the graph
aib certs check
```

### Automatic Probing

When running `aib serve`, certificates are probed automatically on a schedule:

```yaml
certs:
  probe_enabled: true
  probe_interval: "6h"
  alert_thresholds: [90, 60, 30, 14, 7, 1]
```

The scheduler discovers TLS endpoints from the graph (ingresses, load balancers, DNS records), probes them, and sends alerts via configured backends when certificates are expiring.

---

## 🌐 Web UI

The embedded web UI provides:

- **Interactive graph visualization** with Cytoscape.js
- **Distinct node shapes** per asset category (rectangles for compute, diamonds for data, hexagons for networking)
- **Search and filter** by asset type and source
- **Blast radius highlighting** for selected nodes
- **Node detail panel** showing metadata, relationships, and impact analysis
- **Scan Now** button to trigger scans from the browser

---

## 📡 REST API

Full API with authentication and rate limiting:

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/healthz` | Health check |
| `GET` | `/api/v1/graph` | Full graph (nodes + edges) |
| `GET` | `/api/v1/graph/nodes` | List nodes (filter by type, source, provider) |
| `GET` | `/api/v1/graph/nodes/:id` | Single node details |
| `GET` | `/api/v1/graph/edges` | List edges (filter by type, from, to) |
| `GET` | `/api/v1/impact/:nodeId` | Blast radius for a node |
| `GET` | `/api/v1/certs` | All tracked certificates |
| `GET` | `/api/v1/certs/expiring` | Expiring certs (filter by days) |
| `GET` | `/api/v1/stats` | Summary statistics |
| `POST` | `/api/v1/scan` | Trigger a scan |

### Security

- Bearer token authentication on `/api/*` routes
- Rate limiting: 10 req/sec (burst 20) per client IP
- Security headers (CSP, X-Frame-Options, X-Content-Type-Options)
- Request body limits (1 MB)
- Path validation (directory traversal prevention)
- CORS (disabled by default, configurable)

---

## ⚙️ Configuration

AIB works out of the box with sensible defaults. Customize via `aib.yaml`:

```yaml
storage:
  path: "./data/aib.db"
  memgraph:
    enabled: false
    uri: "bolt://localhost:7687"

certs:
  probe_enabled: true
  probe_interval: "6h"
  alert_thresholds: [90, 60, 30, 14, 7, 1]

alerts:
  webhook:
    enabled: false
    url: "http://sib:8080/api/v1/events"
    headers:
      Authorization: "Bearer ${AIB_WEBHOOK_TOKEN}"
  stdout:
    enabled: true

server:
  listen: ":8080"
  read_only: false
  api_token: "${AIB_API_TOKEN}"
  cors_origin: ""

scan:
  schedule: "4h"
  on_startup: true
```

All settings support environment variables with the `AIB_` prefix. Sensitive fields support `${ENV_VAR}` expansion.

---

## 🗄️ Memgraph Integration

AIB uses a **hybrid storage model**: SQLite is the persistent source of truth, and [Memgraph](https://github.com/memgraph/memgraph) is an optional graph engine for faster traversal queries.

```bash
# Start Memgraph
docker run -p 7687:7687 memgraph/memgraph-mage

# Enable in config
# storage.memgraph.enabled: true

# Sync existing data
aib graph sync
```

- **Writes** go to both SQLite and Memgraph
- **Graph queries** (blast radius, neighbors, shortest path) use Memgraph's Cypher engine
- **If Memgraph is unavailable**, all queries fall back to the local BFS engine
- **SQLite stays the source of truth** — Memgraph can be rebuilt at any time

---

## 📤 Graph Export

Export your infrastructure graph for documentation and CI/CD:

```bash
aib graph export --format=json      # JSON (default)
aib graph export --format=dot       # Graphviz DOT
aib graph export --format=mermaid   # Mermaid diagram
```

---

## 🛠️ Commands Reference

```bash
# Scanning
aib scan terraform <path...>              # Scan Terraform state files
aib scan terraform --remote <path...>     # Pull from remote backend
aib scan k8s <path...>                    # Scan K8s manifests
aib scan k8s --helm <path>               # Scan Helm chart
aib scan k8s --live                       # Scan live cluster
aib scan ansible <path...>               # Scan Ansible inventories

# Graph queries
aib graph show                            # Graph summary
aib graph nodes [--type= --source=]       # List nodes
aib graph edges [--type= --from=]         # List edges
aib graph neighbors <node-id>             # Direct connections
aib graph export [--format=json|dot|mermaid]  # Export graph
aib graph sync                            # Sync to Memgraph

# Impact analysis
aib impact node <node-id>                 # Blast radius

# Certificate management
aib certs list                            # All tracked certs
aib certs expiring [--days=30]            # Expiring certs
aib certs probe <host:port>               # Probe TLS endpoint
aib certs check                           # Re-probe all endpoints

# Web UI + API
aib serve [--listen=:8080] [--read-only]  # Start server
```

---

## 🔄 AIB vs Other Tools

| | AIB | Backstage | Pulumi Insights | CloudQuery |
|---|---|---|---|---|
| **Setup** | `make build` | Complex | SaaS | CLI + DB |
| **IaC sources** | Terraform, K8s, Ansible | Manual catalog | Pulumi only | 100+ plugins |
| **Blast radius** | Built-in | No | Limited | No |
| **Cert tracking** | Built-in | No | No | No |
| **Self-hosted** | Yes (single binary) | Yes (complex) | No | Yes |
| **Dependencies** | None (SQLite) | PostgreSQL | Cloud | PostgreSQL |
| **Size** | ~13 MB binary | Heavy | N/A | Medium |

---

## 👥 Who This Is For

- **Infrastructure teams** who need to understand dependencies across multi-cloud environments
- **SREs** planning disaster recovery or assessing change impact
- **Security teams** running blast radius analysis for risk assessment
- **DevOps engineers** tracking certificate lifecycles across infrastructure
- **Anyone** managing Terraform, Kubernetes, or Ansible who wants a unified view

## Who This Is NOT For

- Teams that need a full service catalog with developer portal features — use Backstage
- Organizations using only one cloud with built-in dependency views
- People who need real-time infrastructure monitoring — use OIB for that

---

## 📄 License

Apache 2.0 License — use it, modify it, build on it.

<div class="cta-box">
  <h3>Ready to map your infrastructure?</h3>
  <a href="https://github.com/matijazezelj/aib" class="btn btn-primary btn-large">View on GitHub</a>
</div>
