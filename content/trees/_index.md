+++
title = "Trees"
weight = 45

pre = "<b>6. </b>"
+++

## Trees

[Binary search](/dictionaries/binary-search) provides an efficient way to find elements in a sorted array-like structure. However, inserting or removing from an array-like structure can be expensive because all subsequent data elements must be moved to accommodate the change. On the other hand, linked lists can be modified efficiently, provided we have a reference to the cell preceding the insertion or deletion point. However, finding a cell can be expensive because the only way to search a linked list is to start at the front and work through it a cell at a time. We would like a data structure that provides both efficient lookups and efficient insertions and deletions.

To meet this challenge, we want a linked structure so that changes can be made cheaply by changing a few references. However, we want the individual cells in the structure to be arranged in a way that supports something like a binary search. The specific structure that we want is called a binary search tree, which is a particular kind of tree.
In this chapter, we will examine various kinds of trees. We will start by defining trees and developing a strategy for processing them. We will then present binary search trees, which will provide a partial solution to our challenge of finding a data structure to support efficient lookups, insertions, and deletions. However, there will be cases in which binary search trees have poor performance. We will therefore give a refinement known as AVL trees, which give good performance in all cases. We will then examine two other uses of trees - tries and priority queues. 
