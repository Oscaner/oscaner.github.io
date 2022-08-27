---
layout: post
title: "[MLS-C01] [Introduction] Machine Learning Terminology"
date: 2022-05-09 20:31
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - exam
  - aws
  - mls
tags:
  - Exam
  - AWS
  - MLS
---

## Categories

- Data Engineering
- Data Analysis
- Modeling
- Algorithms
- Implementation and Operations

## Datasets

![[datasets.png]]

1. `Datasets`: A collection of data used as the "fuel" for our machine learning models.
2. `Features`: describe information about your data set in a columnar way.
3. `Observations`: describing your data as each instance of a set of features.

## Dataset Types

- Datasets can be comma separated or JSON
- Datasets can also be images, audio, or video

## Ways to organize data

- `Structured data`: has a schema
    - Example: table of values such as a relational database table
- `Unstructured data`: doesn't have a schema
    - Example: PDFs, images, video, audio, logs, tweets
- `Semi-structured data`: contains tags to separate semantic elements and enforce hierarchies
    - Examples: CSV, JSON, XML

## Labeled/Unlabeled Data

- `Labeled data`: Has a target attribute
- `Unlabeled data`: No target attribute

## Supervised/Unsupervised Learning

![[supervised-unsupervised-learning.png]]

- `Supervised Learning`: Mostly used with labeled data
- `Unsupervised Learning`: Mostly used with unlabeled data

## Categorical/Continuous Features

- `Categorical features`
    - Made up of a set of categories
    - They describe the quality not quantity
    - They are distinct
- `Continuous features`
    - They describe the quantity not the quality

## Corpus Data

- Data collected from text
- Used in Natural Language Processing (NLP)
- Speech recognition, text-to-speech

## Ground Truth Data

Data that has been labeled either by human labelers or by machine learning algorithms.

![[ground-truth-data.png]]
