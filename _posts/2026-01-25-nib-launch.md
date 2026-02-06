---
layout: post
title: "Introducing NIB: Network Security That Fights Back"
date: 2026-01-25
description: "NIB (NIDS in a Box) brings Suricata IDS and CrowdSec automated blocking together in a single deployment. Detect, block, and share."
categories: [release]
---

Most network security tools detect and alert. They assume someone is watching the dashboard at 3 AM when the port scan starts. Nobody is.

**NIB** does something different: it detects, blocks, and shares.

## The Stack

- **Suricata** inspects every packet with 40,000+ signatures
- **CrowdSec** automatically bans attacking IPs — locally, on your router, or at your CDN
- **Community threat intelligence** means you benefit from attacks detected by millions of other CrowdSec nodes before they reach you

```bash
git clone https://github.com/matijazezelj/nib.git && cd nib
cp .env.example .env
make install
```

## Two Deployment Modes

**Local mode** runs on the host you want to protect. Suricata sees the traffic, CrowdSec drops attackers via iptables. Simple and effective for internet-facing servers.

**Sensor mode** is for dedicated IDS deployments. Configure a SPAN/mirror port on your switch, point it at a NIB host, and CrowdSec pushes bans to your actual router or firewall. Works with MikroTik, pfSense, OPNsense, OpenWrt, and any REST-based firewall.

## Better Together with SIB

NIB and [SIB](/products/sib/) are complementary:

- **SIB** watches what happens **inside** your hosts (syscalls, file access, processes)
- **NIB** watches what happens **on the network** (traffic, DNS, TLS, protocol anomalies)

They run side by side on separate Docker networks and Grafana instances. Cover both attack surfaces.

## Who Is This For?

Anyone running internet-facing services who wants more than just a firewall. Homelab enthusiasts, small companies without dedicated security staff, sysadmins managing Linux servers.

[Get started](https://github.com/matijazezelj/nib) or [read the docs](/products/nib/).
