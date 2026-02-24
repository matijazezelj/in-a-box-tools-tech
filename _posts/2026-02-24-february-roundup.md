---
layout: post
title: "February 2026 Roundup: What's New Across All Products"
date: 2026-02-24
description: "A rundown of recent updates across the entire In a Box family — new scanners in AIB, remote collectors in SIB, custom rules in NIB, comparison tables for SIB-K8s, and more."
categories: [update]
---

The In a Box family now has **five products** — and all of them have been getting steady updates since their launches. Here's everything that's changed.

---

## 🗺️ AIB — Assets in a Box

AIB shipped in early February as a single Go binary for infrastructure asset discovery. Since then, the scanner coverage has expanded significantly.

### New Scanners

AIB originally launched with Terraform, Kubernetes, and Ansible support. It now also scans:

- **Docker Compose** — parse `docker-compose.yml` files, map service dependencies, volumes, and networks
- **CloudFormation** — AWS CloudFormation templates and stacks
- **Pulumi** — Pulumi state files
- **Terraform Plan** — `terraform plan -out=plan.json` output for pre-apply analysis

That brings the total to **seven scanner types** feeding into one unified dependency graph.

### Security Audit Engine

New `aib graph audit` command runs **15 automated checks** against your infrastructure graph:

- Publicly exposed resources without WAF/CDN protection
- Databases accessible from public subnets
- Unencrypted storage and missing backup configurations
- Load balancers with single targets (no redundancy)
- Resources missing required tags

Each finding includes severity, affected assets, and remediation guidance.

### Drift Detection

`aib scan --drift` compares consecutive scans and reports what changed — added, removed, and modified assets. Useful for catching untracked infrastructure changes between Terraform applies.

### Graph Analysis

`aib graph analyze` detects structural problems in your infrastructure:

- **Dependency cycles** — circular references between resources
- **Single points of failure** — resources with high fan-in that would cause cascading failures
- **Orphaned resources** — assets with no incoming or outgoing edges

### Alerting & API

- **Slack and Microsoft Teams** webhook integration for certificate expiry and audit findings
- **18 REST API endpoints** for programmatic access when running in server mode (`aib serve`)

---

## 🛡️ SIB — SIEM in a Box

### Remote Collectors

SIB now supports a **hub-and-spoke architecture** for monitoring multiple hosts from a central server. Deploy lightweight collector agents on remote machines that forward security events back to the hub:

```
Remote Host A ──┐
Remote Host B ──┼──▶ SIB Hub (Grafana + Storage)
Remote Host C ──┘
```

Enable with `make enable-remote` on the hub, then `make deploy-collector` to push agents to remote hosts.

### Demo Mode

`make demo` now generates **realistic security events** across 9 MITRE ATT&CK categories:

- Initial Access, Execution, Persistence, Privilege Escalation
- Defense Evasion, Credential Access, Discovery, Lateral Movement, Exfiltration

Great for testing your dashboards and alert rules without waiting for real threats.

### Fleet Management Updates

- Default fleet strategy changed from `native` to **`auto`** (auto-detects Docker vs native)
- **Docker** strategy is now recommended for most deployments
- Added Docker Desktop compatibility warning for macOS/Windows users

### Security Hardening

- **mTLS support** for fleet agent ↔ hub communication
- New `make doctor` command for troubleshooting
- New `make backup` / `make restore` commands for configuration and data

### Comparison Table

The docs now include a detailed comparison with Wazuh, Splunk, and Elastic Security covering deployment complexity, resource usage, AI capabilities, and licensing.

---

## ☸️ SIB-K8s — SIEM in a Box for Kubernetes

### Comparison Table

New side-by-side comparison with other Kubernetes security tools:

| | SIB-K8s | Falco + Sidekick | Sysdig Secure | Aqua / StackRox |
|---|---|---|---|---|
| Runtime detection | ✅ Falco | ✅ Falco | Proprietary | Proprietary |
| AI analysis | ✅ Built-in | ❌ | ❌ | ❌ |
| Privacy obfuscation | ✅ Pre-LLM | ❌ | ❌ | ❌ |
| Multi-cloud audit | ✅ EKS/GKE/AKS | Manual | ✅ | Partial |
| Dashboards | ✅ Pre-built | BYO | Proprietary | Proprietary |
| License | MIT | Apache 2.0 | Commercial | Commercial |
| Deployment | Single Helm chart | Multiple | Agent + SaaS | Agent + SaaS |

### Key Differentiators

- **Unified pipeline** — detect → enrich → AI analyze → dashboard, all in one Helm chart
- **Privacy-first AI** — PII stripped before any LLM contact, with Ollama option for fully on-cluster analysis
- **Cloud-agnostic** — works on EKS, GKE, AKS, self-hosted, and even **Talos Linux**

### New Features

- **Trivy integration** — container image vulnerability scanning via `trivy` CLI
- **hostNetwork webhook exception** — documented workaround for clusters requiring hostNetwork pods

---

## 🌐 NIB — NIDS in a Box

### 30+ Custom Suricata Rules

Beyond the 40,000+ ET Open signatures, NIB now ships with **30+ custom rules** tuned for self-hosted environments:

- SSH brute force and credential stuffing detection
- DNS tunneling and exfiltration attempts
- Suspicious outbound connections (crypto mining, C2 beacons)
- Web application attack patterns (SQLi, XSS, path traversal)
- Protocol anomalies and policy violations

These are enabled by default — no ruleset tuning required.

### Switch Vendor Guides

For sensor mode (port mirroring), NIB now includes step-by-step configuration guides for:

- **UniFi** — Port mirroring via the controller UI
- **TP-Link** — Smart managed switch mirror config
- **MikroTik** — RouterOS packet sniffing setup
- **Cisco** — SPAN session configuration
- **Netgear** — ProSAFE port mirroring

### NIC Recommendations

Network capture performance depends heavily on your NIC. The docs now include recommended NICs by tier — from budget home lab options to enterprise 10Gbps+ cards — with tested capture rates and driver notes.

### Additional Bouncers

CrowdSec blocking now documented for more targets beyond iptables:

- **AWS WAF** — block at the CDN/load balancer level
- **nginx** — block at the reverse proxy
- **HAProxy** — block at the load balancer
- **Cloudflare** — block before traffic reaches your infrastructure

You can run multiple bouncers simultaneously.

### New Commands

- `make update-intel` — refresh CrowdSec threat intelligence
- `make metrics` — show Suricata and CrowdSec statistics
- `make check-ports` — verify network interface configuration
- `make validate` — test the full detection pipeline

---

## 🔭 OIB — Observability in a Box

### Component Versions Documented

The docs now list exact versions for all stack components: Grafana 11.3.1, Loki 3.3.2, Tempo 2.6.1, Prometheus v2.48.1, Alloy v1.5.1, cAdvisor v0.47.2, and Blackbox Exporter v0.25.0.

### New Sections

- **Configuration reference** — all environment variables documented with defaults
- **Data retention** — per-signal retention settings (Loki, Prometheus, Tempo, Pyroscope) and disk usage estimation
- **Security** — authentication, network isolation, and production hardening recommendations
- **Alloy UI** — debug endpoints at `localhost:12345` for pipeline troubleshooting

### New Commands

- `make install-profiling` — add Pyroscope continuous profiling
- `make ps` — container status overview
- `make bootstrap` — generate example `.env` from template
- `make disk-usage` — check storage consumption per signal
- `make version` — show component versions

---

## What's Next

All five product pages on the site have been updated to match their current state. If you notice anything out of date, [open an issue](https://github.com/matijazezelj/in-a-box-tools-tech/issues) or let me know on [Reddit](https://reddit.com/u/matijaz).

Next on the roadmap:
- **DIB** — Database observability in a Box
- **BIB** — Backup and disaster recovery in a Box

Happy monitoring! 🔭
