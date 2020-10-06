+++
title = "Leftist Heaps"
date = 2018-08-24T10:53:05-05:00
weight = 20
chapter = true
pre = "<b>6.5.2. </b>"
+++

## Leftist Heaps

One efficient way to complete the merge algorithm outlined in [the
previous section](/trees/priority-queues/heaps) revolves
around the concept of the *null path length* of a tree, which is defined
to be $0$ for empty trees, or one more than the minimum of the null path
lengths of the children for nonempty trees. Another way to understand
this concept is that it gives the minimum number of steps needed to get
from the root to an empty subtree. For an empty tree, there is no root,
so we somewhat arbitrarily define the null path length to be <span style="white-space:nowrap">$0$.</span> For
single-node trees or binary trees with at least one empty child, the
null path length is $1$ because only one step is needed to reach an empty
subtree.

One reason that the null path length is important is that it can be
shown that any binary tree with $n$ nodes has a null path length that is
no more than <span style="white-space:nowrap">$\lg(n + 1)$.</span> Furthermore, recall that in the merging
strategy outlined in [the previous
section](/trees/priority-queues/heaps), there is some
flexibility in choosing which child of a node will be used in the
recursive call. Because the strategy reaches a base case when one of the
min-heaps is empty, the algorithm will terminate the most quickly if we
do the recursive call on the child leading us more quickly to an empty
subtree --- i.e., if we use the child with smaller null path length.
Because this length is logarithmic in the number of nodes in the
min-heap, this choice will quickly lead us to the base case and
termination.

A common way of implementing this idea is to use what is known as a
*leftist heap*. A leftist heap is a binary tree that forms a heap such
that for every node, the null path length of the right child is no more
than the null path length of the left child. For such a structure,
completing the merge algorithm is simple:

  - For the recursive call, we merge the right child of *s* with *b*,
    where *s* and *b* are as defined in [the previous
    section](/trees/priority-queues/heaps).
  - When combining the root and left child of *s* with the result of the
    recursive call, we arrange the children so that the result is a
    leftist heap.

We can implement this idea by defining two classes, **LeftistTree\<T\>**
and **MinPriorityQueue\<TPriority, TValue\>**. For the
**LeftistTree\<T\>** class, we will only be concerned with the shape of
the tree --- namely, that the null path length of the right child is never
more than the null path length of the left child. We will adopt a
strategy similar to what we did with [AVL
trees](/trees/avl). Specifically a
**LeftistTree\<T\>** will be immutable so that we can always be sure
that it is shaped properly. It will then be a straightforward matter to
implement a **MinPriorityQueue\<TPriority, TValue\>**, where
**TPriority** is the type of the priorities, and **TValue** is the type
of the values.

The implementation of **LeftistTree\<T\>** ends up being very similar to
the implementation we described for [AVL tree
nodes](/trees/avl), but without the
rotations. We need three **public** properties using the default
implementation with **get** accessors: the data (of type **T**) and the
two children (of type **LeftistTree\<T\>**). We also need a **private**
field to store the null path length (of type **int**). We can define a
**static** method to obtain the null path length of a given
**LeftistTree\<T\>**. This method is essentially the same as the
**Height** method for an AVL tree, except that if the given tree is
**null**, we return 0. A constructor takes as its parameters a data
element of type **T** and two children of type **LeftistTree\<T\>**. It
can initialize its data with the first parameter. To initialize its
children, it first needs to determine their null path lengths using the
**static** method above. It then assigns the two **LeftistTree\<T\>**
parameters to its child fields so that the right child's null path
length is no more than the left child's. Finally, it can initialize its
own null path length by adding 1 to its right child's null path length.

<span id="where"></span> Let's now consider how we can implement
**MinPriorityQueue\<TPriority, TValue\>**. The first thing we need to
consider is the type, **TPriority**. This needs to be a type that can be
ordered (usually it will be a numeric type like **int**). We can
restrict **TPriority** to be a subtype of **IComparable\<TPriority\>**
by using a **where** clause, as we did for dictionaries (see
"[Implementing a Dictionary with a Linked
List](/dictionaries/linked-list-impl)").

We then need a **private** field in which to store a leftist tree. We
can store both the priority and the data element in a node if we use a
**LeftistTree\<KeyValuePair\<TPriority, TValue\>\>**; thus, the keys are
the priorities and the values are the data elements. We also need a
**public int** property to get of the number of elements in the
min-priority queue. This property can use the default implementation
with **get** and **private set** accessors.

In order to implement **public** methods to add an element with a
priority and to remove an element with minimum priority, we need the
following method:

```c#
private static LeftistTree<KeyValuePair<TPriority, TValue>>
    Merge(LeftistTree<KeyValuePair<TPriority, TValue>> h1, 
        LeftistTree<KeyValuePair<TPriority, TValue>> h2)
{
    . . .
}
```

This method consist of three cases. The first two cases occur when
either of the parameters is **null**. In each such case, we return the
other parameter. In the third case, when neither parameter is **null**,
we first need to compare the priorities in the data stored in the root
nodes of the parameters. A priority is stored in the
[**Key**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.keyvaluepair-2.key?view=netframework-4.7.2)
property of the **KeyValuePair**, and we have constrained this type so
that it has a **CompareTo** method that will compare one instance with
another. Once we have determined which root has a smaller priority, we
can construct and return a new
**LeftistTree\<KeyValuePair\<TPriority, TValue\>\>** whose data
is the data element with smaller priority, and whose children are the
left child of this data element and the result of recursively merging
the right child of this element with the parameter whose root has larger
priority.

The remaining methods and properties of
**MinPriorityQueue\<TPriority, TValue\>** are now fairly
straightforward.
