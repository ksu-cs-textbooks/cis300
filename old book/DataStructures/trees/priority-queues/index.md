<div class="NAVBAR">

[Next: Heaps](/~rhowell/DataStructures/redirect/heaps)       [Up:
Trees](/~rhowell/DataStructures/redirect/trees)      
[Top](/~rhowell/DataStructures/)

</div>

# Priority Queues

<div class="TOC">

## Contents

1.  [Heaps](/~rhowell/DataStructures/redirect/heaps)
2.  [Leftist Heaps](/~rhowell/DataStructures/redirect/leftist-heaps)
3.  [Huffman Trees](/~rhowell/DataStructures/redirect/huffman-trees)

</div>

Often we need a data structure that supports efficient storage of data
items and their subsequent retrieval in order of some pre-determined
*priority*. We have already seen two instances of such data structures:
stacks and queues. With a stack, the later the item is stored, the
higher its priority. With a queue, the earlier the item is stored, the
higher its priority. More generally, we would like to be able to set
priorities arbitrarily, in a way that may be unrelated to the order in
which they were stored.

Suppose, for example, that we want to schedule tasks in a real-time
computing environment. Tasks that are more urgent would be given higher
priorities. Each time we need to decide which task is to be scheduled,
we retrieve the task with the highest priority.

The general name for such a data structure is a *priority queue*.
Priority queues typically support the following operations:

  - Adding a data element, together with a priority.
  - Obtaining the number of data elements currently in the structure.
  - Obtaining the maximum of all priorities of elements in the
    structure.
  - Removing a data element having maximum priority.

Obviously, the last two operations above can only be done when the
structure is nonempty. A variation on the above focuses on minimum
priority rather than maximum priority. This variation is called a
*min-priority queue*. Because we will later cover applications of
min-priority queues, we will focus on this variation in this section. In
the sub-sections that follow, we will first consider a general structure
that can be used in various ways to give efficient priority queue
implementations. We will then look at one specific implementation. We
will conclude by giving an example of how min-priority queues are used
in file compression algorithms.

<div class="NAVBAR">

[Next: Heaps](/~rhowell/DataStructures/redirect/heaps)       [Up:
Trees](/~rhowell/DataStructures/redirect/trees)      
[Top](/~rhowell/DataStructures/)

</div>

<span class="small">Last modified: Sat Mar 29 07:03:01 CDT 2014</span>

<span class="small">*© Copyright 2014, [Rod Howell](/~rhowell/). All
rights reserved.*</span>

|                                                                                            |
| :----------------------------------------------------------------------------------------: |
| [![Valid HTML 4.01\!](/~rhowell/valid-html401.gif)](http://validator.w3.org/check/referer) |
|   [![Valid CSS\!](/~howell/vcss.gif)](http://jigsaw.w3.org/css-validator/check/referer)    |
