---
layout: post
title: "[MLS-C01] [Algorithms] Regression Algorithms"
date: 2022-07-18 11:04
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

## Defined

![[defined-regression.png]]

- Supervised learning algorithm
- Performs a regression task where it models a target (dependent variable) prediction based on a vector of independent  variables
- For linear regression the goal is to find the best-fit regression line through the independent variable(s) as related to the dependent variable
- Minimize error between predicted value and observed value in the training data

## Use Cases

1. Optimizing pricing for product line
2. Predicting whether a customer will default on a loan
3. Predicting whether a patient has cancer based on image scan data
4. Predicting user churn
5. Sales forecasting
6. Predict whether a voter will select a candidate or not
7. Predict house prices

## SageMaker Algorithms

### Linear Learner

- Input a set of hight-dimensional vectors including a numeric target, or label
- Target is a real number
- Learns a linear function and maps a vector to an approximation of the target
- Good model based on Linear Learner optimizes
    - Continuous objective: `mean square error`, `cross entropy loss`, `absolute error`
- Requires a data matrix of observations across dimension of features
- Also requires a target column across the observations
- Important Hyperparameters
    1. `feature_dim`: number of feature in the input
    2. `predictor_type`: type of the target variable (regressor for regression problems)
    3. `loss`: specifies the loss function (auto, squared_loss, absolute_loss, etc.)

### XGBoost

- Implementation of gradient boosted tress algorithm
- Supervised learning algorithm for predicting a target by combining the estimates from a set of simpler models
- Requires a data matrix of observations across dimension of features
- Also requires a target column across the observations
- Can differentiate the importance of features through weights
- Example use case: predict income based on census data
- Important Hyperparameters
    1. `num_round`: number of rounds the training runs
    2. `objective`: learning task and learning objective (i.e. `reg:logistic`, `reg:squarederror`)

### K-Nearest-Neighbors

- Finds the k closest points to the sample point and gives a prediction of the average of their features
- Indexed based
- Objective: build k-NN index to allow for efficient determination of the distance between points
- Train to construct the index
- Use dimensionality reduction to avoid the "curse of dimensionality"
- Example use case: predict student absenteeism using student grades, demographic, social, and school related features
- Important Hyperparameters
    1. `feature_dim`: number of feature in the input
    2. `k`: number of nearest neighbors
    3. `predictor_type`: regressor for regression problems
    4. `sample_size`: number of data points to be samples from the training dataset
    5. `dimensionality_reductoin_target`: target dimension to reduct to

### Factorization Machines

- Extension of linear model used on high dimensional sparse datasets
- Typically used for sparse datasets such as click prediction and item recommendation
- Continuous objective: Root Mean Square Error
- Example use case: analyze the images of handwritten digits
- Important Hyperparameters
    1. `feature_dim`: number of feature in the input
    2. `num_factors`: dimensionality of factorization
    3. `predictor_type`: regressor for regression problems

## Labs

1. [LinearLearnerModel.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/code/05-algorithms/03-regression-algorithms/LinearLearnerModel.ipynb "LinearLearnerModel.ipynb")
2. [client.py](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/code/05-algorithms/03-regression-algorithms/client.py "client.py")
3. [day.csv](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/code/05-algorithms/03-regression-algorithms/day.csv "day.csv")
