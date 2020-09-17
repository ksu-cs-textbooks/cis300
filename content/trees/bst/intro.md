+++
title = "Introduction to Binary Search Trees"
date = 2018-08-24T10:53:05-05:00
weight = 20
chapter = true
pre = "<b>6.2.2. </b>"
+++

## Introduction to Binary Search Trees

In this section and [the
next](/trees/bst/remove),
we will present a binary search tree as a data structure that can be
used to implement a
[dictionary](/dictionaries)
whose key type can be ordered. This implementation will provide
efficient lookups, insertions, and deletions in most cases; however,
there will be cases in which the performance is bad. In [a later
section](/trees/avl),
we will show how to extend this good performance to all cases.

A *binary search tree* is a [binary
tree](/trees/bst/binary-trees) containing
key-value pairs whose keys can be ordered. Furthermore, the data items
are arranged such that the key in each node is:

  - greater than all the keys in its left child; and
  - less than all the keys in its right child.

Note that this implies that all keys must be unique. For example, the
following is a binary search tree storing integer keys (only the keys
are shown):

![A binary search tree](binary-search-tree-ex.jpg)

The hierarchical nature of this structure allows us to do something like
a binary search to find a key. Suppose, for example, that we are looking
for 41 in the above tree. We first compare 41 with the key in the root.
Because 41 \< 54, we can safely ignore the right child, as all
keys there must be greater than 54. We therefore compare 41 to the key
in the root of the left child. Because 41 \> 23, we look in the
right child, and compare 41 to 35. Because 41 \> 35, we look in
the right child, where we find the key we are looking for.

Note the similarity of the search described above to a binary search. It
isn't exactly the same, because there is no guarantee that the root is
the middle element in the tree --- in fact, it could be the first or the
last. In many applications, however, when we build a binary search tree
as we will describe below, the root of the tree tends to be roughly the
middle element. When this is the case, looking up a key is very
efficient. [Later](/trees/avl), we will
show how we can build and maintain a binary search tree so that this is
always the case.

It isn't hard to implement the search strategy outlined above using a
loop. However, in order to reinforce the concept of recursion as a tree
processing technique, let's consider how we would implement the search
using recursion. The algorithm breaks into four cases:

  - The tree is empty. In this case, the element we are looking for is
    not present.
  - The key we are looking for is at the root - we have found what we
    are looking for.
  - The key we are looking for is less than the key at the root. We then
    need to look for the given key in the left child. Because this is a
    smaller instance of our original problem, we can solve it using a
    recursive call.
  - The key we are looking for is greater than the key at the root. We
    then look in the right child using a recursive call.

{{% notice warning %}}
It is important to handle the case of an empty tree first, as the other
cases don't make sense if the tree is empty. In fact, if we are using
**null** to represent an empty binary search tree (as is fairly common),
we will get a **NullReferenceException** if we try to access the key
at the root.
{{% /notice %}}

If we need to compare
elements using a
[**CompareTo**](https://docs.microsoft.com/en-us/dotnet/api/system.icomparable-1.compareto?view=netframework-4.7.2)
method, it would be more efficient to structure the code so that this
method is only called once; e.g.,

  - If the tree is empty . . . .
  - Otherwise:
      - Get the result of the comparison.
      - If the result is 0 . . . .
      - Otherwise, if the result is negative . . . .
      - Otherwise . . . .

This method would need to take two parameters --- the key we are looking
for and the tree we are looking in. This second parameter will actually
be a reference to a node, which will either be the root of the tree or
**null** if the tree is empty. Because this method requires a parameter
that is not provided to the **TryGetValue** method, this method would be
a **private** method that the **TryGetValue** method can call. This
**private** method would then return the node containing the key, or
**null** if this key was not found. The **TryGetValue** method can be
implemented easily using this **private** method.

We also need to be able to implement the **Add** method. Let's first
consider how to do this assuming we are representing our binary search
tree with immutable nodes. The first thing to observe is that because we
can't modify an immutable node, we will need to build a binary search
tree containing the nodes in the current tree, plus a new node
containing the new key and value. In order to accomplish this, we will
describe a **private** recursive method that returns the result of
adding a given key and value to a given binary search tree. The **Add**
method will then need to call this **private** method and save the
resulting tree.

We therefore want to design a **private** method that will take three
parameters:

  - a binary search tree (i.e., reference to a node);
  - the key we want to add; and
  - the value we want to add.

It will return the binary search tree that results from adding the given
key and value to the given tree.

This method again has four cases:

  - The tree is empty. In this case, we need to construct a node
    containing the given key and value and two empty children, and
    return this node as the resulting tree.
  - The root of the tree contains a key equal to the given key. In this
    case, we can't add the item - we need to throw an exception.
  - The given key is less than the key at the root. We can then use a
    recursive call to add the given key and value to the left child. The
    tree returned by the recursive call needs to be the left child of
    the result to be returned by the method. We therefore construct a
    new node containing the data and right child from the given tree,
    but having the result of the recursive call as its left child. We
    return this new node.
  - The given key is greater than the key at the root. We use a
    recursive call to add it to the right child, and construct a new
    node with the result of the recursive call as its right child. We
    return this new node.

Note that the above algorithm only adds the given data item when it
reaches an empty tree. Not only is this the most straightforward way to
add items, but it also tends to keep paths in the tree short, as each
insertion is only lengthening one path. [This
page](http://cs.ksu.edu/~rhowell/viewer/index.html) contains an
application that will 
show the result of adding a key at a time to a binary search tree. 

{{% notice warning %}}
The
keys in this application are treated as strings; hence, you can use
numbers if you want, but they will be compared as strings (e.g.,
"10" \< "5" because '1' \< '5'). For this reason, it is
usually better to use either letters, words, or integers that all have
the same number of digits.
{{% /notice %}}

The above algorithm can be implemented in the same way if mutable binary
tree nodes are used; however, we can improve its performance a bit by
avoiding the construction of new nodes when recursive calls are made.
Instead, we can change the child to refer to the tree returned. If we
make this optimization, the tree we return will be the same one that we
were given in the cases that make recursive calls. However, we still
need to construct a new node in the case in which the tree is empty. For
this reason, it is still necessary to return the resulting tree, and we
need to make sure that the **Add** method always uses the returned tree.
