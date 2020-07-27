+++
title = "Introduction to Queues"
date = 2018-08-24T10:53:05-05:00
weight = 50
chapter = true
pre = "<b>3.5. </b>"
+++

## Introduction to Queues

Stacks provide LIFO access to data, but sometimes we need FIFO access.
Consider, for example, the computation of capital gains from stock
sales. Typically an investor will buy shares of a stock commodity at
various times and for different prices. When shares are sold, the amount
of money received doesn't depend on *which* shares of a given commodity
are sold, as each share is worth the same amount at that time. Likewise,
the unsold shares of that commodity each have the same value. However,
for accounting purposes, it does matter. Specifically, the *capital
gain* for that sale is defined to be the amount received from the sale
minus the amount originally paid for those shares, assuming the shares
sold are the oldest shares of that commodity owned by the investor.

Suppose now that we want to compute the capital gains from sales of
stock. As shares are purchased, we need to record the purchase price of
each share, along with the order in which the shares were purchased. As
shares are sold, we need to retrieve the original purchase price of the
oldest shares of each commodity sold. We therefore need
first-in-first-out access to the purchase prices of the shares of each
commodity owned. To keep this relatively simple, in what follows we will
assume that we only need to keep track of one stock commodity.

A *queue* provides FIFO access to data items. Like a stack, a queue is a
sequence of data items. However, a queue behaves more like a line of
people at a ticket counter. Each person who enters the queue enters at
the *back*, and the next person who is served is the person at the
*front*. Thus, the people in the queue are served in FIFO order.
Likewise, new data items are added to the back of a queue, and data
items are retrieved from the front.

The .NET Framework provides both a non-generic queue of **object**s
([**System.Collections.Queue**](http://msdn.microsoft.com/en-us/library/system.collections.queue.aspx))
and a generic queue
([**System.Collections.Generic.Queue\<T\>**](http://msdn.microsoft.com/en-us/library/7977ey2c\(v=vs.110\).aspx)).
For simplicity, we will focus on the generic version. The non-generic
version is the same, except that wherever the type parameter **T** is
used in the generic version, **object** is used in the non-generic
version.

Like **Stack\<T\>**, **Queue\<T\>** has a **public**
[constructor](http://msdn.microsoft.com/en-us/library/e99tfk1a\(v=vs.110\).aspx)
that takes no parameters and constructs an empty queue, along with a
**public**
[**Count**](http://msdn.microsoft.com/en-us/library/fy0wwyz4\(v=vs.110\).aspx)
property that gets the number of elements in the queue (as an **int**).
It also has the following **public** methods:

  - An
    [**Enqueue**](http://msdn.microsoft.com/en-us/library/t249c2y7\(v=vs.110\).aspx)
    method that takes a single parameter of type **T** and places it at
    the back of the queue.
  - A
    [**Peek**](http://msdn.microsoft.com/en-us/library/1cz28y5c\(v=vs.110\).aspx)
    method that takes no parameters and returns the element (of type
    **T**) at the front of the queue without changing the queue's
    contents. If the queue is empty, this method throws an
    **InvalidOperationException**.
  - A
    [**Dequeue**](http://msdn.microsoft.com/en-us/library/1c8bzx97\(v=vs.110\).aspx)
    method, which takes no parameters and removes and returns the
    element at the front of the queue. If the queue is empty, this
    method throws an **InvalidOperationException**.

To implement a capital gain calculator using a **Queue\<T\>**, we first
need to determine what type to make the elements. We will need to store
the purchase price of each share we buy in the queue. An appropriate
type for storing monetary amounts is the
[**decimal**](/~rhowell/DataStructures/redirect/decimals) type.
Therefore, we will use an initially empty **Queue\<decimal\>**. Each
time we buy shares, we enqueue the purchase price of each share onto the
queue. When we sell shares, we need to compute the sum of the capital
gains for all of the shares we sold. To get the capital gain for a
single share, we dequeue its original purchase price from the queue, and
subtract that purchase price from the selling price. Using the queue in
this way ensures that we sell the shares in FIFO order.
