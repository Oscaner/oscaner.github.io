---
layout: post
title: "[MLS-C01] [Data Engineering] AWS Migration services"
date: 2022-05-15 22:20
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

![[aws-migration-services.png]]

- Migrate data from source to machine learning repository
- Several AWS services to help move data
    - Amazon Data Pipeline
    - AWS Database Migration Service (DMS)
    - AWS Glue
    - Amazon SageMaker
    - Amazon Athena

## Amazon Data Pipeline

![[amazon-data-pipeline.png]]

- Copy data using Pipeline Activities
- Schedule regular data movement and data processing activities
- Integrates with on-premise and cloud-based storage systems
- Use your data where you want it and in the format you choose

## AWS DMS

![[aws-dms.png]]

- Move data between databases
    - MySQL to MySQL
    - Aurora to DynamoDB

## AWS Glue

![[aws-glue.png]]

- Extract, Transform, and Load (ETL)
    - Determine data type and schema
- Can run your data engineering algorithms
    - Feature Selection
    - Data Cleansing
- Can run on demand, on a schedule, or on events

## Amazon SageMaker

![[amazon-sagemaker.png]]

- Use jupyter notebooks
    - Scikit-Learn
    - Pandas

## Amazon Athena

![[amazon-athena.png]]

- Run SQL queries on S3 data
- Needs a data catalog such as the one created by Glue
- SQL transform your data in preparation for use in ML models

## Use Cases

1. Move data to S3 for your machine learning model
    - Move data from EMR cluster: Amazon Data Pipeline
    - Move data from DynamoDB: AWS Glue
    - Move data from Redshift: Amazon Data Pipeline, AWS Glue
    - Move data from on-prem database: Database Migration Services
