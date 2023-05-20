# Script, confiuration and application to deploy a cloud image hosting solution in an automated and resilient approach

[![version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/EthanAndreas/CloudAppDeployment)
[![author](https://img.shields.io/badge/author-EthanAndreas-blue)](https://github.com/EthanAndreas)
[![author](https://img.shields.io/badge/author-LosKeeper-blue)](https://github.com/LosKeeper)

## Table of Contents

- [Script, confiuration and application to deploy a cloud image hosting solution in an automated and resilient approach](#script-confiuration-and-application-to-deploy-a-cloud-image-hosting-solution-in-an-automated-and-resilient-approach)
  <br>

  - [Table of Contents](#table-of-contents)
  - [Abstract](#abstract)
  - [Deployment](#deployment)
    - [Create application docker image](#create-application-docker-image)
    - [Deploy the application](#deploy-the-application)
  - [Features and limitations](#features-and-limitations)
    - [Features](#features)
    - [Limitations](#limitations)

## Abstract

This project is a collection of scripts, configuration files and applications to deploy a cloud image hosting solution in an automated and resilient approach. The project is based on the following technologies:

- [Consul](https://www.consul.io/)
- [Docker](https://www.docker.com/)
- [Keepalived](https://www.keepalived.org/)
- [Nomad](https://www.nomadproject.io/)

## Deployment

<br>

### Create application docker image

<br>

Frontend image :

```yaml
• cd web
• docker build -t frontend .
• docker tag frontend <registry>/frontend:<tag>
• docker push <registry>/frontend:<tag>
```

Backend image :

```yaml
• cd api
• docker build -t worker .
• docker tag worker <registry>/worker:<tag>
• docker push <registry>/worker:<tag>
```

``<registry>`` is the Github registry where you want to push the image with their version ``<tag>``.

<br>

### Deploy the application

<br>

Deploy all the roles (Consul, Nomad, KeepAlived, Docker) :

```yaml
ansible-playbook -i inventory/hosts.ini deploy.yml
```

Deploy only one role :

```yaml
ansible-playbook -i inventory/hosts.ini deploy.yml --tags <role>
```

``<role>`` is the role you want to deploy (``consul``, ``nomad``, ``keepalived``, ``docker``).

## Features and limitations 

<br>

### Features

- The application is deployed in an automated way, the deployment is done with Ansible.
- The application is deployed in a resilient way, the frontend and the backend are deployed on two different nodes, the load balancer is deployed each node.
- The application is deployed in a scalable way, nodes can be added to the cluster without any problem.
- The application is secured against breakdowns, it used Consul and Nomad, and the IP address connected to the web interface of the application is a floating IP address.


### Limitations

- The application is not fully functional, the frontend is not able to communicate with the backend, the load balancer is not able to redirect the traffic to the frontend.