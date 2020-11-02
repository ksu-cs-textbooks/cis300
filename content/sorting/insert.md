+++
title = "Insert Sorts"
date = 2018-08-24T10:53:05-05:00
weight = 20
chapter = true
pre = "<b>9.2. </b>"
+++

## Insert Sorts

An insert sort operates by repeatedly inserting an element into a sorted
portion of the array. Thus, as for select sorts, at each step the data
items will be arranged into a sorted part, followed by an unsorted part;
however, for insert sorts, there is no restriction on how elements in
the unsorted part compare to elements in the sorted part. The following
figure illustrates this arrangement.

![The arrangement at each step of an insert sort.](insert-sorts.jpg)

Initially, the sorted part will contain the first element, as a single
element is always sorted. At each step, the first element in the
unsorted part is inserted into its proper location in the sorted part.
As a result, the sorted part now contains one more element, and the
unsorted part one fewer element. After $n - 1$ steps, where $n$ is
the number of elements in the array, the sorted part will contain all
the elements, and the algorithm will be done.

Again, this approach can be implemented in various ways. The main
difference in these implementations is in how we insert an element. The
most straightforward way is as follows:

1.  Copy the first element of the unsorted part to a temporary variable.
2.  Iterate from the location of the first element of the unsorted part
    toward the front of the array as long as we are at an index greater
    than 0 and the element to the left of the current index is greater
    than the element in the temporary variable. On each iteration:
      - Copy the element to the left of the current index to the current
        index.
3.  Place the value in the temporary variable into the location at which
    the above loop stopped.

The algorithm that uses the above insertion technique is known as
*insertion sort*. Like selection sort, it requires an outer loop to keep
track of the number of elements in the sorted part. Each iteration of
this outer loop performs the above insertion algorithm. It is not hard
to see that this algorithm is
[stable](/sorting/select/#stable).

The main advantage insertion sort has over [selection
sort](/sorting/select) is that the inner
loop only iterates as long as necessary to find the insertion point. In
the worst case, it will iterate over the entire sorted part. In this
case, the number of iterations is the same as for selection sort; hence,
the worst-case running time is in $O(n^2)$ --- the same as
selection sort and [bubble
sort](/sorting/select/#bubble-sort). At the other
extreme, however, if the array is already sorted, the inner loop won't
need to iterate at all. In this case, the running time is in <span style="white-space:nowrap">$O(n)$,</span>
which is the same as the running time of bubble sort on an array that is
already sorted.

Unlike bubble sort, however, insertion sort has a clean characterization
of its performance based on how sorted the array is. This
characterization is based on the notion of an *inversion*, which is a
pair of array locations $i \lt j$ such that the value at location
$i$ is greater than the value at location <span style="white-space:nowrap">$j$;</span> i.e., these two values
are out of order with respect to each other. A sorted array has no
inversions, whereas in an array of distinct elements in reverse order, every pair of
locations is an inversion, for a total of $n(n - 1)/2$
inversions. In general, we can say that the fewer inversions an array
has, the more sorted it is.

The reason why inversions are important to understanding the performance
of insertion sort is that each iteration of the inner loop (i.e., step 2
of the insertion algorithm above) removes exactly one inversion.
Consequently, if an array initially has $k$ inversions, the inner loop
will iterate a total of $k$ times. If we combine this with the
$n - 1$ iterations of the outer loop, we can conclude that
the running time of insertion sort is in <span style="white-space:nowrap">$O(n + k)$.</span> Thus, if
the number of inversions is relatively small in comparison to $n$ (i.e.,
the array is nearly sorted), insertion sort runs in $O(n)$ time. (By
contrast, $n - 2$ inversions can be enough to cause the inner loop
of bubble sort to iterate its worst-case number of times.) For this
reason, insertion sort is the algorithm of choice when we expect the
data to be nearly sorted --- a scenario that occurs frequently in
practice. This fact is exploited by an efficient hybrid algorithm that
combines insertion sort with two other sorting algorithms - see "[Hybrid
Sorts](/sorting/hybrid)" for more
details.

Before we consider another insert sort, there is one other advantage to
insertion sort that we need to consider. Because the algorithm is simple
(like selection sort and bubble sort), it performs well on small arrays.
More complex algorithms like [heap
sort](/sorting/select/#heap-sort), while providing much
better worst-case performance for larger arrays, don't tend to perform
as well on small arrays. In many cases, the performance difference on
small arrays isn't enough to matter, as pretty much any algorithm will
perform reasonably well on a small array. However, this performance
difference can become significant if we need to sort many small arrays
(in a later section, we will see an application in which this scenario
occurs). Because insertion sort tends to out-perform both selection sort
and bubble sort, it is usually the best choice when sorting small
arrays.

<span id="tree-sort"></span> Another way to implement an insert sort is
to use a balanced binary search tree, such as an [AVL
tree](/trees/avl), to store the sorted
part. In order to do this, we need to modify [the definition of a binary
search tree](/trees/bst/intro) to allow
multiple instances of the same key. In order to achieve stability, if we
are inserting a key that is equal to a key already in the tree, we would
treat the new key as being greater than the pre-existing key - i.e., we
would recursively insert it into the right child. Once all the data
items are inserted, we would then copy them back into the array in
sorted order using an [inorder
traversal](/trees/bst/inorder). We call
this algorithm *tree sort*.

This algorithm doesn't exactly match the above description of an insert
sort, but it is not hard to see that it follows the same general
principles. While the sorted portion is not a part of the array, but
instead is a separate data structure, it does hold an initial part of
the array in sorted order, and successive elements from the unsorted
portion are inserted into it.

Because insertions into an AVL tree containing $k$ elements can be done
in $O(\lg k)$ time in the worst case, and because an inorder traversal
can be done in $O(k)$ time, it follows that tree sort runs in $O(n
\lg n)$ time in the worst case, where $n$ is the number of elements in
the array. However, because maintaining an AVL tree requires more
overhead than maintaining a binary heap, heap sort tends to give better
performance in practice. For this reason, tree sort is rarely used.
