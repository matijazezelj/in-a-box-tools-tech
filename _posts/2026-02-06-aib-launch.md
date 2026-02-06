---
layout: post
title: "AIB: Know What Breaks Before It Breaks"
date: 2026-02-06
description: "Announcing AIB (Assets in a Box) — infrastructure asset discovery and dependency mapping with blast radius analysis across Terraform, Kubernetes, and Ansible."
categories: [release]
---

Here's a question most infrastructure teams can't answer quickly: **"If this VPC goes down, what else breaks?"**

Your infrastructure is spread across Terraform state files, Kubernetes manifests, and Ansible inventories. Dependencies are implicit. Cross-references span multiple repositories. The full picture lives in someone's head — until they go on vacation.

**AIB** (Assets in a Box) fixes this by parsing your IaC sources and building a unified dependency graph.

## What It Does

```bash
# Scan multiple Terraform state files
aib scan terraform networking.tfstate compute.tfstate data.tfstate

# Cross-state edges resolve automatically
aib impact node tf:network:prod-vpc
```

```
Impact Analysis: tf:network:prod-vpc
   Blast Radius: 4 affected assets

   tf:network:prod-vpc (network)
   ├── [connects_to] tf:subnet:prod-subnet (subnet)
   │   └── [connects_to] tf:vm:web-prod-1 (vm)
   │       └── [depends_on] tf:dns_record:web.example.com (dns_record)
   └── [depends_on] tf:database:cloudsql-prod (database)
```

That's the answer to "what breaks?" — automatically, across state files, with no manual cataloging.

## Multi-Source, Unified Graph

AIB isn't just for Terraform. It parses:

- **Terraform** state files (local and remote backends, multi-workspace)
- **Kubernetes** manifests, Helm charts, and live clusters
- **Ansible** inventories and playbooks

All sources feed into the same graph. A Kubernetes service backed by a Terraform-managed database gets proper edges connecting them.

## Certificate Tracking

AIB also probes TLS endpoints and tracks certificate expiry. When running as a server, it automatically discovers TLS endpoints from your graph (ingresses, load balancers, DNS records) and alerts when certificates approach expiry.

## A Different Kind of "In a Box"

AIB is the first product in the family that isn't Docker Compose + Grafana. It's a single Go binary (~13 MB) with an embedded web UI and SQLite storage. Optional Memgraph integration for advanced graph queries, but not required.

```bash
make build
./bin/aib serve
# Open http://localhost:8080
```

## Who Should Use This?

Infrastructure teams managing multi-cloud environments. SREs planning disaster recovery. Security teams assessing blast radius for risk analysis. Anyone who's ever asked "what depends on this?" and didn't get a quick answer.

[Try it out](https://github.com/matijazezelj/aib) or [read the docs](/products/aib/).
