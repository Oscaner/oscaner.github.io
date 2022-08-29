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

### Gather/Engineer

1. Gather/engineer data into your dataset

![[training-ml-model--gather-engineer.png]]

### Randomize & Split

2. Randomize the dataset
3. Split the dataset into train and test datasets

![[training-ml-model--randomize-&-split.png]]

### Choose Algorithm

4. Choose best algorithm

![[training-ml-model--choose-algorithm.png]]

### Load Container & Define Hyperparameters

5. Load container for chosen model
6. Manage compute capacity
7. Create an instance of chosen model
8. Define the model's hyperparameter values

![[training-ml-model--load-container-&-define-hyperparameters.png]]

### Train the Model

9. Train the model

![[training-ml-model--train-the-model.png]]

## Labs

- [train-deploy-evaluate-model.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/04-modeling/train-deploy-evaluate-model.ipynb "train-deploy-evaluate-model.ipynb")
- [adult_census_clean.csv](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/04-modeling/adult_census_clean.csv "adult_census_clean.csv")
- [[2022-06-24-01-introduction#SageMaker Hosting Services|SageMaker Hosting Services]]
- [XGBoost Algorithm - Amazon SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/xgboost.html)

