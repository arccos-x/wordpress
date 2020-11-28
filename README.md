# HA Wordpress Terraform configuration

This terraform configuration contains everything you need to configure and deploy highly available and scalable Wordpress

## AWS services

The main motivation behind the selection of services is to use as many serverless components as possible.

- ECS Fargate 
- Application Load Balancer
- Aurora Serverless
- EFS (Elastic File System) 
- CloudFront as CDN

Before we start, you'll need to install some 3d-party softrware to be able to enjoy this setup

## Dependencies

To start testing this configuration you'll need next tools to be installed in your system:
- terraform cli
- direnv

> Tools installation guide for Ubuntu system:
```shell
$: curl -sfL https://direnv.net/install.sh | bash
$: echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
$: source ~/.bashrc
```

## Credentials

Please, make a copy of `.envrc.example` file and change paceholders in a new `.envrc` file with your credentials and desired DB username/password 

# Infrastructure tests

## Tools that used for testing of the current infrastructure: 
- [Atlantis](https://www.runatlantis.io/)
- [Terratest](https://terratest.gruntwork.io/)

## The main idea of these tools

Atlantis is an application for automating Terraform via pull requests. It is deployed as a standalone application into the current infrastructure on ECS Fargate and (I hope) has an integration with GitHub. No third-party has access to your credentials.
It configured to use a custom workflow (`atlantis.yml` file), which triggers terratest.

Terratest file (`tests/` folder) will apply current infrastructure and will check whether our Wordpress site turn HTTP 200 or not.

And I still cannot manage my time to properly finish this task, but I hope that the main idea is clear