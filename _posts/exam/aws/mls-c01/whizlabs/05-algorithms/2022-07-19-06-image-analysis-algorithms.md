---
layout: post
title: "[MLS-C01] [Algorithms] Image Analysis Algorithms"
date: 2022-07-19 14:09
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

![[defined-image-analysis.png]]

- Supervised learning algorithms
- Take images as input and either labels the images or identifies objects in the image
- Two image analysis algorithms in the SageMaker built-in algorithms

## Use Cases

1. Facial recognition
2. Airport baggage scanning
3. Analyze social media images for missing persons
4. Real-time vehicle damage assessment
5. Medical image analysis
6. Building entrance security
7. Product line analysis

## SageMaker Algorithms

### Image Classification

- Supervised learning algorithm that supports multi-label classification
- Takes an image as input and outputs one or more labels assigned to that image
- Uses a convolutional neural network (ResNet) that can be trained from scratch or trained using transfer learning when a large number of training images are not available
- Can also seed the training of a new model with the artifacts from a model that you trained previously, called incremental training
- Recommended input format is RecordIO, but can also use raw images in `.jpg` or `.png` format.
- Example use case: classify image of person as on building entry security list
- Important Hyperparameters
    1. `num_classes`: number of output classes
    2. `num_training_samples`: number of training examples in the input dataset
    3. `early_stopping`: define a threshold at which to stop training

### Object Detection

- Supervised learning algorithm
- Detects and classifies objects in images using a deep neural network
- Takes images as input and identifies all instances of objects within the image
- Object is categorized into one of the classes in a collection you specify, with a confidence score assigned to the class
- Location and scale of the object in the image are noted by bounding box
- Can be trained from scratch, or trained with models that have been pre-trained on the ImageNet dataset
- Use input format of RecordIO, but can also use raw images in `.jpg` or `.png` format.
- Example use case: detect objects in baggage at airport scan
- Important Hyperparameters
    1. `num_classes`: number of output classes
    2. `num_training_samples`: number of training examples in the input dataset
    3. `use_pretrained_model`: use a pre-trained model for training


