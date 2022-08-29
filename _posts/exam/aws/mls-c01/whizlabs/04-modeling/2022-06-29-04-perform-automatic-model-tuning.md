---
layout: post
title: "[MLS-C01] [Modeling] Perform automatic model tuning"
date: 2022-06-29 14:26
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

Model tuning is part of the iterative model improvement cycle

![[iterative-model-improvement-cycle.png]]

## Tuning and Evaluating

Machine Learning with SageMaker

- Generate example data to use in training
- Train the model to make predictions, or inferences
- Deploy the model to an endpoint
- Evaluate the model and find the hyperparameters to produce the most accurate, best performing model
    - Run a hyperparameter tuning job

## Evaluate the Model

- After training and deploying the model, evaluate it to determine performance and accuracy
- Often generate multiple models with different algorithms/hyperparameters and evaluate each 
- Two different validation approaches
    - `Offline testing`: use historical data to send requests to the model for inferences
    - `Online testing with live data`: use production variants
- Options for offline evaluation
    - `Holdout set`: set aside a subset of the data for evaluation after training
    - `K-fold validation`: split the example dataset into k parts, treat each as a holdout set for k training runs

## Hyperparameter Tuning Job

- Finds the best version of a model by running many training jobs on your dataset using the algorithm and specified ranges of hyperparameters
- Chooses the hyperparameter values that result in a model that performs the best, as measured by a specified metric
- Use automatic model tuning with built-in algorithms, custom algorithms, and SageMaker pre-built containers for machine learning frameworks
- Prerequisite: successfully run at least one training job
- Two hyperparameter search approaches
    - Random search: random combination of hyperparameter value from within the specified ranges
    - Bayesian search: treats hyperparameter tuning like a regression problem

### Define Metrics

- Built-in algorithms automatically send metrics to hyperparameter tuning
    - Choose one of the metrics as the objective metric for the tuning job
- Custom algorithms must emit at least one metric to stderr or stdout

![[model-metrics.png]]

### Define Hyperparameter Ranges

Finds best hyperparameter values by searching over ranges of hyperparameters

Specify hyperparameters and value ranges to search

![[hyperparameters-ranges.png]]

### Hyperparameter Scaling

- Integer and continuous hyperparameter ranges

    choose the scale for hyperparameter tuning to use to search the range of values using Scaling Type

    - `Auto`: chooses the best scale
    - `Linear`: searches values in range using a logarithmic scale
    - `Logarithmic`: searches values in range using a logarithmic scale
        - Only work for values greater than 0
        - Use when searching a range that spans several orders of magnitude
    - `ReverseLogarithmic`: searches values in range using a revers logarithmic scale
        - Use when searching continuous hyperparameter ranges between 0 and 1.0
        - Use when  searching a range that is highly sensitive to small changes that are very close to 1


