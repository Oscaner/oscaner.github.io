---
layout: post
title: "[MLS-C01] [Algorithms] Algorithm Concepts"
date: 2022-07-18 10:22
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

## Generalization

![[concepts-generalization.png]]

- Algorithms use example data to create a generalization (a model) that answers your business question
- After creating a model using example data, use it to answer your business question with new data (obtaining an inference)

## Understand the Business Problem

The type of answer sought influences your choice of algorithm.

### Discrete Categories

> Example: Direct mail campaign to solicit political donations

#### Type answers

1. "Considering past solicitation responses, mail to this contributor ?"
    - Binary: `yes/no`
2. "Considering past solicitor segmentation, which segment is the contributor in ?"
    - Multi-class: `small donation`, `significant donation`, `corporate donor`

#### SageMaker built-in algorithms

1. Linear Learner
    set `predictor_type` hyperparameter to `binary_classifier`
2. XGBoost
    set `objective` hyperparameter to `reg:logistic`

### Quantitative

> Example: Direct mail campaign to solicit political donations

#### Type answers

1. "Considering the ROI on past solicitation mailings, what is the ROI for soliciting this donor ?"
    - Quantitative: `higher ROI donors get mailing`

#### SageMaker built-in algorithms

1. Linear Learner
    set `predictor_type` hyperparameter to `regressor`
2. XGBoost
    set `objective` hyperparameter to `reg:linear`

### Discrete Recommendations

> Example: Direct mail campaign to solicit political donations

#### Type answers

1. "Considering past solicitation mailing responses, what is the recommended content for each donor ?"

#### SageMaker built-in algorithms

1. Factorization Machines for recommendations

### Identifying Groups

> Example: Direct mail campaign to solicit political donations

#### Type answers

1. "Group potential and current donors into 12 groups based on their attributes, how should they be grouped ?"

2. Send mailing to donors in the group that has the highest percentage of current donors, i.e. potential donors that are most similar to current donors

#### SageMaker built-in algorithms

1. K-Means

### Dimensionality Reduction

> Example: Direct mail campaign to solicit political donations

#### Type answers

1. "What attributes differentiate donors, what are the relative values for the donors along these dimensions ?"

2. Use to simplify the view of current and prospective donors and gain clarity on value of donor attributes

#### SageMaker built-in algorithms

1. Principal Component Analysis

### Other algorithms

1. Classifying images
    - Image Classification
2. Translation
    - Sequence-to-Sequence
3. Determining topics of sets of documents
    - Latent Dirichlet Allocation
    - Neural Topic Model
4. Text classification
    - Blazing Text
5. Anomaly detection
    - Random Cut Forest
    - k-Nearest-Neighbors

