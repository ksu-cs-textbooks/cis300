+++
title = "Priority Queues"
weight = 50

pre = "<b>6.5. </b>"
+++

## Priority Queues

Often we need a data structure that supports efficient storage of data items and their subsequent retrieval in order of some pre-determined _priority_.  We have already seen two instances of such data structures: stacks and queues.  With a stack, the later the item is stored, the higher its priority. With a queue, the earlier the item is stored, the higher its
priority.  More generally, we would like to be able to set priorities arbitrarily, in a way that may be unrelated to the order in which they were stored.

The general name for such a data structure is a _priority queue_.  Priority queues typically  support the following operations:

* Adding a data element, together with a priority. 
* Obtaining the number of data elements currently in the structure.
* Obtaining the maximum of all priorities of elements in the structure.
* Removing a data element having maximum priority.

Obviously, the last two operations above can only be done when the structure is nonempty.  A variation on the above focuses on minimum priority rather than maximum priority.  This variation is called a _min-priority queue_.  Because we will later cover applications of min-priority queues, we will focus on this variation in this section.  In the sub-sections that follow, we will first consider a general structure that can be used in various ways to give efficient priority queue implementations.  We will then look at one specific implementation.  We will conclude by giving an example of how min-priority queues are used in file compression algorithms.
