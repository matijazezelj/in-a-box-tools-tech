---
layout: product
title: "OIB - Observability in a Box"
tagline: "The complete Grafana LGTM stack. Logs, metrics, traces, and profiling — configured and ready to run."
icon: "🔭"
github: "https://github.com/matijazezelj/oib"
docs: "https://github.com/matijazezelj/oib#readme"
permalink: /products/oib/
---

<section class="product-intro">
  <p class="lead">A plug-and-play observability stack for developers. Zero config, production-ready patterns. Get instant observability using Grafana's LGTM stack.</p>
</section>

## ⚡ Quick Start

```bash
# Clone and configure
git clone https://github.com/matijazezelj/oib.git && cd oib
cp .env.example .env  # Edit and set GRAFANA_ADMIN_PASSWORD

# One command to rule them all
make bootstrap  # Install + demo + open Grafana
```

That's it. Open [http://localhost:3000](http://localhost:3000) and start exploring your data.

---

## 📋 Prerequisites

- **Docker** 20.10+ or **Podman** 4.0+
- **Docker Compose** v2+
- **Make** utility
- **2GB+ RAM** recommended
- **curl** for health checks

---

## 📦 What's Included

| Stack | Components | Purpose |
|-------|------------|---------|
| **Logging** | Loki + Alloy | Centralized log aggregation with automatic Docker log collection |
| **Metrics** | Prometheus + Alloy + cAdvisor + Blackbox Exporter | Host metrics via Alloy, container metrics via cAdvisor, endpoint probing |
| **Tracing** | Tempo + Alloy | Distributed tracing with OpenTelemetry support |
| **Profiling** | Pyroscope | Continuous profiling (optional: `make install-profiling`) |
| **Visualization** | Grafana | Pre-built dashboards for all four pillars |
| **Testing** | k6 | Load testing with metrics streaming to Prometheus |

---

## 🔌 Integration Endpoints

Once installed, your applications can send data to:

### Public Access (External Hosts)

| Service | Endpoint | Purpose |
|---------|----------|---------|
| **Grafana UI** | `http://<host>:3000` | Dashboards and visualization |
| **OTLP gRPC** | `<host>:4317` | Send traces via gRPC |
| **OTLP HTTP** | `http://<host>:4318` | Send traces via HTTP |

### Localhost Only

| Service | Endpoint | Purpose |
|---------|----------|---------|
| **Loki API** | `http://localhost:3100` | Log queries |
| **Prometheus** | `http://localhost:9090` | Metrics queries |
| **Tempo API** | `http://localhost:3200` | Trace queries |
| **Pyroscope** | `http://localhost:4040` | Profiling (optional) |
| **Blackbox** | `http://localhost:9115` | Endpoint probing |

### From Docker Containers

Use internal hostnames on `oib-network`:
- `oib-prometheus:9090`
- `oib-loki:3100`
- `oib-tempo:3200`

> **Note:** Logs from Docker containers are auto-collected by Alloy — no configuration needed.

---

## 📊 Pre-built Dashboards

OIB comes with six ready-to-use Grafana dashboards:

| Dashboard | Description |
|-----------|-------------|
| **System Overview** | Container CPU/memory, disk usage, network I/O |
| **Host Metrics** | Detailed host system metrics (CPU, memory, disk, network) via Alloy |
| **Logs Explorer** | Log volume, live logs, errors/warnings panel |
| **Traces Explorer** | TraceQL examples, Python, Node.js, Ruby & PHP code samples |
| **Profiles Explorer** | CPU, memory, and goroutine profiling with Pyroscope |
| **Request Latency** | Endpoint probing (Blackbox), k6 load test metrics, latency percentiles |

---

## 📸 Screenshots

### System Overview
Real-time CPU, memory, disk gauges plus per-container resource usage.

![System Overview](/assets/images/oib/system-overview.png)

### Logs Explorer
Log volume by container, live log stream, and dedicated errors/warnings panel.

![Logs Explorer](/assets/images/oib/logs-explorer.png)

### Traces Explorer
Full distributed tracing with PostgreSQL, Redis, and HTTP spans visible.

![Traces Explorer](/assets/images/oib/traces-explorer.png)

---

## ⚙️ Configuration

Key environment variables in `.env`:

| Variable | Default | Description |
|----------|---------|-------------|
| `GRAFANA_ADMIN_USER` | admin | Grafana admin username |
| `GRAFANA_ADMIN_PASSWORD` | (required) | Grafana admin password |
| `GRAFANA_PORT` | 3000 | Grafana port |
| `PROMETHEUS_RETENTION_TIME` | 15d | Metrics retention period |
| `PROMETHEUS_RETENTION_SIZE` | 5GB | Max metrics storage |

Version overrides: `GRAFANA_VERSION`, `LOKI_VERSION`, `PROMETHEUS_VERSION`, `TEMPO_VERSION`, `ALLOY_VERSION`

---

## 🛠️ Commands Reference

```bash
# Installation
make install              # Install all stacks
make install-logging      # Install logging stack only
make install-metrics      # Install metrics stack only
make install-telemetry    # Install telemetry stack only
make install-profiling    # Install Pyroscope profiling
make install-grafana      # Install unified Grafana
make bootstrap            # Install + demo + open Grafana

# Health & Diagnostics
make health               # Quick health check
make doctor               # Diagnose common issues (Docker, ports, config)
make status               # Show all services with health indicators
make check-ports          # Check if required ports are available
make validate             # Validate configuration files

# Load Testing
make test-load            # Run k6 basic load test
make test-stress          # Run stress test (find breaking point)
make test-spike           # Run spike test (sudden traffic)
make test-api             # Run API endpoint load test

# Utilities
make open                 # Open Grafana in browser
make demo                 # Generate sample data (logs, metrics, traces)
make demo-examples        # Run example apps and generate traffic
make disk-usage           # Show disk space used by OIB
make version              # Show versions of running components

# Maintenance
make start                # Start all services
make stop                 # Stop all services
make restart              # Restart all services
make update               # Pull pinned version images and restart
make latest               # Pull and run :latest versions of all images
make logs                 # Tail logs from all stacks
make uninstall            # Remove all stacks and volumes (with confirmation)
```

---

## 💻 Example Integration

### Python (Flask with OpenTelemetry)

```python
from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor

provider = TracerProvider()
exporter = OTLPSpanExporter(endpoint="localhost:4317", insecure=True)
provider.add_span_processor(BatchSpanProcessor(exporter))
trace.set_tracer_provider(provider)

tracer = trace.get_tracer(__name__)

@app.route('/api/users')
def get_users():
    with tracer.start_as_current_span("get-users"):
        # Your code here
        return users
```

### Node.js (Express)

```javascript
const { NodeSDK } = require('@opentelemetry/sdk-node');
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-grpc');

const sdk = new NodeSDK({
  traceExporter: new OTLPTraceExporter({
    url: 'http://localhost:4317',
  }),
  serviceName: 'my-node-app',
});
sdk.start();
```

### Docker Compose Integration

```yaml
services:
  my-app:
    environment:
      - OTEL_EXPORTER_OTLP_ENDPOINT=http://host.docker.internal:4318
      - OTEL_SERVICE_NAME=my-app
    networks:
      - oib-network

networks:
  oib-network:
    external: true
```

### Docker Log Driver

Send logs directly via Loki Docker driver:

```yaml
services:
  my-app:
    logging:
      driver: loki
      options:
        loki-url: "http://localhost:3100/loki/api/v1/push"
        labels: "app"
```

### Prometheus Scraping via Labels

Expose metrics using Docker labels:

```yaml
services:
  my-app:
    labels:
      - "prometheus.scrape=true"
      - "prometheus.port=8080"
```

---

## 📡 Endpoint Probing

OIB includes Blackbox Exporter for synthetic monitoring:

- HTTP/HTTPS health checks
- TCP port connectivity
- ICMP ping checks
- DNS resolution tests
- SSL certificate validation

Configure probes in `metrics/config/prometheus.yml` to monitor your endpoints.

---

## 👥 Who This Is For

- **Developers** who want to understand how their app behaves without becoming observability experts
- **Self-hosters** who want proper monitoring without enterprise complexity
- **Small teams** who need observability but don't have dedicated SRE staff
- **Anyone** learning about metrics, logs, and traces in a hands-on way

---

## 📄 License

MIT License — use it however you want.

<div class="cta-box">
  <h3>Ready to get started?</h3>
  <a href="https://github.com/matijazezelj/oib" class="btn btn-primary btn-large">View on GitHub</a>
</div>
