---
layout: post
title: "[MLS-C01] [Exploratory Data Analysis] Kinesis Data Analytics"
date: 2022-06-21 16:23
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

![[kinesis-data-analytics.png]]

- Use SQL to process streaming data
- Sources: Kinesis Data Streams and Kinesis Data Firehose
- SQL queries put to S3, Redshift, or visualization and Business Intelligence tools
- A Kinesis Data Analytics streaming application consists of three parts
    - Streaming data sources
    - Analytics written in SQL
    - Destinations for the results
- The streaming application continuously reads data from a streaming source, generates analytics using SQL code, and emits results to 1 to 4 destinations

## Streaming Application

![[kinesis-data-analytics-streaming-application.png]]

- Streaming application is the primary resource in Kinesis Data Analytics
- Create/manage streaming applications via the console or the Kinesis Data Analytics API
- The API has operations to manage your streaming applications
- A Kinesis Data Analytics streaming application continually read and process streaming data in real-time
- Application code in SQL processes the incoming streaming data and produces output
- Kinesis Data Analytics writes the output to configured destinations
- Streaming data input from Kinesis Data Streams or Kinesis Data Firehose
- Reference data from S3
- Data read continuously from the streaming data sources but one time from the reference source
- Reference data sources are used for joining against the incoming stream to enrich the data

