---
layout: post
title: "[MLS-C01] [Algorithms] Text Analysis Algorithms"
date: 2022-07-19 14:44
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

- Both supervised and unsupervised learning algorithms
- Take text or documents as input and either categorize, sequence, or classify the text or documents
- Used as preprocessing for many downstream natural language processing (NLP) tasks, such as `sentiment analysis`, `named entity recognition`, `machine translation`
- Text classification used for applications that perform web searches, ranking, and document classification

## Use Cases

1. Sentiment analysis for social media streams
2. Categorize documents by topic for law firms
3. Language translation
4. Speech-to-text
5. Summarizing longer documents
6. Conversational user interfaces
7. Text generation
8. Word pronunciation app

## SageMaker Algorithms

### Blazing Text

- Implements the Word2vec and text classification algorithms
- Can use pre-trained vector representations that improve the generalizability of other models that are later trained on a more limited amount of data
- Can easily scale for large text datasets
- Can train a model on more that a billion words very quickly, in minutes, using a large multi-core CPU or a GPU
- Words that are semantically similar correspond to vectors that are close together, resulting that word embeddings capture the semantic relationships between words.
- Example use case: market research using sentiment analysis
- Important Hyperparameters
    1. `mode`: architecture used for training

### Latent Dirichlet Allocation (LDA)

- Unsupervised learning algorithm that organizes a set of text observations into distinct categories
- Frequently used to discover a number of topics shared across documents within a collection of texts, or a corpus
- In an LDA algorithm based model, each observation is a document and each feature is a count of a word in the documents
- Topics are not specified in advance
- Each document is described as a mixture of topics
- Example use case: find common topics in call center transcripts
- Important Hyperparameters
    1. `num_topics`: number of topics to find in the data
    2. `feature_dim`: size of the vocabulary of the input document corpus
    3. `min_batch_size`: total number of documents in the input document corpus

### Neural Topic Model (NTM)

- Unsupervised learning algorithm that organizes a corpus of documents into topics containing word groupings, based on the statistical distribution of the word groupings
- Frequently used to classify or summarize documents based on topics detected
- Also used to retrieve information or recommend content based on topic similarities
- Topics are inferred from observed word distributions in the corpus
- Used  to visualize the contents of a large set of documents in terms of the learned topics
- Similar to LDA, but will produce different outcomes
- Example use case: find the topics of newsgroup message posts
- Important Hyperparameters
    1. `feature_dim`: vocabulary size of the dataset
    2. `num_topics`: number of required topics

### Object2Vec

- General purpose neural embedding algorithm that finds related clusters of words (words that are semantically similar)
- Embeddings can be used to find nearest neighbors of objects, and can also visualize clusters of related objects
- Besides word embeddings, Object2Vec can also learn the embeddings of other objects such as sentences, customers, products, etc.
- Frequently used for information retrieval, product search, item matching, customer profiling, etc. based on related topics
- Supports embeddings of paired tokens, paired sequences, and paired token to sequence
- Example use case: recommendation engine based on collaborative filtering
- Important Hyperparameters
    1. `enc0_max_seq_len`: maximum sequence length for the enc0 encoder
    2. `enc0_vocab_size`: vocabulary size of enc0 tokens

### Sequence-to-Sequence (seq2seq)

- Supervised learning algorithm with input of a sequence of tokens (audio, text, radar data) and output of another sequence of tokens
- Can be used for translation from one language to another, text summarization, speech-to-text
- Uses Recurrent Neural Networks (RNNs) and Convolutional Neural Network (CNN) models
- Uses state-of-the-art encoder-decoder architecture
- Uses input of sequence data in recordio-protobuf format and JSON vocabulary mapping files
- Example use case: word pronunciation dictionary, a sequence of text as input and a sequence of audio as output
- Important Hyperparameters
    1. Has no required hyperparameters

## Labs

1. [English word vectors](https://fasttext.cc/docs/en/english-vectors.html)
2. [Language identification](https://fasttext.cc/docs/en/language-identification.html)
3. [fasttext.ipynb](https://github.com/Oscaner/Exam/blob/master/aws/mls-c01/whizlabs/05-algorithms/07-text-analysis-algorithms/fasttext.ipynb "fasttext.ipynb")
