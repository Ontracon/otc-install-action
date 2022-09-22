# Overview

Install necessary tools on github runner (ubuntu-latest) if not preinstalled.

# Overview

This composite action runs installation on the github runner. The action run's only on ubuntu / debian based systems.

Installs the following packages when not installed:

-   terraform
-   tflint
-   inspec
-   checkov
-   rpl
-   xml tools

## Basic usage

```yaml
- id: Install
  name: Test - Check & Install Toolset without override
  uses: Ontracon/otc-install-action@main
```

## Usage with override Settings

```yaml
- id: Install_override
  name: Test - Check & Install Toolset with override
  uses: Ontracon/otc-install-action@main
  with:
    OVERRIDE_LOCAL_VERSION: 'true'
```

## GitHub Action inputs

In the following table you can find the GitHub Action Inputs and the mapping to the shell command line switches.

| GitHub Action Inputs   | Description                                                                             | Mandatory | Maps to |
| ---------------------- | --------------------------------------------------------------------------------------- | --------- | ------- |
| OVERRIDE_LOCAL_VERSION | Overrides the local Version of terraform, tflint and uses the version from /src/install | ✗         | -o      |
