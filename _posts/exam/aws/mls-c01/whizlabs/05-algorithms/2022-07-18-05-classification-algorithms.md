---
layout: post
title: "[MLS-C01] [Algorithms] Classification Algorithms"
date: 2022-07-18 14:17
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

![[defined-classification.png]]

- Supervised learning algorithm
- Learns from training data then uses the result to classify new observations
- Two types: `binary-class` or `multi-class`

## Use Cases

1. Voter prediction
2. Customer loan default
3. Object detection
4. Image classification
5. Fraud detection
6. Customer segmentation
7. Product classification

## SageMaker Algorithms

### Linear Learner

- Input a set of high-dimensional vectors including a numeric target, or label
- Target is 0 or 1 for binary classification
- Learns a linear threshold function and maps a vector to an approximation of the target
- Good classification model based on Linear Learner optimizes
    - Discrete objectives suited for classification, such as `F1 measure`, `precision`, `recall`, or `accuracy`.
- Requires a data matrix of observations across dimension of features
- Also requires a target column across the observations
- Example use case: predict event outcome - win or lose
- Important Hyperparameters
    1. `feature_dim`: number of feature in the input
    2. `predictor_type`: type of the target variable (`binary_classifier` or `multiclass_classifier`)
    3. `loss`: specifies the loss function (`auto`, `logistic`, `hinge_loss`, `softmax_loss`)

### Blazing Text

- Implements the Word2vec and text classification algorithms
- Useful for many downstream natural language processing (NLP) tasks, such as `sentiment analysis`, `named entity recognition`, `machine translation`
- Also useful for applications that `perform web searches`, `information retrieval`, `ranking`, and `document classification`
- Maps words to vectors
- Resulting vector representation of a word is called a word embedding
- Words that are semantically similar correspond to vectors that are close together, resulting that word embeddings capture the semantic relationships between words
- Example use case: spam detection using detection of common spam phrases like "you're a winner !"
- Important Hyperparameters
    1. `mode`: Word2vec architecture for training (`batch_skipgram`, `skipgram`, `cbow`)

### XGBoost

- Implementation of gradient boosted trees algorithm
- Supervised learning algorithm for predicting a target by combining the estimates from a set of simpler models
- Requires a data matrix of observations across dimension of features
- Also requires a target column across the observations
- Can differentiate the importance of features through weights
- Example use case: predict default on credit card payments
- Important Hyperparameters
    1. `num_round`: number of rounds the training runs
    2. `num_class`: the number of classes
    3. `objective`: learning task and learning objective (i.e. `reg:logistic`, `multi:softmax`)

### K-Nearest Neighbors

- Finds the k closest points to the sample point and gives a prediction of the average of their features
- Index based
- Objective: build k-NN index to allow for efficient determination of the distance between points
- Train to construct the index
- Use dimensionality reduction to avoid the "curse of dimensionality"
- Example use case: predict wilderness tree types from geological and forest service data
- Important Hyperparameters
    1. `feature_dim`: number of feature in the input
    2. `k`: number of nearest neighbors
    3. `predictor_type`: classifier for classification problems
    4. `sample_size`: number of data points to be samples from the training dataset
    5. `dimensionality_reductoin_target`: target dimension to reduce to

### Factorization Machines

- Extension of linear model used on high dimensional sparse datasets
- Typically used for sparse datasets such as `click prediction` and `item recommendation`
- Scored using `Binary Cross Entropy (Log Loss)`, `Accuracy (at threshold=0.5)` and `F1 Score (at threshold=0.5)`
- Example use case: item recommendation
- Important Hyperparameters
    1. `feature_dim`: number of feature in the input
    2. `num_factors`: dimensionality of factorization
    3. `predictor_type`: `binary_classifier` for classification problems

### Image Classification

- Supervised learning algorithm that supports multi-label classification
- Takes an image as input and outputs one or more labels assigned to that image
- Uses a convolutional neural network (ResNet) that can be trained from scratch or trained using transfer learning when a large number of training images are not available
- Recommended input format is RecordIO, but can also use raw images in `.jpg` or `.png` format.
- Example use case: classify image content as offensive or not for Twitter feed posts
- Important Hyperparameters
    1. `num_classes`: the number of output classes
    2. `num_training_samples`: Number of training examples in the input dataset

### Random Cut Forest

- Unsupervised algorithm for detecting anomalous data points within a data set
- Uses an anomaly score
    - Low score indicates data point is considered normal, high score indicates the presence of an anomaly in the data
    - Definition of "low" and "high" depend on the application, common practice: scores beyond three standard deviations from the mean score are considered anomalous
- Requires a target column across the observations
- Example use case: find exceptions in streaming trade data
- Important Hyperparameters
    1. `feature_dim`: number of feature in the input
    2. `eval_metrics`: List of metrics used to score a labeled test data set (`accuracy`, `precision_recall_fscore`)
    3. `num_trees`: Number of trees in the forest

## Labs

1. [bank-additional-full.csv](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/05-algorithms/05-classification-algorithms/bank-additional-full.csv "bank-additional-full.csv")
2. [client.py](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/05-algorithms/05-classification-algorithms/client.py "client.py")
3. [XGBoost Classification Example.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/05-algorithms/05-classification-algorithms/XGBoost%20Classification%20Example.ipynb "XGBoost Classification Example.ipynb")
