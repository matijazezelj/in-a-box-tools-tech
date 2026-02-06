---
layout: page
title: About
permalink: /about/
---

## The Story Behind "In a Box Tools"

I've been tinkering with infrastructure since the early 2000s — starting as a homelabber running servers in my bedroom, then turning that obsession into a career in the late 2000s. From sysadmin to DevOps to SecOps, I've worked on systems handling petabytes of data and hundreds of thousands of requests per second.

**And in all that time, one thing hasn't changed: most teams have no idea how their applications actually behave in production.**

I don't mean that as criticism. It's not their job to know the internals of Prometheus or wrestle with Loki configurations. They're busy writing features, fixing bugs, shipping code.

But the gap between "it works on my machine" and "it works at scale" is where careers get made or broken — and where outages happen at 3 AM.

---

## The Three Jobs Problem

Here's something I've learned: **what used to take me three separate jobs worth of knowledge, I can now set up in 8 hours.**

- A metrics stack? That was a job in itself at many companies.
- A logging infrastructure? Same story.  
- Security monitoring? Don't even get me started.

But now, with containers and modern tooling, all of that complexity can be tamed. The problem is, someone still has to do the taming.

That's where "In a Box" comes in.

---

## Why This Exists

Setting up proper infrastructure tooling is still annoying. You need:

- A metrics stack (Prometheus, exporters, maybe a pushgateway)
- A logging stack (Loki or Elasticsearch, log shippers, retention policies)
- A tracing stack (Tempo or Jaeger, instrumentation, sampling)
- Security monitoring (if you're doing it right)
- Grafana to visualize all of it
- Everything wired together correctly
- Dashboards that actually show useful information

That's a lot of YAML. A lot of documentation. A lot of "I'll do it later" that turns into never.

I get it. I've set this up dozens of times and it still takes me a few hours to do it right. For someone who just wants to see if their app is healthy, the barrier is too high.

---

## The "In a Box" Philosophy

Each product in the "In a Box" family follows the same principles:

### 1. One Command
Clone the repo, run `make install`, done. No 50-page setup guides. No prerequisite reading.

### 2. Opinionated Defaults
Sensible configuration out of the box. The defaults are production-grade, not just "it compiles."

### 3. No Vendor Lock-In
100% open source. All data stays on your infrastructure. MIT and Apache 2.0 licenses.

### 4. Self-Contained
Everything runs in Docker. No cloud dependencies, no external services required.

### 5. Production Patterns
The same tools and configurations used at scale. Learn once, use anywhere.

---

## Current Products

### 🔭 OIB - Observability in a Box
The complete Grafana LGTM stack (Loki, Grafana, Tempo, Mimir/Prometheus). Pre-built dashboards, automatic container log collection, OpenTelemetry support.

[Learn more →](/products/oib/)

### 🛡️ SIB - SIEM in a Box
Runtime security monitoring with Falco, MITRE ATT&CK mapping, Sigma rule support, threat intel feeds, and fleet management.

[Learn more →](/products/sib/)

### ☸️ SIB-K8s - SIEM in a Box for Kubernetes
Kubernetes-specific security monitoring with multi-cloud audit support (EKS, GKE, AKS), AI-powered analysis with privacy obfuscation, and Helm chart deployment.

[Learn more →](/products/sib-k8s/)

### 🌐 NIB - NIDS in a Box
Network intrusion detection with Suricata IDS and CrowdSec automated blocking. 40,000+ signatures, TLS fingerprinting, router integration, and community threat intelligence.

[Learn more →](/products/nib/)

### 🗺️ AIB - Assets in a Box
Infrastructure asset discovery and dependency mapping. Parse Terraform, Kubernetes, and Ansible to build a unified graph with blast radius analysis and certificate tracking.

[Learn more →](/products/aib/)

---

## What's Next

The "In a Box" family is growing. Future products might include:

- **DIB** - Database in a Box (database observability and performance monitoring)
- **BIB** - Backup in a Box (disaster recovery)

Want to see one of these? [Let me know](https://reddit.com/u/matijaz).

---

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=matijazezelj/oib,matijazezelj/sib,matijazezelj/sib-k8s,matijazezelj/nib,matijazezelj/aib&type=Date)](https://star-history.com/#matijazezelj/oib&matijazezelj/sib&matijazezelj/sib-k8s&matijazezelj/nib&matijazezelj/aib&Date)

---

## About Me

I'm Matija Žeželj. I build infrastructure tools because I'm tired of watching smart people struggle with problems that shouldn't be problems.

Find me on:
- [GitHub](https://github.com/matijazezelj)
- [Reddit](https://reddit.com/u/matijaz)

If you build something cool with these tools, I'd love to hear about it.
