---
layout: post
title: "[MLS-C01] [Data Engineering] Introduction"
date: 2022-05-10 21:42
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

## Data preparation

Seven steps to prepare you data for use in a machine learning model

1. Gather your data
2. Handle missing data
3. Feature extraction
4. Decide which features are important
5. Encode categorical values
6. Numeric feature engineering
7. Split your data into training and testing datasets

## Gather Data

Gather data for the problem at hand

- Gather unique data
- Publicly available data
    - Kaggle
    - Reddit
    - Google Dataset Search
    - UCI Machine Learning Repository
- Scrape HTML pages
    - Beautiful Soup

## Handle Missing Data

![[example-missing-data.png]]

Several approaches to the problem

- Null value replacement
- Mode/median/average value replacement
- Remove the entire record
- Model-based imputation
    - Regression
    - K-Nearest Neighbors
    - Deep Learning
- Interpolation / Extrapolation
- Forward filling / Backward filling
- Hot deck imputation

## Feature Extraction

- AKA Dimensionality Reduction
    - Reduce the number of features by creating new features from existing features

![[aka-dimensionality-reduction.png]]

## Feature Selection

- Rank the importance of existing features
- Remove less important features
    ![[remove-less-important-features.png]]
- Use Principal Component Analysis (PCA)
    - An unsupervised learning algorithm that reduces the number of features while still retaining as much information as possible

## Encode Categorical Values

- Encode categorical data to integers
    - Be careful with ordinal values
- One-hot-encoding: Change nominal categorical values such as `true`, `false`, or `rainy`, `sunny` to numerical values
    ![[one-hot-encoding.png]]

## Numerical Feature Engineering

- Transform numeric values so machine learning algorithms can better analyze them
- Change numeric values so all values are on the same scale
    - Normalization: rescales the values into a range of `[0, 1]`
    - Standardization: rescales data to have a mean of 0 and a standard deviation of 1 (unit variance)
    - Binning

## Training and Testing Datasets

- Split dataset into a training subset and a testing subset
    - Typically a 80%, 20% split

![[lab-split-dataset.png]]

## Labs

- [MachineLearningCertification-1.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/MachineLearningCertification-1.ipynb "MachineLearningCertification-1.ipynb")

