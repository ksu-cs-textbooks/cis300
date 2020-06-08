# Binary Search Trees

<div class="TOC">

## Contents

1.  [Binary Trees](/~rhowell/DataStructures/redirect/binary-trees)
2.  [Introduction to Binary Search
    Trees](/~rhowell/DataStructures/redirect/bst-intro)
3.  [Removing from a Binary Search
    Tree](/~rhowell/DataStructures/redirect/bst-remove)
4.  [Inorder
    Traversal](/~rhowell/DataStructures/redirect/inorder-traversal)

</div>

We motivated our discussion of trees by expressing a need for a linked
data structure that supports a binary search or something similar. We
will present such a data structure - a binary search tree - in this
section. While it will support efficient lookups, insertions, and
deletions for many applications, we will see that there are cases in
which it performs no better than a linked list. In [the next
section](/~rhowell/DataStructures/redirect/avl-trees), we will add some
refinements that will guarantee good performance.

Before we can define a binary search tree, we need to define a more
primitive structure, a *binary tree*. We will then use binary trees to
define binary search trees, and show how to build them and search them.
We will then show how to remove elements from them. We conclude this
section by presenting the *inorder traversal* algorithm, which processes
all the elements in a binary search tree in order.
