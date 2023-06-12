+++
title = "Select Sorts"
weight = 10

pre = "<b>9.1. </b>"
+++

## Select Sorts

A select sort operates by repeatedly selecting the smallest data element
of an unsorted portion of the array and moving it to the end of a sorted
portion. Thus, at each step, the data items will be arranged into two
parts:

1.  A sorted part; and
2.  An unsorted part in which each element is at least as large as all
    elements in the sorted part.

The following figure illustrates this arrangement.

![The arrangement at each step of a select sort.](select-sorts.jpg)

Initially, the sorted part will be empty. At each step, the unsorted
part is rearranged so that its smallest element comes first. As a
result, the sorted part can now contain one more element, and the
unsorted part one fewer element. After {{< math >}}$ n - 1 ${{< /math >}} steps, where {{< math >}}$ n ${{< /math >}} is
the number of elements in the array, the sorted part will have all but
one of the elements. Because the one element in the unsorted part must
be at least as large as all elements in the sorted part, the entire
array will be sorted at this point.

The approach outlined above can be implemented in various ways. The main
difference in these implementations is in how we rearrange the unsorted
part to bring its smallest element to the beginning of that part. The
most straightforward way to do this is to find the smallest element in
this part, then swap it with the first element in this part. The
resulting algorithm is called *selection sort*. It requires nested
loops. The outer loop index keeps track of how many elements are in the
sorted part. The unsorted part then begins at this index. The inner loop
is responsible for finding the smallest element in the unsorted part.
Once the inner loop has finished, the smallest element is swapped with
the first element in the unsorted part.

Note that the inner loop in selection sort iterates once for every
element in the unsorted part. On the first iteration of the outer loop,
the unsorted part contains all {{< math >}}$ n ${{< /math >}} elements. On each successive
iteration, the unsorted part is one element smaller, until on the last
iteration, it has only {{< math >}}$ 2 ${{< /math >}} elements. If we add up all these values, we
find that the inner loop iterates a total of exactly
{{< math >}}$ (n - 1)(n + 2)/2 ${{< /math >}} times. This value is
proportional to {{< math >}}$ n^2 ${{< /math >}} as {{< math >}}$ n ${{< /math >}} increases; hence, the running
time of the algorithm is in {{< math >}}$ O(n^2) ${{< /math >}}. Furthermore, this
performance occurs no matter how the data items are initially arranged.

As we will see in what follows, {{< math >}}$ O(n^2) ${{< /math >}} performance is not
very good if we want to sort a moderately large data set. For example,
sorting {{< math >}}$ 100,000 ${{< /math >}} elements will require about {{< math >}}$ 5 ${{< /math >}} billion iterations of the
inner loop. On the positive side, the only time data items are moved is
when a swap is made at the end of the outer loop; hence, this number is
proportional to {{< math >}}$ n ${{< /math >}}. This could be advantageous if we are sorting large
value types, as we would not need to write these large data elements
very many times. However, for general performance reasons, large data
types shouldn't be value types --- they should be reference types to avoid
unnecessary copying of the values. For this reason, selection sort isn't
a particularly good sorting algorithm.

<span id="stable"></span> Performance issues aside, however, there is
one positive aspect to selection sort. This aspect has to do with
sorting by keys. Consider, for example, the rows of a spreadsheet. We
often want to sort these rows by the values in a specific column. These
values are the sort keys of the elements. In such a scenario, it is
possible that two data elements are different, but their sort keys are
the same. A sorting algorithm might reverse the order of these elements,
or it might leave their order the unchanged. In some cases, it is
advantageous for a sorting algorithm to leave the order of these
elements unchanged. For example, if we sort first by a secondary key,
then by a primary key, we would like for elements whose primary keys are
equal to remain sorted by their secondary key. Therefore, a sorting
algorithm that always maintains the original order of equal keys is said
to be *stable*. If we are careful how we implement the inner loop of
selection sort so that we always select the first instance of the
smallest key, then this algorithm is stable.

<span id="bubble-sort"></span> Another implementation of a select sort
is *bubble sort*. It rearranges the unsorted part by swapping adjacent
elements that are out of order. It starts with the last two elements
(i.e., the elements at locations {{< math >}}$ n - 1 ${{< /math >}} and <span style="white-space:nowrap">{{< math >}}$ n - 2 ${{< /math >}})</span>, then
the elements at locations {{< math >}}$ n - 2 ${{< /math >}} and <span style="white-space:nowrap">{{< math >}}$ n - 3 ${{< /math >}},</span> etc.
Proceeding in this way, the smallest element in the unsorted part will
end up at the beginning of the unsorted part. While the inner loop is
doing this, it keeps track of whether it has made any swaps. If the loop
completes without having made any swaps, then the array is sorted, and
the algorithm therefore stops.

Like selection sort, bubble sort is stable. In the worst case, however,
the performance of bubble sort is even worse than that of selection
sort. It is still in <span style="white-space:nowrap">{{< math >}}$ O(n^2) ${{< /math >}},</span> but in the worst case, its
inner loop performs the same number of iterations, but does a lot more
swaps. Bubble sort does outperform selection sort on some inputs, but
describing when this will occur isn't easy. For example, in an array in
which the largest element occurs in the first location, and the
remaining locations are sorted, the performance ends up being about the
same as selection sort --- even though this array is nearly sorted. Like
selection sort, it is best to avoid bubble sort.

<span id="heap-sort"></span> A select sort that significantly
outperforms selection sort is known as *heap sort*. This algorithm is
based on the idea that a priority queue can be used to sort data --- we
first place all items in a priority queue, using the values themselves
as priorities (if we are sorting by keys, then we use the keys as
priorities). We then repeatedly remove the element with largest
priority, filling the array from back to front with these elements.

We can optimize the above algorithm by using a priority queue
implementation called a *binary heap*, whose implementation details we
will only sketch. The basic idea is that we can form a binary tree from
the elements of an array by using their locations in the array. The
first element is the root, its children are the next two elements, their
children are the next four elements, etc. Given an array location, we
can then compute the locations of its parent and both of its children.
The priorities are arranged so that the root of each subtree contains
the maximum priority in that subtree. It is possible to arrange the
elements of an array into a binary heap in {{< math >}}$ O(n) ${{< /math >}} time, and to remove
an element with maximum priority in {{< math >}}$ O(\lg n) ${{< /math >}} time.

Heap sort then works by pre-processing the array to arrange it into a
binary heap. The binary heap then forms the unsorted part, and it is
followed by the sorted part, whose elements are all no smaller than any
element in the unsorted part. While this arrangement is slightly
different from the arrangement for the first two select sorts, the idea
is the same. To rearrange the unsorted part, it:

1.  Copies the first (i.e., highest-priority) element to a temporary
    variable.
2.  Removes the element with maximum priority (i.e., the first element).
3.  Places the copy of the first element into the space vacated by its
    removal at the beginning of the sorted part.

Heap sort runs in {{< math >}}$ O(n \lg n) ${{< /math >}} time in the worst case.
Information theory can be used to prove that any sorting algorithm that
sorts by comparing elements must make at least {{< math >}}$ \lg(n!) ${{< /math >}} comparisons on
some arrays of size <span style="white-space:nowrap">{{< math >}}$ n ${{< /math >}}.</span> Because {{< math >}}$ \lg(n!) ${{< /math >}} is proportional to
<span style="white-space:nowrap">{{< math >}}$ n \lg n ${{< /math >}},</span> we cannot hope to do any better than
{{< math >}}$ O(n \lg n) ${{< /math >}} in the worst case. While this performance is a
significant improvement over selection sort and bubble sort, we will see
in later that
there is are algorithms that do even better in practice.
Furthermore, heap sort is not stable.

On the other hand, we will also see that heap sort is an important component of an efficient hybrid
algorithm. This algorithm is one of the best general-purpose sorting algorithms; in fact, it is used by .NET's [**Array.Sort**](https://learn.microsoft.com/en-us/dotnet/api/system.array.sort?view=net-6.0#system-array-sort(system-array)) method. We
will examine this approach in "[Hybrid
Sorts](/sorting/hybrid)".
