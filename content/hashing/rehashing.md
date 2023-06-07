+++
title = "Rehashing"
weight = 20

pre = "<b>7.2. </b>"
+++

## Rehashing

In this section, we will show how to improve the performance of a hash
table by adjusting the size of the array. In order to see how the array
size impacts the performance, let's suppose we are using an array with
{{< math >}}$ m ${{< /math >}} locations, and that we are storing {{< math >}}$ n ${{< /math >}} keys in the hash table. In
what follows, we will analyze the number of keys we will need to examine
while searching for a particular key, `k`.

In the worst case, no matter how large the array is, it is possible that
all of the keys map to the same array location, and therefore all end up
in one long linked list. In such a case, we will need to examine all of
the keys whenever we are looking for the last one in this list. However,
the worst case is too pessimistic --- if the hash function is implemented
properly, it is reasonable to expect that something approaching a
uniform random distribution will occur. We will therefore consider the
number of keys we would expect to examine, assuming a uniform random
distribution of keys throughout the table.

We'll first consider the case in which `k` is not in the hash table. In
this case, we will need to examine all of the keys in the linked list at
the array location where `k` belongs. Because each of the {{< math >}}$ n ${{< /math >}} keys is
equally likely to map to each of the {{< math >}}$ m ${{< /math >}} array locations, we would
expect, on average, {{< math >}}$ n / m ${{< /math >}} keys to be mapped to the location
where `k` belongs. Hence, in this case, we would expect to examine
{{< math >}}$ n / m ${{< /math >}} keys, on average.

Now let's consider the case in which `k` is in the hash table. In this
case, we will examine the key `k`, plus all the keys that precede `k` in
its linked list. The number of keys preceding `k` cannot be more than
the total number of keys other than `k` in that linked list. Again,
because each of the {{< math >}}$ n - 1 ${{< /math >}} keys other than `k` is equally likely
to map to each of the {{< math >}}$ m ${{< /math >}} array locations, we would expect, on average,
{{< math >}}$ (n - 1) / m ${{< /math >}} keys other than `k` to be in the same linked
list as `k`. Thus, we can expect, on average, to examine no more than
{{< math >}}$ 1 +  (n - 1) / m ${{< /math >}} keys when looking for a key
that is present.

Notice that both of the values derived above decrease as {{< math >}}$ m ${{< /math >}} increases.
Specifically, if {{< math >}}$ m \geq n ${{< /math >}}, the expected number of examined
keys on a failed lookup is no more than {{< math >}}$ 1 ${{< /math >}}, and the expected number of
examined keys on a successful lookup is less than {{< math >}}$ 2 ${{< /math >}}. We can therefore
expect to achieve very good performance if we keep the number of array
locations at least as large as the number of keys.

We have already seen (e.g., in "[Implementation of
**StringBuilder**s](/strings/stringbuilder-impl)")
how we can keep an array large enough by doubling its size whenever we
need to. However, a hash table presents two unique challenges for this
technique. First, as we observed in [the previous
section](/hashing/simple), we
are most likely to get good performance from a hash table if the number
of array locations is a prime number. However, doubling a prime number
will never give us a prime number. The other challenge is due to the
fact that when we change the size of the array, we consequently change
the hash function, as the hash function uses the array size. As a
result, the keys will need to go to different array locations in the new
array.

In order to tackle the first challenge, recall that we presented an
algorithm for finding all prime numbers less than a given `n` in
"[Finding Prime
Numbers](/linked-lists/sieve-eratosthenes)";
however, this is a rather expensive way to find a prime number of an
appropriate size. While there are more efficient algorithms, we really
don't need one. Suppose we start with an array size of {{< math >}}$ 5 ${{< /math >}} (there may be
applications using many small hash tables --- the .NET implementation
starts with an array size of <span style="white-space:nowrap">{{< math >}}$ 3 ${{< /math >}}).</span> {{< math >}}$ 5 ${{< /math >}} is larger than
<span style="white-space:nowrap">{{< math >}}$ 2^2 = 4 ${{< /math >}}.</span> If we double this value {{< math >}}$ 28 ${{< /math >}} times, we
reach a value larger than <span style="white-space:nowrap">{{< math >}}$ 2^{30} ${{< /math >}},</span> which is larger than {{< math >}}$ 1 ${{< /math >}}
billion. More importantly, this value is large enough that we can't
double it again, as an array in C\# must contain fewer than
{{< math >}}$ 2^{31} ${{< /math >}} locations. Hence, we need no more than {{< math >}}$ 29 ${{< /math >}} different array
sizes. We can pre-compute these and hard-code them into our
implementation; for example,

```c#
private int[] _tableSizes = 
{
    5, 11, 23, 47, 97, 197, 397, 797, 1597, 3203, 6421, 12853, 25717,
    51437, 102877, 205759, 411527, 823117, 1646237, 3292489, 6584983,
    13169977, 26339969, 52679969, 105359939, 210719881, 421439783,
    842879579, 1685759167 
}; 
```

Each of the values in the above array is a prime number, and each one
after the first is slightly more than twice its predecessor. In order to
make use of these values, we need a **private** field to store the index
at which the current table size is stored in this array. We also need to
keep track of the number of keys currently stored. As this information
is useful to the user, a **public int Count** property would be
appropriate. It can use the default implementation with a **get**
accessor and a **private set** accessor.

One important difference between the reason for rehashing and the reason
for creating a larger array for an implementation of a
[**StringBuilder**](/strings/stringbuilder-impl),
[stack](/stacks-queues/stack-impl), or
[queue](/stacks-queues/queue-impl) is that rehashing
is done simply for performance reasons - there is always room to put a
new key and value into a hash table unless we have run out of memory.
For this reason, it makes sense to handle rehashing *after* we have
added the new key and value. This results in one extra linked-list
insertion (i.e., updating two references) each time we rehash, but it
simplifies the coding somewhat. Because rehashing is rarely done, this
overhead is minimal, and seems to be a reasonable price to pay for
simpler code.

Once a new key and value have been added, we first need to update the
**Count**. We then need to check to see whether this number exceeds the
current array size. As we do this, we should also make sure that the
array size we are using is not the last array size in `_tableSizes`,
because if it is, we can't rehash. If both of these conditions hold, we
need to rehash.

To begin rehashing, we copy the reference to the table into a local
variable and increment the field giving our current index into
`_tableSizes`. We then construct for the table field a new array whose
size is given by the value at the new current index into `_tableSizes`.
Note that it is important that the local variable is used to refer to
the old table, and that the field is used to refer to the new table, as
the hash function uses the field to obtain the array size.

We then need to move all keys and values from the old table to the new
one. As we do this, we will need to re-compute the hash function for each
key, as the hash function has now changed. We therefore need two nested
loops. The outer loop iterates through the locations in the old table,
and the inner loop iterates through the linked list at that location. On each iteration of the inner loop:

  1. Use a local variable to save another reference to the current cell in the
    linked list at the current table location.
  2. Advance to the next cell in the list.
  3. Using the hash function, compute the new array location of the key
    in the cell that was saved in step 1.
  4. Insert this cell into the beginning of the linked list at the new
    array location in the new table.

{{% notice warning %}}

It is important to do step 2 above prior to step 4, as inserting a cell into a new list will lose the reference to the next cell in the old list.

{{% /notice %}}
