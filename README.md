# HA Wordpress Terraform configuration

This terraform configuration contains everything you need to configure and deploy highly available and scalable Wordpress

## AWS services

The main motivation behind the selection of services is to use as many serverless components as possible.

- ECS Fargate 
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

p.s. Run out of time, didn't have time to make a good description of the infrastructure.