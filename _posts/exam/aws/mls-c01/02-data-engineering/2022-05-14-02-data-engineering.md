---
layout: post
title: "[MLS-C01] [Data Engineering] Gathering data"
date: 2022-05-14 14:34
author: "Oscaner"
header-img: "img/post-bg-alitrip.jpg"
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

## Gathering data

### Scikit-learn

Retrieve data from Scikit-learn

Scikit-learn has many datasets for use in your modeling

Similar to the Kaggle and Reddit dataset repositories

https://scikit-learn.org/stable/datasets

### AWS services

Several AWS services to help gather data

- Amazon Data Pipeline
- AWS Database Migration Service (DMS)
- AWS Glue
- Amazon SageMaker
- Amazon Athena

### Labs

- [load_data_and_clean.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/load_data_and_clean.ipynb "load_data_and_clean.ipynb")

## Handling Missing Data

![[example-missing-data.png]]

Several approaches to the problem of handling missing data

- Do nothing
- Remove the entire record
- Mode/median/average value replacement
- Most frequent value
- Model-based imputation
    - K-Nearest Neighbors
    - Regression
    - Deep Learning
- Interpolation / Extrapolation
- Forward filling / Backward filling
- Hot deck imputation

### Do nothing

Let your algorithm either replace them through imputation (XGBoost) or just ignore them as LightGBM does with its `use_missing=false` parameter

Some algorithms will throw an error if they find missing values (LinearRegression)

Or, replace all missing values

But with what ?

### Remove the Entire Record

Remove the observations that have missing values

Risk losing data points with valuable information

#### Labs

- [drop_features_with_missing_values.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/drop_features_with_missing_values.ipynb "drop_features_with_missing_values.ipynb")

### Median/Average Value Replacement

Replace the missing values with a simple median, or mean

- Reflection of the other values in the feature
- Does't factor correlation between features
- Can't use on categorical features

#### Labs

- [impute_using_simpleimpute_mean.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/impute_using_simpleimpute_mean.ipynb "impute_using_simpleimpute_mean.ipynb")

### Most Frequent Value

Replace missing values with the most frequently occurring value in the feature

- Doesn't factor correlation between features
- Works with categorical features
- Can introduce bias into your model

### Model-Based Imputation

Use a machine learning algorithm to impute the missing values

- K-Nearest Neighbors
    - Uses "feature similarity" to predict missing values
- Regression
    - Predictors of the variable with missing values identified via correlation matrix
    - Best predictors are selected and used as independent variables in a  regression equation
    - Variable with missing data is used as the target variable
- Deep Learning
    - Works very well with categorical and non-numerical features

#### Labs

- [impute_using_k-nearest_neighbors.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/impute_using_k-nearest_neighbors.ipynb "impute_using_k-nearest_neighbors.ipynb")

### Other Methods

- Interpolation / Extrapolation
    - Estimate values from other observations within the range of a discrete set of known data points
- Forward filling / Backward filling
    - Fill the missing value by filling it from the preceding value or the succeeding value
- Hot deck imputation
    - Randomly choosing the missing value from a set of related and similar variables

## Feature Selection/Extraction

### The Curse of Dimensionality

![[the-curse-of-dimensionality.png]]

"Dimensionality" refers to the number of features (i.e. input variables) in your dataset

- High feature to observation ratio causes some algorithms struggle to train effective models
- Visualization of `multi-dimensional datasets` vs `two or three-dimensions`
- Two primary methods for reducing dimensionality: Feature Selection and Feature Extraction

### Feature Selection

Use feature selection to filter irrelevant or redundant features from your dataset

- Feature Selection requires normalization

![[feature-selection-requires-normalization.png]]

- Feature Selection removes features from your dataset - **Variance Thresholds**

![[feature-selection-removes-features.png]]

### Feature Extraction

#### Requires Standardization

- Feature Extraction requires standardization

![[feature-extraction-requires-standardization.png]]

#### Reduces Features - Retains Information

Creating new features from your existing features, feature extraction creates a new, smaller set of features that stills captures most of the useful information.

![[feature-extraction-reduces-features.png]]

#### Principal Component Analysis (PCA)

**Principal Component Analysis (PCA)** is an unsupervised algorithm that creates new features by linearly combining original features

- New features are uncorrelated, meaning they are orthogonal
- New features are ranked in order of "explained variance".  The first principal component (PC1) explains the most variance in your dataset, PC2 explains the second-most variance, etc.
    - Explained variance tells you how much information (variance) can be attributed to each of the principal components
    - You lose some of the variance (information) when you reduce your dimensional space

![[pca-example.png]]

- Principal component analysis (PCA) can be used to assist in visualization of your data

![[pca-visualization.png]]

- Principal component analysis (PCA) can also assist in speeding up your machine learning

![[pca-speeding-up-machine-learning.png]]

### Labs

- [feature_extraction_and_feature_selection_with_principal_component_analysis_and_variance_thresholds_-_lab_part_1.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/feature_extraction_and_feature_selection_with_principal_component_analysis_and_variance_thresholds_-_lab_part_1.ipynb "feature_extraction_and_feature_selection_with_principal_component_analysis_and_variance_thresholds_-_lab_part_1.ipynb")
- [feature_extraction_and_feature_selection_with_principal_component_analysis_and_variance_thresholds_-_lab_part_2.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/feature_extraction_and_feature_selection_with_principal_component_analysis_and_variance_thresholds_-_lab_part_2.ipynb "feature_extraction_and_feature_selection_with_principal_component_analysis_and_variance_thresholds_-_lab_part_2.ipynb")

## Encoding categorical values

- Binarizer Encoding: for features of a binary nature
- Label Encoding: may imply ordinality, can use Ordinal Encoder
- One Hot Encoding: Change nominal categorical values such as "true", "false", or "rainy", "sunny" to numerical values

### Labs

- [encoding_categorical_values.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/encoding_categorical_values.ipynb "encoding_categorical_values.ipynb")

## Numerical engineering

- Transform numeric values so machine learning algorithms can better analyze them
- Change numeric values so all values are on the same scale
    - Normalization: rescales the values into a range of `[0, 1]`
    - Standardization: rescales data to have a mean of 0 and a standard deviation of 1 (unit variance)
- Binning

![[numerical-engineering-binning.png]]

### Binning

AKA discretization or quantization

- Categorical Binning
    - Group categorical values to gain insight into data: countries by geographical region
- Numerical Binning
    - Divides continuous feature into a specified number of categories or bins, thus making the data discrete
    - Reduces the number of discrete intervals of a continuous feature
- Quantile Binning
    - Divide up data into equal sized bins
    - Defines the bins using percentiles based on the distribution of the data

### Labs

- [numerical_engineering_34_26.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/numerical_engineering_34_26.ipynb "numerical_engineering_34_26.ipynb")

## Text Feature Editing

- Transform text within data so machine learning algorithms can better analyze it
- Splitting text into smaller pieces
- Used for text analysis of documents, streamed dialog, etc.
- Can use in a pipeline as steps in a machine learning analysis

### Bag-of-Words

- Tokenizes raw text and creates a statistical representation of the text
- Breaks up text by whitespace into single words

![[bag-of-words.png]]

### N-Gram

- Extension of Bag-of-Words which produces groups of words of n size
- Breaks up text by whitespace into groups of words

![[n-gram.png]]

### Orthogonal Sparse Bigram

- Creates groups of words of size n, returns every pair of words that includes the first word
- Creates groups of words that always include the first word

### TF-IDF

- Term Frequency-Inverse Document Frequency (TF-IDF)
- Shows how important a word or words are to a given set of text by providing appropriate weights to terms that are common and less common
- Show the popularity of a word or words in text data by making common words like "the" or "and" less important

### Use Cases

| Use Case | Transformation | Reason |
| :---: | :---: | :--- |
| Finding phrases in spam | N-Gram | Compare whole phrases such as "you're a winner!" or "Buy now!" |
| Finding subject of several PDFs | TF-IDF<br>Orthogonal Sparse Bigram | Filter less important words in the documents.<br>Find common word combinations repeated in the documents. |

### Labs

- [text_feature_editing.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/02-data-engineering/text_feature_editing.ipynb "text_feature_editing.ipynb")


