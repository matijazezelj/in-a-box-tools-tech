---
layout: product
title: "SIB - SIEM in a Box"
tagline: "AI-powered SIEM in a Box with privacy controls. Runtime detection with Falco, LLM analysis, and visualization with Grafana."
icon: "🛡️"
github: "https://github.com/matijazezelj/sib"
docs: "https://github.com/matijazezelj/sib#readme"
permalink: /products/sib/
---

<section class="product-intro">
  <p class="lead">Security monitoring shouldn't require a six-figure budget and a dedicated team. SIB provides enterprise-grade security visibility using open source tools, now with AI-powered alert analysis.</p>
</section>

## ⚡ Quick Start

```bash
# Clone and configure
git clone https://github.com/matijazezelj/sib.git && cd sib
cp .env.example .env

# Install and explore
make install
make demo
```

Open Grafana at [http://localhost:3000](http://localhost:3000) and watch security events flow in.

---

## � How It Works

> **Not a network sniffer!** SIB uses Falco's eBPF-based syscall monitoring — it watches what programs do at the kernel level, not network packets. No mirror ports, TAPs, or bridge interfaces needed. Just install on any Linux host with kernel 5.8+ and it sees everything that host does.

### Hardware Requirements

| Setup | CPU | RAM | Disk | Notes |
|-------|-----|-----|------|-------|
| **SIB Server (single host)** | 2 cores | 4GB | 20GB | Runs Falco + full stack |
| **SIB Server (with fleet)** | 4 cores | 8GB | 50GB+ | More storage for logs from multiple hosts |
| **Fleet Agent** | 1 core | 512MB | 1GB | Falco + Alloy only |

---

## �🛡️ What You Get

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Detection** | Falco | Runtime security using eBPF syscall monitoring |
| **Routing** | Falcosidekick | Alert routing to 50+ destinations |
| **Storage** | Loki | Log aggregation optimized for security events |
| **Metrics** | Prometheus | Metrics collection and alerting |
| **Visualization** | Grafana | Pre-built security dashboards |
| **Threat Intel** | Multiple feeds | Automatic IOC updates |

---

## 🎯 What Gets Detected

Out of the box, SIB catches:

| Category | Examples |
|----------|----------|
| **Credential Access** | Reading /etc/shadow, SSH key access |
| **Container Security** | Shells in containers, privileged operations |
| **Persistence** | Cron modifications, systemd changes |
| **Defense Evasion** | Log clearing, timestomping |
| **Discovery** | System enumeration, network scanning |
| **Lateral Movement** | SSH from containers, remote file copy |
| **Exfiltration** | Curl uploads, DNS tunneling indicators |
| **Impact** | Mass file deletion, service stopping |
| **Cryptomining** | Mining processes, pool connections |

All detection rules are mapped to **MITRE ATT&CK** techniques.

---

## 📊 Security Dashboards

### MITRE ATT&CK Coverage
Every MITRE ATT&CK tactic gets a panel. See at a glance what you're detecting — and what you're not. Includes hostname filter to focus on specific hosts.

![MITRE ATT&CK Dashboard](/assets/images/sib/mitre-attack.png)

### Security Overview
Total events, critical alerts, and real-time event streams organized by priority. Filter by hostname to focus on specific hosts.

![Security Overview](/assets/images/sib/security-overview.png)

### Events Explorer
Filter by priority, rule name, hostname, and drill down into specific events with full LogQL support.

![Events Explorer](/assets/images/sib/events-explorer.png)

### Fleet Overview
Monitor multiple hosts with CPU, memory, disk, and network metrics. Hostname selector filters all panels to focus on individual hosts.

![Fleet Overview](/assets/images/sib/fleet-overview.png)

---

## 🤖 AI-Powered Alert Analysis (Beta)

Got an alert but not sure what it means? SIB can analyze your security events using LLMs.

```bash
make analyze
```

You get:
- **Attack vector explanation** — What the attacker is trying to do
- **MITRE ATT&CK mapping** — Tactic and technique IDs
- **Risk assessment** — Severity, confidence, impact
- **Mitigation steps** — Immediate, short-term, long-term actions
- **False positive assessment** — Is this real or noise?

### Privacy First

Your sensitive data **never leaves your network** (unless you want it to). Before sending anything to the LLM, all PII is obfuscated:

| Data Type | What Happens |
|-----------|--------------|
| IP addresses | → `[INTERNAL-IP-1]`, `[EXTERNAL-IP-1]` |
| Usernames | → `[USER-1]` |
| Hostnames | → `[HOST-1]` |
| Container IDs | → `[CONTAINER-1]` |
| Secrets | → `[REDACTED]` |

### LLM Options

| Provider | Where data goes | Best for |
|----------|----------------|----------|
| **Ollama** (default) | Your machine | Privacy-conscious users |
| OpenAI | OpenAI API (obfuscated) | Better quality |
| Anthropic | Anthropic API (obfuscated) | Claude fans |

Preview what gets sent before any LLM call:
```bash
make analyze-dry-run
```

---

## 📡 Sigma Rules Support

Bring your existing detection rules. SIB includes a converter that transforms Sigma rules into:

1. **Falco rules** — For runtime detection
2. **LogQL alerts** — For log-based detection in Loki

```bash
make convert-sigma
```

The entire [Sigma community rules ecosystem](https://github.com/SigmaHQ/sigma) is available to you.

---

## 🌐 Threat Intelligence

SIB automatically pulls IOC feeds from:

| Feed | Data | Source |
|------|------|--------|
| Feodo Tracker | Banking trojan C2 servers | abuse.ch |
| SSL Blacklist | Malicious SSL certificates | abuse.ch |
| Emerging Threats | Compromised IPs | emergingthreats.net |
| Spamhaus DROP | Hijacked IP ranges | spamhaus.org |
| Blocklist.de | Brute force attackers | blocklist.de |
| CINSscore | Threat intelligence scoring | cinsscore.com |

```bash
make update-threatintel
```

---

## 🚀 Fleet Management

Got more than one server? SIB includes Ansible-based fleet management — no local Ansible needed, it runs in Docker.

```
┌─────────────────────────────────────────────────────────┐
│                    SIB Central Server                    │
│  ┌─────────┐ ┌──────┐ ┌────────────┐ ┌─────────┐       │
│  │ Grafana │ │ Loki │ │ Prometheus │ │Sidekick │       │
│  └─────────┘ └──────┘ └────────────┘ └─────────┘       │
└─────────────────────────▲──────────────▲────────────────┘
                          │              │
     ┌────────────────────┼──────────────┼────────────────┐
     │   Host A           │   Host B     │   Host C       │
     │ Falco + Alloy ─────┴──────────────┴─── ...         │
     └────────────────────────────────────────────────────┘
```

### Deployment Strategy

SIB supports both native packages (default) and Docker containers:

| Strategy | Description |
|----------|-------------|
| **native** (default) | Falco from repo + Alloy as systemd service. Recommended for best visibility. |
| **docker** | Run agents as containers |
| **auto** | Use Docker if available, otherwise native |

> **Why native is recommended:** Native deployment sees all host processes, while Docker-based Falco may miss events from processes outside its container namespace.

> ⚠️ **LXC Limitation:** Falco cannot run in LXC containers due to kernel access restrictions. Use VMs or run Falco on the LXC host itself.

```bash
# Configure your hosts
cp ansible/inventory/hosts.yml.example ansible/inventory/hosts.yml

# Test connectivity
make fleet-ping

# Deploy agents to all hosts (native by default)
make deploy-fleet

# Or force Docker deployment
make deploy-fleet ARGS="-e deployment_strategy=docker"
```

---

## 🛠️ Commands Reference

```bash
# Installation
make install              # Install all stacks
make install-detection    # Install Falco + Falcosidekick
make install-storage      # Install Loki + Prometheus
make install-grafana      # Install unified Grafana

# Demo & Testing
make demo                 # Generate sample security events
make demo-quick           # Quick demo (fewer events)

# Threat Intelligence
make update-threatintel   # Update IOC feeds
make convert-sigma        # Convert Sigma rules to Falco

# Fleet Management
make deploy-fleet         # Deploy agents to all fleet hosts
make update-rules         # Push detection rules to fleet
make fleet-health         # Check health of all agents
make fleet-ping           # Test SSH connectivity

# Health & Status
make health               # Quick health check
make status               # Show all services
make logs                 # Tail all logs

# Maintenance
make update               # Pull latest images and restart
make stop                 # Stop all stacks
make uninstall            # Remove everything
```

---

## 👥 Who This Is For

- **Small security teams** who need visibility but don't have SIEM budget
- **Homelab enthusiasts** who want to monitor their infrastructure properly
- **DevSecOps engineers** who want security visibility in their pipeline
- **Anyone** learning security monitoring hands-on
- **Red teamers** who want to test if their activity gets caught

## Who This Is NOT For

- Large enterprises with dedicated SOC teams — you probably need the scale of commercial tools
- People who want a managed service — this is self-hosted
- Compliance checkbox hunters — this gives you real security, not audit theater

---

## 📄 License

Apache 2.0 License — use it, modify it, build on it.

<div class="cta-box">
  <h3>Ready to secure your infrastructure?</h3>
  <a href="https://github.com/matijazezelj/sib" class="btn btn-primary btn-large">View on GitHub</a>
</div>
