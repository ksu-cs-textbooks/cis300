+++
title = "A Simple Hash Table Implementation"
weight = 10

pre = "<b>7.1. </b>"
+++

## A Simple Hash Table Implementation

In this section, we will look at a simple hash table implementation
using a fixed-length table. In subsequent sections, we will consider how
to adjust the table size for better performance, as well as how to
implement enumerators for iterating through the keys and/or values.

At the core of our implementation is the computation of the hash
function. Recall that the implementation of the hash function
computation is divided into two parts. The first part of the computation
is implemented within the definition of the key type via its
**GetHashCode** method. We will discuss this part of the computation in
the section, ["Hash
Codes"](/hashing/hash-functions). Here, we will
focus on the second step, converting the **int** hash code returned by
the key's **GetHashCode** method to a table location.

One common technique, which is used in the .NET implementation of the
[**Dictionary\<TKey, TValue\>**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2?view=net-6.0)
class, is called the *division method*. This technique consists of the
following:

1.  Reset the sign bit of the hash code to `0`.
2.  Compute the remainder of dividing this value by the length of the
    table.

If `p` is a nonnegative **int** and `q` is a positive **int**, then
`p % q` gives a nonnegative value less than `q`; hence, if `q`
is the table length, `p % q` is a location within the table.
Furthermore, this calculation often does a good job of distributing hash
code values among the different table locations, but this depends on how
the hash codes were computed and what the length of the table is.

For example, suppose we use a size {{< math >}}$ 2^k ${{< /math >}} for some positive
integer <span style="white-space:nowrap">{{< math >}}$ k ${{< /math >}}.</span> In this case, the above computation can be simplified, as
the values formed by {{< math >}}$ k ${{< /math >}} bits are {{< math >}}$ 0 ${{< /math >}} through <span style="white-space:nowrap">{{< math >}}$ 2^k - 1 ${{< /math >}},</span>
or all of the locations in the table. We can therefore simply use the
low-order {{< math >}}$ k ${{< /math >}} bits of the hash code as the table location. However, it
turns out that using the division method when the table size is a power
of {{< math >}}$ 2 ${{< /math >}} can lead to poor key distribution for some common hash code
schemes. To avoid these problems, a prime number should be used as the
table length. When a prime number is used, the division method tends to
result in a good distribution of the keys.

The reason we need to reset the sign bit of the hash code to `0` is to
ensure that the first operand to the `%` operator is nonnegative, and
hence that the result is nonnegative. Furthermore, simply taking the
absolute value of the hash code won't always work because
{{< math >}}$ -2^{31} ${{< /math >}} can be stored in an **int**, but {{< math >}}$ 2^{31} ${{< /math >}} is too
large. Resetting the sign bit to `0` is a quick way to ensure we have a
nonnegative value without losing any additional information.

We can do this using a bitwise AND operator, denoted by a single
ampersand (`&`). This operator operates on the individual bits of an
integer type such as **int**. The logical AND of two `1` bits is `1`; all
other combinations result in `0`. Thus, if we want to set a bit to `0`, we
AND it with `0`, and ANDing a bit with `1` will leave it unchanged. The sign
bit is the high-order bit; hence, we want to AND the hash code with an
**int** whose first bit is `0` and whose remaining bits are `1`. The easiest
way to write this value is using hexadecimal notation, as each hex digit
corresponds to exactly four bits. We begin writing a hexadecimal value
with `0x`. The first four bits need to be one `0`, followed by three `1`s.
These three `1` are in the <span style="white-space:nowrap">{{< math >}}$ 1 ${{< /math >}},</span> <span style="white-space:nowrap">{{< math >}}$ 2 ${{< /math >}},</span> and {{< math >}}$ 4 ${{< /math >}} bit positions of the first hex digit; hence, the value of
this hex digit should be `7`. We then want seven more hex digits, each
containing four `1`s. An additional `1` in the {{< math >}}$ 8 ${{< /math >}} position gives us a sum of
<span style="white-space:nowrap">{{< math >}}$ 15 ${{< /math >}},</span> which is denoted as either `f` or `F` in hex. We can therefore reset
the sign bit of an **int** `i` as follows:

```c#
i = i & 0x7fffffff;
```

or:

```c#
i &= 0x7fffffff;
```

Now let's consider how we would look up a key. First, we need to obtain
the key's hash code by calling its **GetHashCode** method. From the hash
code, we use the division method to compute the table location where it
belongs. We then search the linked list for that key.

Adding a key and a value is done similarly. We first look for the key as
described above. If we find it, we either replace its **KeyValuePair**
with a new one containing the new value, or we throw an exception,
depending on how we want this method to behave. If we don't find it, we
add a new cell containing the given key and value to the beginning of
the list we searched.

Note that looking up a key or adding a key and a value as described
above can be implemented using either methods or indexers (.NET
uses both). See the section,
["Indexers"](/appendix/syntax/indexers) for details on
how to implement an indexer.
