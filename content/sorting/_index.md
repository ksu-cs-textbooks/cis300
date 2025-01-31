+++
title = "Sorting"
weight = 60

pre = "<b>9. </b>"
+++

## Sorting

We conclude this text with a look at a common activity in computing, namely, sorting data. While .NET provides several methods for sorting data, it is instructive to examine the implementation details of different techniques. While there is one sorting algorithm
that is used more commonly than the others, none is best for all
situations. An understanding of which algorithms perform better in
different situations can help us to make better choices and thereby
achieve better performance for the software we build. Furthermore,
because there are so many different approaches to sorting, studying the
various techniques can help us to see how different approaches can be
used for the same problem in order to obtain different algorithms.

In this chapter, we will consider several sorting algorithms, but not
nearly all of them. In the first four sections, we will focus on
algorithms that can be applied to any data type that can sorted; thus,
we will only consider algorithms that operate by comparing data elements
to each other. Most of these algorithms can be divided into four general
approaches. We consider each of these approaches separately. We then
conclude with an algorithm designed specifically for sorting strings.
