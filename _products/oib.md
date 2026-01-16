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

# Install and explore
make install
make demo
make open
```

That's it. Open [http://localhost:3000](http://localhost:3000) and start exploring your data.

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

| Signal | Endpoint | Protocol |
|--------|----------|----------|
| **Traces** | `localhost:4317` | OTLP gRPC |
| **Traces** | `http://localhost:4318` | OTLP HTTP |
| **Profiles** | `http://localhost:4040` | Pyroscope SDK (optional) |
| **Logs** | Automatic | Docker containers are auto-collected |
| **Probing** | `http://localhost:9115` | Blackbox Exporter (localhost only) |

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

## 🛠️ Commands Reference

```bash
# Installation
make install              # Install all stacks
make install-logging      # Install logging stack only
make install-metrics      # Install metrics stack only
make install-telemetry    # Install telemetry stack only
make install-grafana      # Install unified Grafana

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
make bootstrap            # Install + demo + open Grafana
make disk-usage           # Show disk space used by OIB
make version              # Show versions of running components

# Maintenance
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
