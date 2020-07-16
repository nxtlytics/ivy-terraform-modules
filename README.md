# Infrastructure Terraform modules

## Overview

Here we will keep track of all terraform modules used to fill the gaps in Ivy infrastructure

## Requirements

- Terraform v0.12.19

### pre-commit requirements

*Note*: You do not need to install pre-commit to work with this repo.

- [pre-commit](https://pre-commit.com/#install) 2.0.1
- GNU AWK (`brew install gawk`) 5.0.1
- terraform-docs 0.8.2

## Structure

```
├── README.md
└── <Cloud Provider>
    └── <Module>
        ├── config.tf
        ├── main.tf
        └── variables.tf
```

## Useful Links

- [Creating Terraform modules](https://www.terraform.io/docs/modules/index.html)
- [Terraform modules](https://www.terraform.io/docs/configuration/modules.html)
- [pre-commit hooks](https://pre-commit.com/#install)
- [terraform/terragrunt pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform)
