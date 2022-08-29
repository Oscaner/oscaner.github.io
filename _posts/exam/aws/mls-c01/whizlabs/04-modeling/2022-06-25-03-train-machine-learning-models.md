---
layout: post
title: "[MLS-C01] [Modeling] Train machine learning models"
date: 2022-06-25 21:50
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

Training the model is part of the iterative model improvement cycle

![[iterative-model-improvement-cycle.png]]

## Training & Inference Instances

Training and inference instances for SageMaker built-in algorithms

![[sagemaker-built-in-algorithms.png]]

## The Steps of Training ML Model

### 1. Gather/Engineer

- Gather/engineer data into your dataset

![[training-ml-model--gather-engineer.png]]

### 2. Randomize & Split

- Randomize the dataset
- Split the dataset into train and test datasets

![[training-ml-model--randomize-&-split.png]]

### 3. Choose Algorithm

- Choose best algorithm

![[training-ml-model--choose-algorithm.png]]

### 4. Load Container & Define Hyperparameters

- Load container for chosen model
- Manage compute capacity
- Create an instance of chosen model
- Define the model's hyperparameter values

![[training-ml-model--load-container-&-define-hyperparameters.png]]

### 5. Train the Model

- Train the model

![[training-ml-model--train-the-model.png]]

![[activity-of-machine-learning.png]]

### 6. Deploy the Model

Deploy in one of two ways

- Persistent endpoint to get one prediction at a time: SageMaker Hosting Services
- Get predictions for an entire dataset: SageMaker Batch Transform

#### SageMaker Hosting Services

SageMaker provides an HTTPS endpoint, making your model available for inference requests

Three steps:

1. Create model in SageMaker
2. Create an endpoint configuration
3. Create HTTPS endpoint

#### SageMaker Batch Transform

![[lifecycle-batch.png]]

SageMaker batch transform provides inferences for an entire dataset

Three steps:

1. Create batch transform job using trained model and dataset
2. Run the batch transform job
3. SageMaker saves in a results S3 bucket

## Labs

- [train-deploy-evaluate-model.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/code/04-modeling/train-deploy-evaluate-model.ipynb "train-deploy-evaluate-model.ipynb")
- [adult_census_clean.csv](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/code/04-modeling/adult_census_clean.csv "adult_census_clean.csv")
- [[2022-06-24-01-introduction#SageMaker Hosting Services|SageMaker Hosting Services]]
- [XGBoost Algorithm - Amazon SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/xgboost.html)

