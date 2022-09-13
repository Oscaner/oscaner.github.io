---
layout: post
title: "Architecture Soft Skills Part 1"
subtitle: "Software Architecture Fundamentals: Understanding the Basics"
date: 2022-09-12 09:37
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - ciandt
  - architecture
  - soft skill
tags:
  - Ciandt
  - Architecture
  - Soft Skill
---

In this chapter, we're going to be looking at some of the soft skills that an architect needs when becoming an architect from developer, that it's a very ill-defined role.

There are literally dozens of roles and titles of architect, and so it becomes very confusing as a developer to say, which one of these do i want ?

- Application Architect
- Integration Architect
- Information Architect
- Data Architect
- Systems Architect
- Business Architect
- Enterprise Architect
- Technical Architect
- Security Architect
- Network Architect
- Solutions Architect

What do all these mean ?

In fact, in many organizations, architect is just so ill-defined it just means the most senior technologist around and we have to give him some title, so we'll call him architect. And there's no actual definitional rigor at all in the company besides just he's the senior tech guy.

So to simplify things, we're going to focus on three aspects of architecture.

- Application Architect
- Integration Architect
- Enterprise Architect

## Architectural decisions

Being an architect, first of all, requires you to make certain decisions.

- What does it mean to be an architect ?
- What does it require to be an architect ?

Well, the first aspect of that is architectural decisions.

> Q1: Is the decision to use java server faces an architectural decision ?

Many times, somebody would think, yes, an architect does need to make that important decision.

> Q2: Is the decision to use a web-based client an architectural decision ?

And now, what would you say ? Of course. So we can banter back and forth about the fact of is the decision to use JSF -- JavaServer Faces -- really an architecture decision or not ?

But when we frame it in terms of this, it's the type versus the implementation.

With the JSF, you can see the scoping level of that.

> An architect may be responsible for making technology decisions, but the decision is not an architectural one.

So one of the considerations to take into account between the JSF versus web client is the fact, that an architect may be responsible for making that technology decision.

But the decision is not an architectural one, **the choice of technology should not drive the architecture**. In fact, it should be the other way around.

This is an enormous anti-patterning in a lot of organizations who choose products first and then try to build things around them rather than vice versa. It's more common.

## Expectations

- What are the expectations of an architect ?

1. The first and foremost of these really is to analyze the technology, industry, and market trends and keep current in those trends.

Keeping tabs with the industry and the market trends is incredibly important in understanding how that architecture should be formed.

So that's kind of the first expectation.

2. Another common expectation is to analyze the current technology environment and recommend solutions for improvement.

This is core thing of what an architect does.

But the problem is most architects stop right there. They'll look at the technical infrastructure, but this needs to stretch out to the full lifecycle of the project.

Let me give you an example:

> Let's say you're having release management pain. It really is the responsibility of the architect to make sure it works -- to not only analyze the architecture, but also Why can't we deploy successfully ? Why can't we ever make our targets ? Why are our sprints always late ?

This is also what we need to analyze and recommend solutions for improvement.

3. Another expectation is to ensure compliance with the architecture.

As an architect, you're going to create all sorts of lines and boxes and standards and principles, and you expect people to follow them.

So you have to call this component before you call that component. Whatever, and you don't do it.

There's no one else who is going to be validating that architecture, making sure it's complied with, except the architect.

So this is one of the ongoing things that an architect needs to do is ensure compliance with that.

As the architect, you need to make sure that everybody is complying with that architecture.

4. The other expectation, which is also difficult, is having exposure to multiple platforms, technologies, environments, all this.

The point is, if you're just a J2EE architect, every single solution is going to be J2EE.

You're also limiting the scope of what you can actually produce as an effective architecture.

So yes, this is very critical, and we're going to dive into depth on this one actually in part two of the soft skills.

Sure, you don't hove to know every single detail of all these other architectures. But knowing how they work, how the fundamental building blocks work is really valuable because it allows you to compare and contrast when you have particular problems you're trying to solve.

5. This particular expectation is the reason why we don't have a whole lot of architects. it is expected that an architect will possess exceptional interpersonal skills, including teamwork, facilitation, and negotiation

In other words, an architect needs to also lead teams.  This is a very critical part of the architecture.

6. One of the core pieces that an architect is to define the architecture and design principles to guide technology decisions for the enterprise.

Obviously, that's what we do as an architect.

But the key point here, it's to guide the technology decisions for the enterprise.

The architect may not be making the technology choices for the enterprise, but the architecture should drive those technology choices and help guid them so that they fit with the architecture.

It should never, be the other way around. We're going to use Ruby or Rails, Therefore, the architecture has to drive toward that. That should never, ever be the case.

So it is important as an architect that we actually define those principles. Sometimes we make those technology decisions, but most importantly, the architect is helping to guide those technology decisions for the enterprise.

7. Sometimes the most important aspect of an architect is to understand the political climate of the environmental or project or company, and be able to navigate the politics.

There will be arguments, there will be disagreements about your architecture, and to be able to negotiate and compromise and get buy-in from everybody is absolutely key to becoming a successful architect.

In fact, one of the rules of thumb, when you're got important decisions -- you're trying to make a really important point -- is never ask a question you don't know what the answer is going to be.

So you know you're not going to get surprised by someone giving you a no when you're really expecting a yes.

Understanding how to pose that question and when to pose that question is sometimes as important as the question itself.

## Architecture aspects

There's another whole aspect of being an architect.

In order to be a successful architect, you have to have fulfilled or have at least experience or knowledge in four different aspects of architecture.

{% mermaid %}
graph LR
    A[Architecture aspects] --- B(leadership and communication)
    A[Architecture aspects] --- C(technical knowledge)
    A[Architecture aspects] --- D(business domain knowledge)
    A[Architecture aspects] --- E(methodology and strategy)
{% endmermaid %}

Within the aspects, there's **leadership and communication**. This is a piece that as you look at the expectations, you saw this meld in with team, leadership, negotiation, politics, the whole bit. That's a very critical part of being an architect.

There certainly is the **technical knowledge**. That's another aspect, obviously. We as architects have to have a certain level of technical knowledge.

A lot of architects will end here, sometimes not even having the leadership and communication.

Can they do architecture ? Sure.

Is it effective ? Probably not.

Because there's a couple of other aspects we need as an architect.

Another one is **business domain knowledge**. We have to know the business in order to produce an effective architecture.

And the final one is **methodology and strategy**.

So in part two of the soft skills, we're going to be taking a detailed look at each of these aspects and what's involved in becoming an architect in terms of leadership and communications.

What's the difference between technical depth and breadth, for example ?

How important is business domain knowledge ?

And finally, once you've created an architecture, how do you actually get it to its final end product ?

We'll take a look at those in part two.

## For more information

- 《97 Thins Every Software Architect Should Know, Monson-Haefel et.al, O'Reilly》
- 《A Practical Guide to Enterprise Architecture, McGovern et.al PTR》
- 《Software Architecture in Practice 3rd Edition, Bass et.al, Addison Wesley》

