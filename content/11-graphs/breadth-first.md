# Unweighted Shortest Paths

In some shortest path problems, all edges have the same length. For
example, we may be trying to find the shortest path out of a maze. Each
cell in the maze is a node, and an edge connects two nodes if we can
move between them in a single step. In this problem, we simply want to
minimize the number of edges in a path to an exit. We therefore say that
the edges are *unweighted* - they contain no explicit length
information, and the length of each edge is considered to be 1.

We could of course apply [Dijkstra's
algorithm](/~rhowell/DataStructures/redirect/shortest-paths) to this
problem, using 1 as the length of each edge. However, if analyze what
this algorithm does in this case, we find that we can optimize it to
achieve significantly better performance.

The optimization revolves around the use of the min-priority queue. Note
that Dijkstra's algorithm first adds all outgoing edges from the start
node *u* to the min-priority queue, using their lengths as their
priorities. For unweighted edges, each of these priorities will be 1. As
the algorithm progresses it retrieves the minimum priority and removes
an edge having this priority. If it adds any new edges before removing
the next edge, they will all have a priority 1 greater than the priority
of the edge just removed.

We claim that this behavior causes the priorities in the min-priority
queue to differ by no more than 1. To see this, we will show that we can
never reach a point where we change the maximum difference in priorities
from no more than 1 to more than 1. First observe that when the outgoing
edges from *u* are added, the priorities all differ by
0Ã‚Â Ã¢â€°Â¤Ã‚Â 1. Removing an edge can't increase the
difference in the priorities stored. Suppose the edge we remove has
priority *p*. Assuming we have not yet achieved a priority difference
greater than 1, any priorities remaining in the min-priority queue must
be either *p* or *p*Ã‚Â +Ã‚Â 1. Any edges we add before removing the
next edge have priority *p*Ã‚Â +Ã‚Â 1. Hence, the priority difference
remains no more than 1. Because we have covered all changes to the
priority queue, we can never cause the priority difference to exceed 1.

Based on the above claim, we can now claim that whenever an edge is
added, its priority is the largest of any in the min-priority queue.
This is certainly true when we add the outgoing edges from *u*, as all
these edges have the same priority. Furthermore, whenever we remove an
edge with priority *p*, any edges we subsequently add have priority
*p*Ã‚Â +Ã‚Â 1, which must be the maximum priority in the min-priority
queue.

As a result of this behavior, we can replace the min-priority queue with
an ordinary [FIFO queue](/~rhowell/DataStructures/redirect/queues), and
for unweighted edges, the behavior of the algorithm will be the same.
Because accessing a FIFO queue is more efficient than accessing a
min-priority queue, the resulting algorithm, known as *breadth-first
search*, is also more efficient.
