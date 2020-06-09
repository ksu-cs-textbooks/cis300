+++
title = "Chapter 9.3 Tries"
date = 2018-08-24T10:53:05-05:00
weight = 48
chapter = true
pre = "<b>9.3 </b>"
+++

# Tries

[AVL trees](/~rhowell/DataStructures/redirect/avl-trees) give us an efficient mechanism for storage and  retrieval, particularly if we need to be able to process the elements in order of their keys.  However, there are special cases where we can achieve better performance.  One of these special cases occurs when we need to store a list of words, as we might need in a word game, for example.  For such applications, a _trie_ provides for even more efficient storage and retrieval.

In this section, we first define a trie and give a rather straightforward implementation.  We then show how to improve performance by implementing different nodes in different ways. We then examine the use of a preorder traversal to traverse a trie.  We conclude by discussing an example of using a trie in a word game.
