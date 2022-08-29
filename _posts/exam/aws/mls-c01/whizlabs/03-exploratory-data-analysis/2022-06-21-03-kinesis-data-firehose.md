---
layout: post
title: "[MLS-C01] [Exploratory Data Analysis] Kinesis Data Firehose"
date: 2022-06-21 14:48
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

![[kinesis-data-firehose.png]]

- Fully managed service that automatically scales to match data throughput
- Capture, transform, and load streaming data into S3, Redshift, ElasticSearch, and Splunk
- Batch, compress, transform, and encrypt data before loading it on to your destination
    - Minimizes the storage used at destination and increases security
- Automatically convert incoming data to Apache Parquet/ORC before delivering to S3
- Near real-time analytics with existing business intelligence tools
- Requires no ongoing administration

## Key Concepts

1. Kinesis Data Delivery Stream

Underlying entity of Kinesis Data Firehose

Create a delivery stream via the AWS console then send it data

2. Elastic scaling handles variations in data throughput

Automatically scale to handle gigabytes per second input rate

Maintain data latency at specified levels

Requires no intervention or maintenance

3. Transform your data using Lambda

Automatically apply Lambda function to every input data record

Pre-built Lambda blueprints for converting common data sources such as Apache/system logs to JSON and CSV formats

## Putting Data into Delivery Streams

1. Send data to the delivery stream

Call the Firehose API from your data producer application

Run the Linux agent on your data source

 2. Control the delivery pace to your delivery stream

Specify a batch size or batch interval to control how quickly data is delivered

Compress the data stream using GZip or Snappy

## Social Media Stream

![[social-media-stream.png]]

## Additional Key Points

- Automatic encryption using AWS Key Management System (KMS) encryption key
- Track metrics of your stream
    - Volume of data submitted to the stream
    - Volume of data sent to destination
    - Time from source to destination
    - Delivery success rate
- Pay-as-you-go pricing
    - Pay only for the volume of data you transmit through the service

## Labs

- [Use Kinesis Data Streams as Producer](https://aws.amazon.com/blogs/big-data/test-your-streaming-data-solution-with-the-new-amazon-kinesis-data-generator/ "Test Your Streaming Data Solution with the New Amazon Kinesis Data Generator")

## Kinesis Data Pipeline

![[kinesis-data-pipeline.png]]
