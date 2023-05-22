+++
title = "Finding Prime Numbers"
weight = 30

pre = "<b>4.3. </b>"
+++

## Finding Prime Numbers

An integer greater than {{< math >}}$ 1 ${{< /math >}} is said to be *prime* if it is not divisible
by any positive integers other than itself and <span style="white-space:nowrap">{{< math >}}$ 1 ${{< /math >}}.</span> Thus, <span style="white-space:nowrap">{{< math >}}$ 2 ${{< /math >}},</span> <span style="white-space:nowrap">{{< math >}}$ 3 ${{< /math >}},</span> and {{< math >}}$ 5 ${{< /math >}} are
prime, but not {{< math >}}$ 1 ${{< /math >}} (it is not greater than <span style="white-space:nowrap">{{< math >}}$ 1 ${{< /math >}})</span> or {{< math >}}$ 4 ${{< /math >}} (it is divisible by <span style="white-space:nowrap">{{< math >}}$ 2 ${{< /math >}}).</span>
Because every integer is divisible by itself and <span style="white-space:nowrap">{{< math >}}$ 1 ${{< /math >}},</span> we will call any
other positive factors *nontrivial factors*; thus, a prime number is an
integer greater than {{< math >}}$ 1 ${{< /math >}} that has no nontrivial factors. The study of
prime numbers dates back to at least the third century BC. One of the
earliest known algorithms finds all prime numbers less than a given
integer <span style="white-space:nowrap">{{< math >}}$ n ${{< /math >}}.</span> This algorithm is known as the *Sieve of Eratosthenes*, and
is attributed to the Greek mathematician Eratosthenes of Cyrene (c. 276
BC - c. 194 BC).

The most basic version of this algorithm operates as follows:

1.  Place all integers greater than {{< math >}}$ 1 ${{< /math >}} and less than {{< math >}}$ n ${{< /math >}} in order in a
    list.
2.  For each element {{< math >}}$ k ${{< /math >}} in the list, remove all subsequent elements
    that are divisible by <span style="white-space:nowrap">{{< math >}}$ k ${{< /math >}}.</span>
3.  The remaining values are the prime numbers less than <span style="white-space:nowrap">{{< math >}}$ n ${{< /math >}}.</span>

For example, suppose <span style="white-space:nowrap">{{< math >}}$ n = 20 ${{< /math >}}.</span> We then place the integers from {{< math >}}$ 2 ${{< /math >}}
to {{< math >}}$ 19 ${{< /math >}} in a list:
{{< math align="left" >}}
$$
2\ 3\ 4\ 5\ 6\ 7\ 8\ 9\ 10\ 11\ 12\ 13\ 14\ 15\ 16\ 17\ 18\ 19
$$
{{< /math >}}
We then remove all numbers following {{< math >}}$ 2 ${{< /math >}} that are divisible by <span style="white-space:nowrap">{{< math >}}$ 2 ${{< /math >}}:</span>
{{< math align="left" >}}
$$
\require{cancel}
2\ 3\ \cancel{4}\ 5\ \cancel{6}\ 7\ \cancel{8}\ 9\ \cancel{10}\ 11\
\cancel{12}\ 13\ \cancel{14}\ 15\ \cancel{16}\ 17\ \cancel{18}\ 19
$$
{{< /math >}}
We then remove all numbers following {{< math >}}$ 3 ${{< /math >}} that are divisible by <span style="white-space:nowrap">{{< math >}}$ 3 ${{< /math >}}:</span>
{{< math align="left" >}}
$$
2\ 3\ \cancel{4}\ 5\ \cancel{6}\ 7\ \cancel{8}\ \cancel{9}\ \cancel{10}\ 11\
\cancel{12}\ 13\ \cancel{14}\ \cancel{15}\ \cancel{16}\ 17\ \cancel{18}\ 19
$$
{{< /math >}}
The algorithm continues, but none of the succeeding iterations finds any
values to remove. Therefore, <span style="white-space:nowrap">{{< math >}}$ 2, 3, 5, 7, 11, 13, 17 ${{< /math >}},</span> and {{< math >}}$ 19 ${{< /math >}} are the
prime numbers less than <span style="white-space:nowrap">{{< math >}}$ 20 ${{< /math >}}.</span>

To see why this algorithm gives us exactly the prime numbers less than
<span style="white-space:nowrap">{{< math >}}$ n ${{< /math >}},</span> first note that because we only remove a number when we find a
nontrivial factor, we only remove non-primes from the list. What may be
a little less obvious is that we remove *all* non-primes from the list.
To see this, suppose {{< math >}}$ m ${{< /math >}} is a non-prime less than <span style="white-space:nowrap">{{< math >}}$ n ${{< /math >}},</span> and let {{< math >}}$ a ${{< /math >}} be
its smallest nontrivial factor. Then {{< math >}}$ a ${{< /math >}} must be prime because any
nontrivial factor of {{< math >}}$ a ${{< /math >}} would be less than {{< math >}}$ a ${{< /math >}} and would also divide
<span style="white-space:nowrap">{{< math >}}$ m ${{< /math >}}.</span> {{< math >}}$ a ${{< /math >}} therefore will not be removed from the list. When
{{< math >}}$ k = a ${{< /math >}} in Step 2, {{< math >}}$ m ${{< /math >}} will be removed.

There is actually a good reason why the first two iterations in the
above example removed all of the non-primes --- once the algorithm reaches
a divisor {{< math >}}$ k ${{< /math >}} such that {{< math >}}$ k^2 \geq n ${{< /math >}} (in this
example, <span style="white-space:nowrap">{{< math >}}$ 5^2 = 25 \geq 20 ${{< /math >}}),</span> all of the
non-primes will have been removed. To see why this is true, let {{< math >}}$ m ${{< /math >}} and
{{< math >}}$ a ${{< /math >}} be as above. We can then write
{{< math align="left" >}}
$$
    m = ab
$$
{{< /math >}}
where <span style="white-space:nowrap">{{< math >}}$ a \leq b ${{< /math >}},</span> and {{< math >}}$ m ${{< /math >}} is removed from the list when
<span style="white-space:nowrap">{{< math >}}$ k = a ${{< /math >}}.</span> We can then multiply both sides of the above
equation by <span style="white-space:nowrap">{{< math >}}$ a/b ${{< /math >}},</span> yielding:
{{< math align="left" >}}
$$
\frac{am}{b} = a^2.
$$
{{< /math >}}
Finally, because <span style="white-space:nowrap">{{< math >}}$ a \leq b ${{< /math >}},</span> <span style="white-space:nowrap">{{< math >}}$ a/b \leq 1 ${{< /math >}}.</span>
Therefore,
{{< math align="left" >}}
$$
m \geq a^2.
$$
{{< /math >}}
We conclude that if {{< math >}}$ m ${{< /math >}} is a non-prime greater than <span style="white-space:nowrap">{{< math >}}$ 1 ${{< /math >}},</span> it is removed
when the algorithm reaches some value {{< math >}}$ k ${{< /math >}} with
<span style="white-space:nowrap">{{< math >}}$ k^2 < n ${{< /math >}}.</span> We can therefore optimize the
algorithm by stopping when <span style="white-space:nowrap">{{< math >}}$ k^2 \geq n ${{< /math >}}.</span>

We can implement this algorithm using a linked list. A linked list is an
appropriate data structure for this algorithm because once the list is
built, all of the processing involves iterating through it from
beginning to end --- the same direction the links go.

To implement Step 1, it is easier to build the list from back to front,
as we don't need to maintain a separate reference to the end of the
list. This step then consists of a loop that iterates from
{{< math >}}$ n - 1 ${{< /math >}} down to <span style="white-space:nowrap">{{< math >}}$ 2 ${{< /math >}},</span> with each iteration adding
to the front of the list a cell containing the loop index.

In order to be able to implement Step 2, we will need to know how to
remove a cell from a linked list. Suppose, for example, that we want to
remove the cell referring to "the" from the following linked list:

![A linked list from which we want to remove x](linked-list-remove1.jpg)

To remove it, we need the cell that precedes it to be followed by the
cell that follows it:

![What we need to change in order to remove the
cell](linked-list-remove2.jpg)

In order to change that reference, we need a reference to the cell that
precedes the cell we want to remove:

![The additional reference we need](linked-list-remove3.jpg)

We can then remove the cell following the cell referenced by `q` as
follows:
```C#
q.Next = q.Next.Next;
```
Now that we know how to remove a cell from a linked list, let's consider
Step 2 of the algorithm. For one value of <span style="white-space:nowrap">{{< math >}}$ k ${{< /math >}},</span> we need to remove all
subsequent values that are divisible by <span style="white-space:nowrap">{{< math >}}$ k ${{< /math >}}.</span> In terms of the linked
list, we need to start this process with the cell containing <span style="white-space:nowrap">{{< math >}}$ k ${{< /math >}}.</span> For
example, consider the second iteration from the example above --- i.e.,
when <span style="white-space:nowrap">{{< math >}}$ k = 3 ${{< /math >}}:</span>

![The beginning of an iteration with k = 3](sieve-example1.jpg)

We need to iterate `p` through the linked list, checking the *next* cell
on each iteration to see whether its contents are divisible by <span style="white-space:nowrap">{{< math >}}$ k ${{< /math >}}.</span> We
can check for divisibility by {{< math >}}$ k ${{< /math >}} using the [remainder
operator](/appendix/syntax/remainder) --- i.e., {{< math >}}$ k ${{< /math >}} divides
{{< math >}}$ m ${{< /math >}} if {{< math >}}$ m \mathbin{\texttt{\%}} k ${{< /math >}} is 0. Thus, the first iteration
would see if {{< math >}}$ 3 ${{< /math >}} 
divides <span style="white-space:nowrap">{{< math >}}$ 5 ${{< /math >}}.</span> It doesn't, so we advance `p` to the next cell (containing
<span style="white-space:nowrap">{{< math >}}$ 5 ${{< /math >}}).</span> We then see if {{< math >}}$ 3 ${{< /math >}} divides <span style="white-space:nowrap">{{< math >}}$ 7 ${{< /math >}}.</span> Again it doesn't, so we advance `p` to
the next cell (containing <span style="white-space:nowrap">{{< math >}}$ 7 ${{< /math >}}).</span> At this point, {{< math >}}$ 3 ${{< /math >}} divides <span style="white-space:nowrap">{{< math >}}$ 9 ${{< /math >}},</span> so we remove
the cell containing {{< math >}}$ 9 ${{< /math >}} as shown above. This gives us the following linked
list:

![After 9 has been removed](sieve-example2.jpg)

Note that we have not yet advanced `p`, and indeed we don't want to, as
{{< math >}}$ 11 ${{< /math >}} is the next value we want to check. Thus, on each iteration, if {{< math >}}$ k ${{< /math >}}
divides the value in the cell following `p`, we remove that cell;
otherwise, we advance `p` to that cell. We iterate this loop as long as
there is a cell following `p`.

The loop described above represents a single iteration of the loop
described for Step 2. Thus, for Step 2, we need to iterate a variable
through the list, performing the above on each iteration. We stop when
we either have run off the end of the list or have reached a value of
{{< math >}}$ k ${{< /math >}} such that <span style="white-space:nowrap">{{< math >}}$ k^2 \geq n ${{< /math >}}.</span> Note that at the end of
each iteration, we want to advance to the next cell.

{{% notice warning %}}
Make sure when iterating through a linked list that you keep a
reference to the beginning of the list. Otherwise, you will lose all
of your list.
{{% /notice %}}

