---
layout: post
title: "SIB-K8s: Security Monitoring Built for Kubernetes"
date: 2026-01-15
description: "Announcing SIB-K8s — SIEM in a Box for Kubernetes, with multi-cloud audit support, AI-powered analysis, and Helm chart deployment."
categories: [release]
---

Kubernetes security monitoring has a problem: the tools are either too complex to set up or too generic to be useful. SIB-K8s fixes that.

## What Is It?

**SIB-K8s** is [SIB](/products/sib/) rebuilt specifically for Kubernetes environments. Instead of Docker Compose and host-level Falco, you get a Helm chart that deploys security monitoring directly into your cluster.

```bash
helm install sib-k8s sib-k8s/sib-k8s -n sib-k8s
```

That's it. Full runtime security monitoring across your entire cluster.

## Multi-Cloud Audit Support

The biggest feature: native audit log integration for all three major cloud providers.

| Provider | Integration |
|----------|-------------|
| **AWS EKS** | CloudWatch audit log forwarding |
| **GCP GKE** | Cloud Logging audit integration |
| **Azure AKS** | Diagnostic settings audit stream |

SIB-K8s normalizes these different formats into a single view. Whether you're running EKS, GKE, AKS, or self-hosted K8s, you see the same dashboards.

## AI-Powered Analysis with Privacy

Like SIB, SIB-K8s includes optional AI-powered alert analysis. But in Kubernetes environments, the data sensitivity is often higher — service account tokens, namespace configurations, RBAC details.

So we built privacy obfuscation directly into the analysis pipeline. All PII is stripped before anything reaches an LLM, and you can use Ollama to keep everything on-cluster.

## Who Should Use This?

If you're already running SIB on bare metal or VMs, and you also have Kubernetes clusters — SIB-K8s gives you the same level of visibility in K8s without the Docker Compose approach.

[Check it out on GitHub](https://github.com/matijazezelj/sib-k8s) or [read the full docs](/products/sib-k8s/).
