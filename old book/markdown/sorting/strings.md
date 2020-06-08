# Sorting Strings

We conclude our discussion of sorting with a look at a sorting algorithm
designed specifically for sorting multi-keyed data. In such data there
is a primary key, a secondary key, and so on. We want to sort the data
so that element *a* precedes element *b* if:

  - the primary key of *a* is less than the primary key of *b*;
  - or their primary keys are equal, but the secondary key of *a* is
    less than the secondary key of *b*;
  - etc.

An example of multi-keyed data is strings. The first character of a
string is its primary key, its second character is its secondary key,
and so on. The only caveat is that the strings may not all have the same
length; hence, they may not all have the same number of keys. We
therefore stipulate that a string that does not have a particular key
must precede all strings that have that key.

One algorithm to sort multi-keyed data is known as *multi-key quick
sort*. In this section, we will describe multi-key quick sort as it
applies specifically to sorting strings; however, it can be applied to
other multi-keyed data as well.

One problem with sorting strings using a version of quick sort described
in "[Split Sorts](/~rhowell/DataStructures/redirect/split-sorts)" is
that string comparisons can be expensive. Specifically, they must
compare the strings a character at a time until they reach either a
mismatch or the end of a string. Thus, comparing strings that have a
long prefix in common is expensive. Now observe that quick sort operates
by splitting the array into smaller and smaller pieces whose elements
belong near each other in the sorted result. It is therefore common to
have some pieces whose elements all begin with the same long prefix.

Multi-key quick sort improves the performance by trying to avoid
comparing prefixes after they have already been found to be the same
(though the suffixes may differ). In order to accomplish this, it uses
an extra **int** parameter `k` such that all the strings being sorted
match in their first `k` positions (and by implication, all strings have
length at least `k`). We can safely use a value of 0 in the initial
call, but this value can increase as recursive calls are made.

Because all strings begin with the same prefix of length `k`, we can
focus on the character at location `k` (i.e., following the first `k`
characters) of each string. We need to be careful, however, because some
of the strings may not have a character at location `k`. We will
therefore use an **int** to store the value of the character at location
`k` of a string, letting -1 denote the absence of a character at that
location.

The algorithm then proceeds a lot like those described in "[Split
Sorts](/~rhowell/DataStructures/redirect/split-sorts)". If the number of
elements being sorted is greater than 1, a pivot element `p` is found.
Note that `p` is not a **string**, but an **int** representing a
character at location `k`, as described above. The elements are then
partitioned into groups of strings whose character at location `k` is
less than `p`, equal to `p`, or greater than `p`, respectively.

After these three groups are formed, the first and third group are
sorted recursively using the same value for `k`. Furthermore, the second
group may not be completely sorted yet - all we know is that all strings
in this group agree on the first `k`Ã‚Â +Ã‚Â 1 characters. Thus, unless
`p` is -1 (indicating that that these strings all have length `k`, and
are therefore all equal), we need to recursively sort this group as
well. However, because we know that the strings in this group all agree
on the first `k`Ã‚Â +Ã‚Â 1 characters, we pass `k`Ã‚Â +Ã‚Â 1 as the last
parameter.

One aspect of this algorithm that we need to address is whether the
recursion is valid. Recall that [when we introduced
recursion](/~rhowell/DataStructures/redirect/recursion), we stated that
in order to guarantee termination, all recursive calls must be on
smaller problem instances, where the size of a problem instance is given
by a nonnegative integer. In the algorithm described above, we might
reach a point at which all of the strings being sorted match in location
`k`. In such a case, the second recursive call will contain all of the
strings.

By being careful how we define the size of the problem instance,
however, we can show that this recursion is, in fact, valid.
Specifically, we define the size of the problem instance to be the
number of strings being sorted, plus the total number of characters
beginning at location `k` in all strings being sorted. Because there is
at least one string containing `p` at location `k`, the number of
strings in both the first and the third recursive call must be smaller,
while the total number of characters beginning at location `k` can be no
larger. Because `k` increases by 1 in the second recursive call, the
total number of characters past this location must be smaller, while the
number of strings can be no larger. Hence, the size decreases in all
recursive calls.

The fact that we are doing recursion on the length of strings, however,
can potentially cause the runtime stack to overflow when we are sorting
very long strings. For this reason, it is best to convert the recursive
call on the second group to a loop. We can do this by changing the
**if**-statement that controls whether the splitting will be done into a
**while**-loop that iterates as long as the portion being sorted is
large enough to split. Then at the bottom of the loop, after doing
recursive calls on the first and third parts, we check to see if `p` is
-1 - if so, we terminate the loop. Otherwise, we do the following:

  - increment `k`;
  - change the index giving the start of the portion we are sorting to
    the beginning of the second part; and
  - change the length of the portion we are sorting to the length of the
    second part.

The next iteration will then sort the second part.

This algorithm can be combined with [insertion
sort](/~rhowell/DataStructures/redirect/insert-sorts) and [heap
sort](/~rhowell/DataStructures/redirect/heap-sort), as was done for
introsort in [the previous
section](/~rhowell/DataStructures/redirect/hybrid-sorts). However, we
should also modify insertion sort and heap sort to use the information
we already have about equal prefixes when we are comparing elements.
Specifically, rather than comparing entire strings, we should begin
comparing after the equal prefix. Because of the way multi-key quick
sort does comparisons, the result tends to perform better than the
single-key versions, assuming similar optimizations are made; however,
cutoffs for running insertion sort and/or heap sort may need to be
adjusted.
