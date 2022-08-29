---
layout: post
title: "[MLS-C01] [Exploratory Data Analysis] Kinesis Data Streams"
date: 2022-06-16 23:43
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

![[kinesis-data-streams.png]]

- Massively scalable and durable real-time data streaming service
- Continuously capture gigabytes of data per second from thousands of sources
    - Website clickstreams
    - Database event streams
    - Social media feeds
    - Financial transactions
    - IoT events
    - Application logs
- Enables real-time analytics
    - Real-time dashboards
    - Real-time anomaly detection
    - Dynamic pricing
    - Real-time fraud detection

## Key Concepts

1. Data Producer

An application that emits data records as they are generated

2. Data Consumer

AWS service or distributed Kinesis application that retrieves data from Kinesis Data Streams

3. Shard

A shard is the base throughput unit of a Kinesis Data Stream

Data producers assign partition keys to records

Partition keys ultimately determine which shard ingests the data record for a data stream

Data consumers retrieve data from all shards in a stream as the data is generated

4. Data Stream

A logical grouping of shards

Data stream will retain data for 24 hours, or up to 7 days with extended retention enabled

## Putting Data Into Streams

Data producers put data into Amazon Kinesis data streams using the Kinesis Data Streams APIs

- Amazon Kinesis Producer Library
    - Highly configurable library that puts data into an Amazon Kinesis data stream
    - Simple, asynchronous, reliable interface to achieve high producer throughput
- Amazon Kinesis Agent
    - Pre-built Java application that collects and sends data to your Amazon Kinesis stream
    - Install the agent on web servers, log servers, and database servers
    - Agent monitors files/database resources and continuously sends data to your stream

## Big Data Architecture

![[kinesis-data-streams-big-data-architecture.png]]

## Additional Key Points

- Shards are append-only logs
- Shards contain ordered sequence of records ordered by arrival time
- One shard can ingest up to 1000 data records per second, or 1MB/sec
- Specify the number of shards needed when you create a stream
- Add/Remove shards from stream dynamically as throughput changes via API, Lambda, Auto scaling
- `Enhanced fan-out`: one shard allows `1MB/sec in` and `2MB/sec out` for each consumer
- `Non-Enhanced fan-out`: one shard allows `1MB/sec in` and `2MB/sec out` shared across consumers
- Monitor shard-level metrics in Amazon Kinesis Data Streams

## Labs

- [Test Your Streaming Data Solution with the New Amazon Kinesis Data Generator](https://aws.amazon.com/blogs/big-data/test-your-streaming-data-solution-with-the-new-amazon-kinesis-data-generator/ "Test Your Streaming Data Solution with the New Amazon Kinesis Data Generator")
- [amazon-kinesis-data-generator](https://github.com/awslabs/amazon-kinesis-data-generator "amazon-kinesis-data-generator")
