# Binary Trees

A *binary tree* is a tree in which each node has exactly two children,
either of which may be empty. For example, the following is a binary
tree:

![A binary tree](binary-tree.jpg)

Note that some of the nodes above are drawn with only one child or no
children at all. In these cases, one or both children are empty. Note
that we always draw one child to the left and one child to the right. As
a result, if one child is empty, we can always tell which child is empty
and which child is not. We call the two children the *left* child and
the *right* child.

We can implement a single node of a binary tree as a data structure and
use it to store data. The implementation is simple, like [the
implementation of a linked list
cell](/~rhowell/DataStructures/redirect/linked-list-intro). Let's call
this type **BinaryTreeNode\<T\>**, where **T** will be the type of data
we will store in it. We need three **public** properties:

  - a **Data** property of type **T**;
  - a **LeftChild** property of type **BinaryTreeNode\<T\>**; and
  - a **RightChild** property of type **BinaryTreeNode\<T\>**.

We can define both **get** and **set** accessors using the default
implementation for each of these properties. However, it is sometimes
advantageous to make this type immutable. In such a case, we would not
define any **set** accessors, but we would need to be sure to define a
constructor that takes three parameters to initialize these three
properties. While immutable nodes tend to degrade the performance
slightly, they also tend to be easier to work with. For example, with
immutable nodes it is impossible to build a structure with a cycle in
it.
