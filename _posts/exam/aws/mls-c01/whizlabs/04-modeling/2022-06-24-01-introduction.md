---
layout: post
title: "[MLS-C01] [Modeling] Introduction"
date: 2022-06-24 21:00
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

![[lifecycle.png]]

- Generate example data to use in training
- Train the model to make predictions, or inferences
    1. Use an algorithm and example data to train the model
    2. Evaluate the model for inference accuracy
    3. Integrate model into your application to generate inferences in real time and at scale

## Train the Model

![[activity-of-machine-learning.png]]

### Training Algorithm Options

![[model-training.png]]

- Use a SageMaker built-in algorithm
- Use the SageMaker debugger
- Use Apache Spark with SageMaker
- Use custom deep learning code
- Use your own algorithms
- Use an algorithm from the AWS Marketplace

## Deploy the Model

Deploy in one of two ways

- Persistent endpoint to get one prediction at a time: SageMaker hosting services
- Get predictions for an entire dataset: SageMaker batch transform

### SageMaker Hosting Services

SageMaker provides an HTTPS endpoint, making your model available for inference requests

1. Create model in SageMaker
2. Create an endpoint configuration
3. Create HTTPS endpoint

### SageMaker Batch Transform

![[lifecycle-batch.png]]

SageMaker batch transform provides inferences for an entire dataset

1. Create batch transform job using trained model and dataset
2. Run the batch transform job
3. SageMaker saves in a results S3 bucket

## Evaluate the Model

- After training and deploying the model, evaluate it to determine performance and accuracy
- Often generate multiple models with different algorithms/hyperparameters and evaluate each
- Two different validation approaches
    1. Offline testing: use historical data to send requests to the model for inferences
    2. Online testing with live data: use production variants
- Options for offline evaluation
    - Holdout set: set aside a subset of the data for evaluation after training
    - K-fold validation: split the example dataset into k parts, treat each as a holdout set for k training runs

