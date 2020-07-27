+++
title = "Implementing a Graph"
date = 2018-08-24T10:53:05-05:00
weight = 40
chapter = true
pre = "<b>8.4. </b>"
+++

## Implementing a Graph

Traditionally, there are two main techniques for implementing a graph.
Each of these techniques has advantages and disadvantages, depending on
the characteristics of the graph. In this section, we describe the
implementation of the **DirectedGraph\<TNode, TEdgeData\>** class
from [**Ksu.Cis300.Graphs.dll**](Ksu.Cis300.Graphs.dll). This
implementation borrows from both traditional techniques to obtain an
implementation that provides good performance for any graph. In what
follows, we will first describe the two traditional techniques and
discuss the strengths and weaknesses of each. We will then outline the
implementation of **DirectedGraph\<TNode, TEdgeData\>**.

The first traditional technique is to use what we call an *adjacency
matrix*. This matrix is a **bool\[n, n\]**, where *n* is the number
of nodes in the graph. In this implementation, each node is represented
by an **int** value *i*, where 0 Ã¢â€°Â¤ *i* \< *n*. The
value at row *i* and column *j* will be **true** if there is an edge
from node *i* to node *j*.

The main advantage to this technique is that we can very quickly
determine whether an edge exists - we only need to look up one element
in an array. There are several disadvantages, however. First, we are
forced to use a specific range of **int** values as the nodes. If we
wish to have a generic node type, we need an additional data structure
(such as a **Dictionary\<TNode, int\>**) to map each node to its
**int** representation. It also fails to provide a way to associate a
value with an edge; hence, we would need an additional data structure
(such as a **TEdgeData\[int, int\]**) to store this information.

Perhaps the most serious shortcoming for the adjacency matrix, however,
is that if the graph contains a large number of nodes, but relatively
few edges, it wastes a huge amount of space. Suppose, for example, that
we have a graph representing street information, and suppose there are
about one million nodes in this graph. We might expect the graph to
contain around three million edges. However, an adjacency matrix would
require one trillion entries, almost all of which will be **false**.
Similarly, finding the edges from a given node would require examining
an entire row of a million elements to find the three or four outgoing
edges from that node.

The other traditional technique involves using what we call *adjacency
lists*. An adjacency list is simply a linked list containing
descriptions of the outgoing edges from a single node. These lists are
traditionally grouped together in an array of size *n*, where *n* is
again the number of nodes in the graph. As with the adjacency matrix
technique, the nodes must be nonnegative **int**s less than *n*. The
linked list at location *i* of the array then contains the descriptions
of the outgoing edges from node *i*.

One advantage to this technique is that the amount of space it uses is
proportional to the size of the graph (i.e., the number of nodes plus
the number of edges). Furthermore, obtaining the outgoing edges from a
given node simply requires traversing the linked list containing the
descriptions of these edges. Note also that we can store the data
associated with an edge within the linked list cell describing that
edge. However, this technique still requires some modification if we
wish to use a generic node type. A more serious weakness, though, is
that in order to determine if a given edge exists, we must search
through potentially all of the outgoing edges from a given node. If the
number of edges is large in comparison to the number of nodes, this
search can be expensive.

As we mentioned above, our implementation of
**DirectedGraph\<TNode, TEdgeData\>** borrows from both of these
traditional techniques. We start by modifying the adjacency lists
technique to use a **Dictionary\<TNode, LinkedListCell\<TNode\>\>**
instead of an array of linked lists. Thus, we can accommodate a generic
node type while maintaining efficient access to the adjacency lists.
While a dictionary lookup is not quite as efficient as an array lookup,
a dictionary would provide the most efficient way of mapping nodes of a
generic type to **int** array indices. Using a dictionary instead of an
array eliminates the need to do a subsequent array lookup. The linked
list associated with a given node in this dictionary will then contain
the destination node of each outgoing edge from the given node.

In addition to this dictionary, we use a
**Dictionary\<(TNode, TNode), TEdgeData\>** to facilitate
efficient edge lookups. The notation **(T1, T2)** defines a *value
tuple*, which is an ordered pair of elements, the first of type **T1**,
and the second of type **T2**. Elements of this type are described with
similar notation, `(x, y)`, where `x` is of type **T1** and `y` is of
type **T2**. These elements can be accessed using the **public**
properties **Item1** and **Item2**. In general, longer tuples can be
defined similarly.

This second dictionary essentially fills the role of an adjacency
matrix, while accommodating a generic node type and using space more
efficiently. Specifically, a tuple whose **Item1** is `u` and whose
**Item2** is `v` will be a key in this dictionary if there is an edge
from node `u` to node `v`. The value associated with this key will be
the data associated with this edge. Thus, looking up an edge consists of
a single dictionary lookup.

The two dictionaries described above are the only **private** fields our
implementation needs. We will refer to them as `_adjacencyLists` and
`_edges`, respectively. Because we can initialize both fields to new
dictionaries, there is no need to define a constructor. Furthermore,
given these two dictionaries, most of the **public** methods and
properties (see "[Introduction to
Graphs](/~rhowell/DataStructures/redirect/graph-intro)") can be
implemented using a single call to one of the members of one of these
dictionaries:

  - **void AddNode(TNode node)**: We can implement this method using the
    [**Add**](http://msdn.microsoft.com/en-us/library/k7z0zy8k.aspx)
    method of `_adjacencyLists`. We associate an empty linked list with
    this node.
  - **void AddEdge(TNode source, TNode dest, TEdgeData value)**: See
    below.
  - **bool TryGetEdge(TNode source, TNode dest, out TEdgeData value)**:
    We can implement this method using the
    [**TryGetValue**](http://msdn.microsoft.com/en-us/library/bb347013.aspx)
    method of `_edges`.
  - **int NodeCount**: Because `_adjacencyLists` contains all of the
    nodes as keys, we can implement this property using this
    dictionary's
    [**Count**](http://msdn.microsoft.com/en-us/library/zhcy256f.aspx)
    property.
  - **int EdgeCount**: We can implement this property using the
    **Count** property of `_edges`.
  - **bool ContainsNode(TNode node)**: We can implement this method
    using the
    [**ContainsKey**](http://msdn.microsoft.com/en-us/library/kw5aaea4.aspx)
    method of `_adjacencyLists`.
  - **bool ContainsEdge(TNode source, TNode dest)**: We can implement
    this method using the **ContainsKey** method of `_edges`.
  - **IEnumerable\<TNode\> Nodes**: We can implement this property using
    the
    [**Keys**](http://msdn.microsoft.com/en-us/library/yt2fy5zk.aspx)
    property of `_adjacencyLists`.
  - **IEnumerable\<Edge\<TNode, TEdgeData\>\> OutgoingEdges(TNode
    source)**: See below.

Let's now consider the implementation of the **AddEdge** method. Recall
from "[Introduction to
Graphs](/~rhowell/DataStructures/redirect/graph-intro)" that this method
adds an edge from `source` to `dest` with data item `value`. If either
`source` or `dest` is not already in the graph, it will be added. If
either `source` or `dest` is **null**, it will throw an
**ArgumentNullException**. If `source` and `dest` are the same, or if
the edge already exists in the graph, it will throw an
**ArgumentException**.

In order to avoid changing the graph if the parameters are bad, we
should do the error checking first. However, there is no need to check
whether the edge already exists, provided we update `_edges` using its
[**Add**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2.add?view=netframework-4.7.2#System_Collections_Generic_Dictionary_2_Add__0__1_)
method, and that we do this before making any other changes to the
graph. Because a dictionary's **Add** method will throw an
**ArgumentException** if the given key is already in the dictionary, it
takes care of this error checking for us. The key that we need to add
will be a **(TNode, TNode)** containing the two nodes, and the value
will be the `value`.

After we have updated `_edges`, we need to update `_adjacencyLists`. To
do this, we first need to obtain the linked list associated with the key
`source` in `_adjacencyLists`; however, because `source` may not exist
as a key in this dictionary, we should use the
[**TryGetValue**](http://msdn.microsoft.com/en-us/library/bb347013.aspx)
method to do this lookup (note that if `source` is not a key in this
dictionary, the **out** parameter will be set to **null**, which we can
interpret as an empty list). We then construct a new linked list cell,
in which we place `dest`. We then insert this cell at the beginning of
the linked list we retrieved, and set this linked list as the new value
associated with `source` in `_adjacencyLists`. Finally, if
`_adjacencyLists` doesn't already contain `dest` as a key, we need to
add it with **null** as its associated value.

Finally, we need to implement the **OutgoingEdges** method. Because this
method returns an **IEnumerable\<Edge\<TNode, TEdgeData\>\>**, it
needs to iterate through the cells of the linked list associated with
the given node in `_adjacencyLists`. For each of these cells, it will
need to **yield return** (see
"[Enumerators](http://people.cs.ksu.edu/~rhowell/DataStructures/redirect/enumerators)")
an **Edge\<TNode, TEdgeData\>** describing the edge represented by
that cell. The source node for this edge will be the node given to this
method. The destination node will be the node stored in the cell. The
edge data can be obtained from the dictionary `_edges`.
