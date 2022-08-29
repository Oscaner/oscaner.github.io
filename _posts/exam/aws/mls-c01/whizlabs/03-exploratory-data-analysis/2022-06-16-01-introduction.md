---
layout: post
title: "[MLS-C01] [Exploratory Data Analysis] Introduction"
date: 2022-06-16 21:46
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

![[exploratory-data-analysis.png]]

- Basic data analysis concepts and terminology
- Kinesis Data Streams
- Kinesis Data Firehose
- Kinesis Video Streams
- Kinesis Data Analytics
- Visualize data for machine learning

## Sources

Sources for streaming data

- Kaggle.com
- University of California Irvine
- Open Data on AWS
- Google big query also gives access to data sets

## Kinesis Data Streams

- Gets data from data producers such as IoT, social media
- Uses shards to stream data to consumers such as EC2, Lambda, Kinesis Data Analytics, EMR clusters
- Consumers then send data to a data repository such as S3, DynamoDB, Redshift, or Business Intelligence Tools

![[kinesis-data-streams.png]]

## Kinesis Data Firehose

- Receives data from producers such as IoT, social media
- Uses Lambda functioning instead of shards to transmit producer data
- Lambda function puts data to data stores such as S3, Redshift, ElasticSearch, or Splunk
- Can transmit directly from producers through Firehose to the data store (don't have to use Lambda intermediary)
- S3 events to store to DynamoDB

![[kinesis-data-firehose.png]]

## Kinesis Video Streams

- Build video processing applications such as machine learning models
- Producers such as web cams, security cameras, audio feeds, images
- Data Consumers - Kinesis Video Stream applications
- Stores to S3

![[kinesis-video-streams.png]]

## Kinesis Data Analytics

- Use SQL to process streaming data
- Sources: Kinesis Data Streams and Kinesis Data Firehose
- SQL queries put to S3, Redshift, or visualization and Business Intelligence Tools

![[kinesis-data-analytics.png]]

## Visualizing Data for Machine Learning

- Technique using static and interactive visuals to represent large amounts of data
- Visualizes patterns, trends and correlations that may be difficult to discern
- Data visualization helps monetize data as a product

![[uber.png]]

