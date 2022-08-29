---
layout: post
title: "[MLS-C01] [Exploratory Data Analysis] Analyze and visualize data"
date: 2022-06-23 20:30
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

![[visualize-data.png]]

Visualize data before choosing a machine learning algorithm

- Identify patterns
- Find corrupt data
- Identify outliers
- Find imbalances in the data
- Explore and demonstrate important relationships, and strength of relationships (density), using plots/chats

## Charting data

Types of information to convey via Business Intelligence (BI) tools

- Key Performance Indicators (KPIs)
- Relationships
- Comparisons
- Distributions
- Compositions

### Key Performance Indicators (KPIs)

![[key-performance-indicators.png]]

A single value that represents a particular area or function and shows relative performance

- Net Promoter Score (NPS)
- Customer Profitability Score (CPS)
- Conversion Rate
- Relative Market Share
- Net Profit Margin

Use KPI charts to represent these indicators

### Relationships

![[relationships.png]]

Establish or prove a relationship between 2 or more variables

Best chart to use depends on number of variables being compared

- Scatter Chart
    - Two variables, example: social media spend to adoption rate
- Bubble Chart
    - Three variables, example: comparing investment return, investment duration, and investment commitment

### Comparisons

![[comparisons.png]]

Show how variables change over time or show a static view of how different variables compare

Best chart to use depends on number of variables being compared

- Bar Chart
    - One variable, example: website hits in a given month
- Table
    - Three variables, example: two dimensions represented as the columns and rows, the third by the data in the cells
- Column Chart
    - One or two variables changing over time, example: show year-over-year sales and number of marketing campaigns
- Line Chart
    - Three or more variables changing over time, example: show year-over-year sales, number of marketing campaigns, and web traffic

### Distributions

![[distributions.png]]

Show how data is distributed over defined intervals, Interval meaning clustering or grouping, not time

- Column Histogram
    - One variable, example: showing how many voters are in various generation groups
    - Counting something and putting them into buckets
- Scatter Chart
    - Two variables, example: relating return on investment, investment duration, and investment size
    - X-axis is investment time, y-axis is return on investment, and the bubble size is the investment size

### Compositions

![[compositions.png]]

Show the elements that make up data set, static or changing over time

- Pie Chart
    - simple share of total
- Stacked 100% Bar Chart
    - components of components
- Tree Map
    - share of total
- Stacked Area Chart
    - 5 or more periods
    - relative and absolute differences
- Stacked 100% Area Chart
    - 5 or more periods
    - relative differences
- Stacked Column Chart
    - less than 5 periods
    - relative and absolute differences
- Stacked 100% Column Chart
    - less than 5 periods
    - relative differences

## Business Intelligence Tools

![[business-intelligence-tools.png]]

- Amazon Quicksight
    - Cloud powered business intelligence service
    - Create interactive dashboards that include <ins>machine learning insights</ins>
        - Anomaly detection, forecasting, auto-narratives
- TensorFlow with TensorBoard
- Tableau

