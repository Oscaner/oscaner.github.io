---
layout: post
title: "[MLS-C01] [IMPL and OPs] Deploy and Operationalize"
subtitle: "Deploy and operationalize machine learning solutions with lab"
date: 2022-08-08 09:49
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

## Lifecycle

![[lifecycle.png]]

1. Create your data
    - Gather, engineer, transform
2. Produce your model
    - Build model and evaluate it
3. Execute (operationalize) your model
    - Deploy, monitor, retrain

## Deployment and Operationalization

![[deployment-and-operationalization.png]]

- Deploy
- Inference
- Metrics
- Monitor performance
- Analysis
- Retrain

### Real-Time

![[activity-of-machine-learning.png]]

### Batch

![[lifecycle-batch.png]]

### Model Monitor

![[lifecycle-model-monitor.png]]

Monitor your production model to detect deviations in data quality compared to a baseline dataset

- Monitor your endpoint using Model Monitor (csv or flat-json)
    1. Baseline
    2. SageMaker suggests baseline constraints
    3. Create baselining job
    4. Create a continuous monitoring schedule
    5. Start continuous monitoring
- Analyze / Retrain

### Performance

- To optimize the performance of your models you can use Automatic Model Tuning to find the hyperparameters that will give you the optimal performance
- You can use SageMaker hosting to automatically scale your model to the performance needed for your model


