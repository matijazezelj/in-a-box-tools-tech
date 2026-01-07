---
layout: page
title: About
permalink: /about/
---

## The Story Behind "In a Box"

I've spent 25 years in infrastructure — starting as a sysadmin, moving through DevOps, and now working in SecOps. Along the way, I've worked on systems handling petabytes of data and hundreds of thousands of requests per second.

And in all that time, one thing hasn't changed: **most teams have no idea how their applications actually behave in production.**

I don't mean that as criticism. It's not their job to know the internals of Prometheus or wrestle with Loki configurations. They're busy writing features, fixing bugs, shipping code.

But the gap between "it works on my machine" and "it works at scale" is where careers get made or broken — and where outages happen at 3 AM.

---

## Why This Exists

Setting up proper infrastructure tooling is annoying. You need:

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

---

## What's Next

The "In a Box" family is growing. Future products might include:

- **CIB** - CI/CD in a Box (self-hosted GitOps)
- **BIB** - Backup in a Box (disaster recovery)
- **NIB** - Network in a Box (mesh networking)

Want to see one of these? [Let me know](https://reddit.com/u/matijaz).

---

## About Me

I'm Matija Žeželj. I build infrastructure tools because I'm tired of watching smart people struggle with problems that shouldn't be problems.

Find me on:
- [GitHub](https://github.com/matijazezelj)
- [Reddit](https://reddit.com/u/matijaz)

If you build something cool with these tools, I'd love to hear about it.
