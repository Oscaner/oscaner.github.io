---
layout: post
title: "[MLS-C01] [Modeling] Modeling Concepts"
date: 2022-06-24 21:47
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

## Types of Machine Learning

![[modeling-tree.png]]

1. Supervised machine learning
2. Unsupervised machine learning
3. Reinforcement machine learning

### Supervised ML

- Target variable (dependent variable) to be predicted from independent variables
- Two types
    - Classification: categorize vectors of independent variables into buckets represented by the dependent variable
    - Regression: identifying patterns in the vectors of independent variables and calculating the prediction of independent variable outcomes
- Most widely used
    - Linear Regression
    - Logistical Regression
    - Random Forest
    - Gradient Boosted Trees
    - Nearest Neighbor
    - Support Vector Machines (SVM)
    - Neural Networks
    - Decision Trees

### Unsupervised ML

- No target or outcome to predict, used for clustering and dimensionality reduction
- Two types
    - Clustering: segment the observations into meaningful groups or clusters based on patterns in the observations
    - Dimensionality reduction: distill the relevant information for the observations while reducing the number of features
- Most widely used
    - k-means Clustering
    - t-Distributed Stochastic Neighbor Embedding
    - Principal Component Analysis (PCA)

### Reinforcement ML

- Trained to make specific decisions, trains itself continuously in an environment using trial and error
- Reward signals generated when a task is performed, tow types:
    - Positive reward signal: encourages continuing performance of the task
    - Negative reward signal: penalizes for performing the task
- Most widely used
    - Q-Learning
    - Temporal Difference (TD)
    - Monte-Carlo Tree Search
    - Asynchronous Actor-Critic Agents (A3C)

## Choosing the ML Approach

1. Discrete or Continuous ?

2. Target variable or not ?

3. Optimizing an objective function through interacting with an environment: Reinforcement Learning

| Data Type | Supervised Learning | Unsupervised Learning |
| :--- | :--- | :--- |
| Discrete | Classification | Clustering |
| Continuous | Regression | Dimensionality Reduction |

## Hyperparameters

A hyperparameter is a parameter whose value is set before the learning process

- Two types
    - Model hyperparameters: influence the performance of the model
    - Algorithm hyperparameters: affect the speed and quality of the learning process
- Each algorithm has its own set of hyperparameter settings
- Automatic model tuning, a.k.a Hyperparameter Tuning
    - Finds the best version of a model by running many training jobs on your dataset using the algorithm and ranges of specified hyperparameters
    - Then selects the hyperparameter values that result in a model that performs the best based on a selected metric
    - Two approaches
        - Random Search: chooses a random combination of values for each training job
        - Bayesian Search: performs hyperparameter tuning as a regression problem

## Training and Evaluating

- Training is done via a training job that includes
    - URL of the S3 bucket that holds the training data
    - Compute resources used for model training (managed by SageMaker)
    - URL of the S3 bucket to store the output of the job (model artifacts)
    - ECS registry path where the training job code is stored
- After training job is created, SageMaker launches the ML instances and uses the training code and training data to train the model and stores the resulting artifacts in the artifact S3 bucket
- Use online or offline testing to evaluate performance and accuracy

## Deploying and Continuously Evaluating

![[iterative-model-improvement-cycle.png]]

Use SageMaker Model Monitor to continuously monitor model quality

- Set alerts for deviations in quality such as data drift
- Steps of Model Monitoring
    - Capture data: enable endpoint to capture data from incoming requests and resulting predictions
    - Create a baseline: from the data used to train the model
    - Schedule monitoring jobs: create monitoring schedule specifying data to collect, how to interpret the data
    - Interpret results: compare latest data with baseline ,watch for violations and metric notifications in CloudWatch
