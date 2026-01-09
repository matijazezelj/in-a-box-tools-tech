---
layout: product
title: "SIB-K8s - SIEM in a Box for Kubernetes"
tagline: "Kubernetes security monitoring with AI-powered analysis. Multi-cloud K8s audit support, runtime detection with Falco, and privacy-preserving LLM analysis."
icon: "☸️"
github: "https://github.com/matijazezelj/sib-k8s"
docs: "https://github.com/matijazezelj/sib-k8s#readme"
permalink: /products/sib-k8s/
---

<section class="product-intro">
  <p class="lead">Enterprise-grade Kubernetes security monitoring delivered as a single Helm chart. SIB-K8s combines runtime security detection with AI-powered alert analysis, featuring multi-cloud K8s audit support and privacy-preserving features.</p>
</section>

## ⚡ Quick Start

```bash
# Add the Helm repository
helm repo add sib-k8s https://matijazezelj.github.io/sib-k8s
helm repo update

# Install for generic Kubernetes (webhook-based)
helm install sib-k8s sib-k8s/sib-k8s \
  -f values-k8saudit.yaml \
  -n sib-k8s --create-namespace
```

Access Grafana at `kubectl port-forward -n sib-k8s svc/sib-k8s-grafana 3000:80` and start monitoring.

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              SIB-K8s                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │                        K8s Audit Sources                              │   │
│  │  ┌─────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │   │
│  │  │k8saudit │  │k8saudit-eks │  │k8saudit-gke │  │k8saudit-aks │     │   │
│  │  │(webhook)│  │(CloudWatch) │  │(Cloud Log)  │  │(Event Hub)  │     │   │
│  │  └────┬────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘     │   │
│  └───────┴──────────────┴────────────────┴────────────────┴─────────────┘   │
│                                    │                                         │
│                                    ▼                                         │
│  ┌──────────────┐     ┌─────────────────┐     ┌───────────────────────────┐ │
│  │    Falco     │     │  Falcosidekick  │     │          Loki             │ │
│  │  (Detection) │────▶│   (Fan-out)     │────▶│    (Log Storage)          │ │
│  └──────────────┘     └─────────────────┘     └───────────────────────────┘ │
│         │                     │                            │                 │
│         │                     ▼                            ▼                 │
│         │            ┌─────────────────┐          ┌───────────────┐         │
│         │            │ Analysis Service │          │    Grafana    │         │
│         │            │  (AI + Obfusc)  │          │  (Dashboards) │         │
│         │            └─────────────────┘          └───────────────┘         │
│         │                     │                                              │
│         │                     ▼                                              │
│         │            ┌─────────────────┐                                     │
│         └───────────▶│   LLM Provider  │                                     │
│  (syscall events)    │ Ollama/OpenAI/  │                                     │
│                      │   Anthropic     │                                     │
│                      └─────────────────┘                                     │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## ☁️ Multi-Cloud K8s Audit Support

SIB-K8s natively integrates with all major cloud providers' Kubernetes audit logging:

| Plugin | Integration | Use Case |
|--------|-------------|----------|
| **k8saudit** | Webhook-based | Any Kubernetes cluster with API server access |
| **k8saudit-eks** | CloudWatch Logs | AWS EKS clusters |
| **k8saudit-gke** | Cloud Logging | Google GKE clusters |
| **k8saudit-aks** | Event Hub | Azure AKS clusters |

### Cloud-Specific Installation

**AWS EKS:**
```bash
helm install sib-k8s . \
  -f values-eks.yaml \
  --set auditPlugin.k8sauditEks.logGroup="/aws/eks/my-cluster/cluster" \
  --set auditPlugin.k8sauditEks.region="us-east-1" \
  -n sib-k8s --create-namespace
```

**Google GKE:**
```bash
helm install sib-k8s . \
  -f values-gke.yaml \
  --set auditPlugin.k8sauditGke.projectId="my-project" \
  --set auditPlugin.k8sauditGke.clusterId="my-cluster" \
  --set auditPlugin.k8sauditGke.location="us-central1" \
  -n sib-k8s --create-namespace
```

**Azure AKS:**
```bash
helm install sib-k8s . \
  -f values-aks.yaml \
  --set auditPlugin.k8sauditAks.subscriptionId="..." \
  --set auditPlugin.k8sauditAks.resourceGroup="my-rg" \
  --set auditPlugin.k8sauditAks.clusterName="my-cluster" \
  --set auditPlugin.k8sauditAks.eventHubNamespace="my-eh-ns" \
  -n sib-k8s --create-namespace
```

---

## 🛡️ What You Get

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Detection** | Falco | Runtime security using eBPF syscall monitoring |
| **K8s Audit** | Falco Plugins | Kubernetes API audit log analysis |
| **Routing** | Falcosidekick | Alert routing to 50+ destinations |
| **Storage** | Loki | Log aggregation optimized for security events |
| **Visualization** | Grafana | Pre-built Kubernetes security dashboards |
| **AI Analysis** | Custom Service | Privacy-preserving LLM-powered alert analysis |

---

## ✨ Key Features

### Security Monitoring
- **Runtime security detection** with Falco's eBPF-based syscall monitoring
- **K8s audit log analysis** with MITRE ATT&CK mapping
- **Syscall-level monitoring** (optional) for host-level detection
- **Pre-built detection rules** for Kubernetes-specific threats

### AI-Powered Analysis
- **Privacy-preserving** alert analysis with configurable obfuscation
- **Three obfuscation levels:** minimal, standard, paranoid
- **Multiple LLM providers:** Ollama (local), OpenAI, Anthropic
- **Automatic MITRE ATT&CK mapping** and risk assessment
- **Investigation recommendations** for each alert

### Observability
- **Centralized logging** with Grafana Loki
- **Pre-built dashboards** for K8s security events
- **Alert routing** to Slack, Teams, PagerDuty, and 50+ destinations
- **ServiceMonitor support** for Prometheus integration

---

## 🔒 Privacy & Obfuscation

The analysis service protects sensitive data before sending to LLM providers:

### Obfuscation Levels

| Level | What's Protected | Use Case |
|-------|-----------------|----------|
| **minimal** | Only credentials | API keys, tokens, passwords |
| **standard** | Recommended | + IPs, hostnames, usernames, container IDs |
| **paranoid** | Maximum privacy | + File paths, high-entropy strings |

### What Gets Protected

- AWS/GCP/Azure credentials and tokens
- GitHub/GitLab tokens
- Database connection strings
- Private keys and certificates
- Internal IP addresses and hostnames
- Usernames and email addresses
- Container and pod IDs

---

## 📊 Grafana Dashboards

SIB-K8s includes pre-built dashboards:

1. **SIB-K8s Overview** — Summary of all security events across your cluster
2. **K8s Audit Events** — Kubernetes API audit analysis with drill-down capabilities

Access Grafana:
```bash
kubectl port-forward -n sib-k8s svc/sib-k8s-grafana 3000:80

# Get the admin password
kubectl get secret -n sib-k8s sib-k8s-grafana \
  -o jsonpath="{.data.admin-password}" | base64 -d
```

---

## 🔧 Configuration

### Syscall Monitoring

Enable syscall monitoring for host-level detection:

```yaml
syscallMonitoring:
  enabled: true
  driverKind: modern_ebpf  # or: kmod, ebpf, auto
```

### Analysis Service

Configure AI-powered analysis:

```yaml
analysis:
  enabled: true
  
  obfuscation:
    level: standard  # minimal, standard, paranoid
  
  llm:
    provider: ollama  # or: openai, anthropic
    
    ollama:
      url: http://ollama:11434
      model: llama3.1:8b
    
    # For OpenAI:
    # openai:
    #   existingSecret: openai-api-key
    #   secretKey: api-key
    #   model: gpt-4o-mini
```

### Alert Routing

Configure where alerts are sent:

```yaml
falcosidekick:
  enabled: true
  config:
    slack:
      webhookurl: "https://hooks.slack.com/services/..."
    
    teams:
      webhookurl: "https://outlook.office.com/webhook/..."
    
    pagerduty:
      routingkey: "..."
```

### Custom Falco Rules

Add your own detection rules:

```yaml
customRules:
  enabled: true
  rules: |
    - rule: My Custom Rule
      desc: Detect specific behavior
      condition: evt.type = open and fd.name contains "/sensitive"
      output: "Sensitive file access: %fd.name by %proc.name"
      priority: WARNING
      tags: [custom, sensitive]
```

---

## 📋 Prerequisites

- **Kubernetes** 1.25+
- **Helm** 3.x
- **For syscall monitoring:** Linux kernel 5.8+ (for modern_ebpf driver)
- **For AI analysis:** Access to LLM provider (Ollama, OpenAI, or Anthropic)

---

## 🏷️ Chart Dependencies

| Component | Version | Source |
|-----------|---------|--------|
| Falco | 4.20.0 | falcosecurity |
| Falcosidekick | 0.9.5 | falcosecurity |
| Loki | 6.24.0 | grafana |
| Grafana | 8.8.2 | grafana |

---

## 📝 Example Values Files

SIB-K8s includes pre-configured values files for different environments:

- `values.yaml` — Default configuration
- `values-eks.yaml` — AWS EKS configuration
- `values-gke.yaml` — Google GKE configuration
- `values-aks.yaml` — Azure AKS configuration
- `values-k8saudit.yaml` — Generic K8s webhook configuration

---

## 👥 Who This Is For

- **Platform teams** managing Kubernetes clusters who need security visibility
- **Security teams** who want K8s-native SIEM capabilities
- **DevSecOps engineers** who want security monitoring as part of their infrastructure
- **Multi-cloud operators** who need consistent security across EKS, GKE, and AKS
- **Privacy-conscious organizations** who want AI analysis without data exposure

## Who This Is NOT For

- Teams who don't use Kubernetes — check out [SIB](/products/sib/) for traditional infrastructure
- Organizations requiring commercial support and SLAs
- Compliance-only requirements without actual security monitoring needs

---

## 🙏 Acknowledgments

- [Falco](https://falco.org/) — Cloud native runtime security
- [Falcosidekick](https://github.com/falcosecurity/falcosidekick) — Alert routing
- [Grafana](https://grafana.com/) — Observability platform
- [Loki](https://grafana.com/oss/loki/) — Log aggregation
- [SIB](https://github.com/matijazezelj/sib) — Original SIEM in a Box project

---

## 📄 License

Apache 2.0 License — use it, modify it, build on it.

<div class="cta-box">
  <h3>Ready to secure your Kubernetes clusters?</h3>
  <a href="https://github.com/matijazezelj/sib-k8s" class="btn btn-primary btn-large">View on GitHub</a>
</div>
