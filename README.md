# tf-grafana

![terratest](https://github.com/soerenschneider/tf-grafana/actions/workflows/terratest.yaml/badge.svg)
![lint-workflow](https://github.com/soerenschneider/tf-grafana/actions/workflows/lint.yaml/badge.svg)
![security-workflow](https://github.com/soerenschneider/tf-grafana/actions/workflows/security.yaml/badge.svg)

This repository implements Infrastructure as Code (IaC) using [OpenTofu](https://opentofu.org/) to configure Grafana instances and write service account credentials to Hashicorp Vault.

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)

## Getting Started

Follow these instructions to set up the repository and start managing your Grafana and Vault resources.

### Prerequisites

- [OpenTofu](https://opentofu.org/)
- Terragrunt
- Docker-compose

### Running the code

1. **Clone the repository:**
   ```bash
   git clone https://github.com/soerenschneider/tf-grafana.git
   cd tf-grafana
   ```

2. **Provisioning resources:**
   ```bash
   cd envs/dev
   bash run.sh
   ```

### Tests

This repository utilizes Terratest for automated testing of OpenTofu modules and configurations.

1. **Running the tests:**
   ```bash
   $ make tests
   ```
