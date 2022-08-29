---
layout: post
title: "[MLS-C01] [IMPL and OPs] Introduction"
subtitle: "Introduction of Machine Learning Implementation and Operations"
date: 2022-08-07 19:26
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - exam
  - aws
  - mls
  - machine learning
tags:
  - Exam
  - AWS
  - MLS
  - Machine Learning
---

![[activity-of-machine-learning.png]]

## Build solutions

### Performance

- To optimize the performance of your models, you can use Automatic Model Tuning to find the hyperparameters that will give you the optimal performance
- You can use SageMaker hosting to automatically scale your model to the performance needed for your model

### Availability

- SageMaker hosting allows you to configure your endpoints to elastically scale your endpoint instances
- Use two or more endpoint instances in different availability zones to make your endpoints highly available

### Scalability

- SageMaker hosting automatically scales your endpoint instances to the performance needed for your application through Application Auto Scaling
- You can manually adjust the number of instances and the instance type without suffering downtime by modifying your endpoint configuration
- SageMaker scales to large numbers of transactions per second. The actual scale depends on your deployed model and the number and type of instances your model endpoints run on

### Resiliency and Fault Tolerance

- SageMaker automatic scaling endpoint instances scale out and automatically spread instances across multiple availability zones
- This gives you availability zone level fault tolerance and protects from an individual instance failure

## Recommend Appropriate ML Services

![[intro-recommend-services.png]]

- Select from several AWS Services to implement the appropriate Machine Learning solution for your business problem

## Security

- SageMaker model artifacts and other system artifacts are encrypted in transit and at rest
- Requests to your endpoint API and can be mode over a secure (SSL) connection
- Assign IAM roles to your model instance to provide permission to access resources on your behalf for deployment
- Use encrypted S3 buckets for model artifacts and data
- Pass a KMS key to your endpoints to encrypt their attached ML storage volume

## Deploy/Operationalize the Model

- Clients send HTTPS requests to your endpoint to obtain inferences
- Can deploy multiple variants of a model to the same HTTPS endpoint (test variations of your model in production)
- Can also configure a production variant to achieve auto scaling
- You can modify your endpoints without suffering downtime by modifying your endpoint configuration

