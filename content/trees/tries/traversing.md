+++
title = "Traversing a Trie"
weight = 30

pre = "<b>6.4.3. </b>"
+++

## Traversing a Trie

As with other kinds of trees, there are occasions where we need to
process all the elements stored in a trie in order. Here, the elements
are strings, which are not stored explicitly in the trie, but implicitly
based on the labels of various nodes. Thus, an individual node does not
contain a **string**; however, if its **bool** has a value of **true**,
then the path to that node describes a string stored in the trie. We can
therefore associate this string with this node. Note that this string is
a prefix of any string associated with any node in any of this node's
children; hence, it is alphabetically less than any string found in any
of the children. Thus, in order to process each of the strings in
alphabetic order, we need to do a [preorder
traversal](/trees/tries/intro), which
processes the root before recursively processing the children.

In order to process the string associated with a node, we need to be
able to retrieve this string. Because we will have followed the path
describing this string in order to get to the node associated with it,
we can build this string on the way to the node and pass it as a
parameter to the preorder traversal of the trie rooted at this node.
Because we will be building this string a character at a time, to do
this efficiently we should use a
[**StringBuilder**](/strings/stringbuilders)
instead of a **string**. Thus, the preorder traversal method for a trie
will take a **StringBuilder** parameter describing the path to that
trie, in addition to any other parameters needed to process the strings
associated with its nodes.

Before we present the algorithm itself, we need to address one more
important issue. We want the **StringBuilder** parameter to describe the
path to the node we are currently working on. Because we will need to do
a recursive call on each child, we will need to modify the
**StringBuilder** to reflect the path to that child. In order to be able
to do this, we will need to ensure that the recursive calls don't change
the contents of the **StringBuilder** (or more precisely, that they undo
any changes that they make).

Because we are implementing a preorder traversal, the first thing we
will need to do is to process the root. This involves determining
whether the root is associated with a string contained in the trie, and
if so, processing that string. Determining whether the root is
associated with a contained string is done by checking the **bool** at
the root. If it is **true**, we can convert the **StringBuilder**
parameter to a **string** and process it by doing whatever processing
needs to be done for each string in our specific application.

Once we have processed the root, we need to recursively process each of
the children in alphabetic order of their labels. How we accomplish this
depends on how we are implementing the trie - we will assume the
implementation of [the previous
section](/trees/tries/multiple-impl). Because
this implementation uses three different classes depending on how many
children a node has, we will need to write three different versions of
the preorder traversal, one for each class. Specifically, after processing the root:

  - For a **TrieWithNoChildren**, there is nothing more to do.
  - Because a **TrieWithOneChild** has exactly one child, we need a
    single recursive call on this child. Before we make this call, we
    will need to append the child's label to the **StringBuilder**.
    Following the recursive call, we will need to remove the character
    that we added by reducing its
    [**Length**](https://learn.microsoft.com/en-us/dotnet/api/system.text.stringbuilder.length?view=net-6.0#system-text-stringbuilder-length)
    property by 1.
  - We handle a **TrieWithManyChildren** in a similar way as a
    **TrieWithOneChild**, only we will need to iterate through the
    array of children and process each non-**null** child with a
    recursive call. Note that for each of these children, its label will
    need to be appended to the **StringBuilder** prior to the recursive
    call and removed immediately after. We can obtain the label of a
    child by adding the first letter of the alphabet to its array index and
    [casting](/stacks-queues/stacks/#cast) the result to a
    **char**.
