# Hybrid Sorting Algorithms

The best versions of [quick
sort](/~rhowell/DataStructures/redirect/split-sorts) are competitive
with both [heap sort](/~rhowell/DataStructures/redirect/heap-sort) and
[merge sort](/~rhowell/DataStructures/redirect/merge-sorts) on the vast
majority of inputs. However, quick sort has a very bad worst case -
*O*(*n*<sup>2</sup>) running time and *O*(*n*) stack usage. By
comparison, both heap sort and merge sort have *O*(*n*Ã‚Â lgÃ‚Â *n*)
worst-case running time, together with a stack usage of *O*(1) for heap
sort or *O*(lgÃ‚Â *n*) for merge sort. Furthermore, [insertion
sort](/~rhowell/DataStructures/redirect/insert-sorts) performs better
than any of these algorithms on small data sets. In this section, we
look at ways to combine some of these algorithms to obtain a sorting
algorithm that has the advantages of each of them.

We will start with quick sort, which gives the best performance for most
inputs. One way of improving its performance is to make use of the fact
that [insertion sort](/~rhowell/DataStructures/redirect/insert-sorts) is
more efficient for small data sets. Improving the performance on small
portions can lead to significant performance improvements for large
arrays because quick sort breaks large arrays into many small portions.
Hence, when the portion we are sorting becomes small enough, rather than
finding a pivot and splitting, we instead call insertion sort.

An alternative to the above improvement is to use the fact that
insertion sort runs in *O*(*n*) time when the number of inversions is
linear in the number of array elements. To accomplish this, we modify
quick sort slightly so that instead of sorting the array, it brings each
element near where it belongs. We will refer to this modified algorithm
as a *partial sort*. After we have done the partial sort, we then sort
the array using insertion sort. The modification we make to quick sort
to obtain the partial sort is simply to change when we stop sorting. We
only sort portions that are larger than some threshold - we leave other
portions unsorted.

Suppose, for example, that we choose a threshold of 10. Once the partial
sort reaches an array portion with nine or fewer elements, we do nothing
with it. Note, however, that these elements are all larger than the
elements that precede this portion, and they are all smaller than the
elements that follow this portion; hence, each element can form an
inversion with at most eight other elements - the other elements in the
same portion. Because each inversion contains two elements, this means
that there can be no more than 4*n* inversions in the entire array once
the partial sort finishes. The subsequent call to insertion sort will
therefore finish the sorting in linear time.

Both of the above techniques yield performance improvements over quick
sort alone. In fact, for many years, such combinations of an optimized
version of quick sort with insertion sort were so efficient for most
inputs that they were the most commonly-used algorithms for
gerneral-purpose sorting. On modern hardware architectures, the first
approach above tends to give the better performance.

Nevertheless, neither of the above approaches can guarantee
*O*(*n*Ã‚Â lgÃ‚Â *n*) performance - in the worst case, they are all
still in *O*(*n*<sup>2</sup>). Furthermore, the bad cases still use
linear stack space. To overcome these shortfalls, we can put a limit on
the depth of recursion. Once this limit is reached, we can finish
sorting this portion with an *O*(*n*Ã‚Â lgÃ‚Â *n*) algorithm such as
[heap sort](/~rhowell/DataStructures/redirect/heap-sort). The idea is to
pick a limit that is large enough that it is rarely reached, but still
small enough that bad cases will cause the alternative sort to be
invoked before too much time is spent. A limit of about 2Ã‚Â lgÃ‚Â *n*,
where *n* is the size of the entire array, has been suggested. Because
arrays in C\# must have fewer than 2<sup>31</sup> elements, this value
is always less than 62; hence, it is also safe to use a constant for the
limit. The resulting algorithm has a worst-case running time in
*O*(*n*Ã‚Â lgÃ‚Â *n*) and a worst-case stack usage of *O*(lgÃ‚Â *n*).
This logarithmic bound on the stack usage is sufficient to avoid a
**StackOverflowException**.

The combination of [quick sort using median-of-three
partitioning](/~rhowell/DataStructures/redirect/median-of-3) with
insertion sort for small portions and heap sort when the recursion depth
limit is reached is known as *introsort* (short for *introspective
sort*). Other improvements exist, but we will not discuss them here. The
best versions of introsort are among the best sorting algorithms
available, unless the array is nearly sorted. Of course, if the data
won't fit in an array, we can't use introsort - we should use [external
merge sort](/~rhowell/DataStructures/redirect/external-merge-sort)
instead. Furthermore, like quick sort and heap sort, introsort is not
stable. When a stable sort is not needed, however, and when none of the
above special cases applies, introsort is one of the best choices
available.
