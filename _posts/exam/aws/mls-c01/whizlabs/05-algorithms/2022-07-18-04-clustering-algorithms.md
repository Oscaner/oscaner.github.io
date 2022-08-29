---
layout: post
title: "[MLS-C01] [Algorithms] Clustering Algorithms"
date: 2022-07-18 13:24
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

![[defined-clustering.png]]

- Unsupervised learning algorithm
- Attempts to find discrete groupings within data, where members of a group are as similar as possible to one another and as different as possible from members of other groups
- Define the attributes that you want the algorithm to use to determine similarity

## Use Cases

1. Delivery source location
2. Identifying crime centers
3. Customer segmentation
4. Fraud detection based on clusters of fraud patterns
5. Cyber-profiling criminals
6. Clustering of IT alerts
7. Call center recording analysis

## SageMaker Algorithms

### K-Means

- Expects tabular data, where rows represent the observations that you want to cluster, and the columns represent attributes of the observations
- *n* attributes in each row represent a point in *n*-dimensional space
- Euclidean distance between these points represents the similarity of the corresponding observations
- Groups observations with similar attribute values (the points corresponding to these observations are closer together)
- Example use case: using census data find clusters of populations in counties across the US to focus political activity

## Labs

1. [Clustering Lab.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/05-algorithms/04-clustering-algorithms/Clustering%20Lab.ipynb "Clustering Lab.ipynb")
2. [Absenteeism_at_work.csv](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/05-algorithms/04-clustering-algorithms/Absenteeism_at_work.csv "Absenteeism_at_work.csv")
