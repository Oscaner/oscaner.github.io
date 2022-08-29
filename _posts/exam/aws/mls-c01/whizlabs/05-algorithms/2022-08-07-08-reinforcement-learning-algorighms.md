---
layout: post
title: "[MLS-C01] [Algorithms] Reinforcement Learning Algorithms"
date: 2022-08-07 15:44
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

![[defined-reinforcement-learning.png]]

- Machine learning technique which learns a strategy, called a policy, that optimizes an objective for an agent acting in an environment
- Agent performs an action, checks the state of the environment, and gets rewarded based on the resulting state of the environment
- Attempts to achieve the goal of maximizing the long-term reward that the agent receives resulting from its actions
- Good for solving problems where you want your model to make independent decisions.
- Markov Decision Process (MDP)
    - Based on Markov Decision Processes (MDPs) models
    - Works through a sequence of time steps with each step containing the following
        - `Environment`: operating space of the RL model
        - `State`: complete information describing the environment and relevant past steps
        - `Action`: agent's activity
        - `Reward`: number that reflects the state resulting from the last action
        - `Observation`: data about the state of the environment available at each step


## Use Cases

1. Robotics
2. Traffic light control
3. Predictive auto scaling
4. Tuning parameters of a web system
5. Optimizing chemical reactions
6. Personalized recommendations
7. Gaming
8. Deep learning: "see an environment" and learn how to interact with it

## SageMaker Algorithms

### Deep Learning Framework

- Reinforcement Learning in TensorFlow and Apache MXNet
    - Uses a Reinforcement Learning toolkit
        - Manage the agents interaction with the environment
        - SageMaker supports Intel Coach and Ray RLlib toolkits
    - Uses an environment
        - Custom environment
        - Open source environments: EnergyPlus, RoboSchool
        - Commercial environments: MATLAB, Simulink
- Important Hyperparameters
    1. `learning_rate`: how fast the model learns
    2. `discount_factor`: take action with short-term or long-term rewards
    3. `entropy`: degree of uncertainty; exploit what's already known versus thorough exploration of the environment
