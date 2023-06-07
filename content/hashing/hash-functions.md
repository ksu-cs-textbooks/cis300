+++
title = "Hash Codes"
weight = 50

pre = "<b>7.5. </b>"
+++

## Hash Codes

Whenever equality is redefined for a type, the hash code computation for
that type needs to be redefined in a consistent way. This is done by
[overriding](/strings/stringbuilder-impl/#overriding) that
type's
[**GetHashCode**](https://learn.microsoft.com/en-us/dotnet/api/system.object.gethashcode?view=net-6.0#system-object-gethashcode)
method. In order for hashing to be implemented correctly and
efficiently, this method should satisfy the following goals:

  - Equal keys must have the same hash code. This is necessary in order
    for the **Dictionary\<TKey, TValue\>** class to be able to find a
    given key that it has stored. On the other hand, because the number
    of possible keys is usually larger than the number of possible hash
    codes, unequal keys are also allowed to have the same hash code.
  - The computation should be done quickly.
  - Hash codes should be uniformly distributed even if the keys are not.

The last goal above may seem rather daunting, particularly in light of
our desire for a quick computation. In fact, it is impossible to
guarantee in general --- provided there are more than
{{< math >}}$ 2^{32}(k - 1) ${{< /math >}} possible keys from which to choose, no
matter how the hash code computation is implemented, we can always find
at least {{< math >}}$ k ${{< /math >}} keys with the same hash code. However, this is a problem
that has been studied a great deal, and several techniques have been
developed that are effective in practice. We will caution, however, that
not every technique that looks like it should be effective actually is
in practice. It is best to use techniques that have been demonstrated to
be effective in a wide variety of applications. We will examine one of
these techniques in what follows.

A guiding principle in developing hashing techniques is to use all
information available in the key. By using all the information, we will
be sure to use the information that distinguishes this key from other
keys. This information includes not just the values of the individual
parts of the the key, but also the order in which they occur, provided
this order is significant in distinguishing unequal keys. For example,
the strings, "being" and "begin" contain the same letters, but are
different because the letters occur in a different order.

One specific technique initializes the hash code to 0, then processes
the key one component at a time. These components may be bytes,
characters, or other parts no larger than 32 bits each. For example, for
the Nim board positions discussed in
["Memoization"](/hashing/memoization), the
components would be the number of stones on each pile, the limit for
each pile, and the total number of piles (to distinguish between a board
ending with empty piles and a board with fewer piles). For each
component, it does the following:

  - Multiply the hash code by some fixed odd integer.
  - Add the current component to the hash code.

Due to the repeated
multiplications, the above computation will often overflow an **int**.
This is not a problem --- the remaining bits are sufficient for the hash code.

In order to understand this computation a little better, let's first
ignore the effect of this overflow. We'll denote the fixed odd integer
by {{< math >}}$ x ${{< /math >}}, and the components of the key as
<span style="white-space:nowrap">{{< math >}}$ k_1, \dots, k_n ${{< /math >}}.</span> Then
this is the result of the computation:

{{< math align="left" >}}
$$(\dots ((0x + k_1)x + k_2) \dots)x + k_n = k_1 x^{n-1} + k_2 x^{n-2} + \dots + k_n.$$
{{< /math >}}

Because the above is a polynomial, this hashing scheme is called
*polynomial hashing*. While the computation itself is efficient,
performing just a couple of arithmetic operations on each component, the
result is to multiply each component by a unique value ({{< math >}}$ x^i ${{< /math >}}
for some <span style="white-space:nowrap">{{< math >}}$ i ${{< /math >}})</span> depending on its position within the key.

Now let's consider the effect of overflow on the above polynomial. What
this does is to keep only the low-order 32 bits of the value of the
polynomial. Looking at it another way, we end up multiplying
{{< math >}}$ k_i ${{< /math >}} by only the low-order 32 bits of <span style="white-space:nowrap">{{< math >}}$ x^{n-i} ${{< /math >}}.</span>
This helps to explain why {{< math >}}$ x ${{< /math >}} is an odd number --- raising an even number
to the <span style="white-space:nowrap">{{< math >}}$ i ${{< /math >}}th</span> power forms a number ending in {{< math >}}$ i ${{< /math >}} 0s in binary. Thus, if
there are more than 32 components in the key, all but the last 32 will
be multiplied by <span style="white-space:nowrap">{{< math >}}$ 0 ${{< /math >}},</span> and hence, ignored.

There are other potential problems with using certain odd numbers for
{{< math >}}$ x ${{< /math >}}. For example, we wouldn't want to use <span style="white-space:nowrap">{{< math >}}$ 1 ${{< /math >}},</span> because that would result
in simply adding all the components together, and we would lose any
information regarding their positions within the key. Using {{< math >}}$ -1 ${{< /math >}} would be
almost as bad, as we would multiply all components in odd positions by
{{< math >}}$ -1 ${{< /math >}} and all components in even positions by <span style="white-space:nowrap">{{< math >}}$ 1 ${{< /math >}}.</span> The effect of overflow can
cause similar behavior; for example, if we place
{{< math >}}$ 2^{31} - 1 ${{< /math >}} in an **int** variable and square it,
the overflow causes the result to be <span style="white-space:nowrap">1.</span> Successive powers will then
alternate between {{< math >}}$ 2^{31} - 1 ${{< /math >}} and <span style="white-space:nowrap">{{< math >}}$ 1 ${{< /math >}}.</span>

It turns out that this cyclic behavior occurs no matter what odd number
we use for <span style="white-space:nowrap">{{< math >}}$ x ${{< /math >}}.</span> However, in most cases the cycle is long enough that
keys of a reasonable size will have each component multiplied by a
unique value. The only odd numbers that result in short cycles are those
that are adjacent to a multiple of a large power of {{< math >}}$ 2 ${{< /math >}} (note that {{< math >}}$ 0 ${{< /math >}} is a
multiple of any integer).

The other potential problem occurs when we are hashing fairly short
keys. In such cases, if {{< math >}}$ x ${{< /math >}} is also small enough, the values computed
will all be much smaller than the maximum possible integer value
<span style="white-space:nowrap">{{< math >}}$ (2^{31} - 1) ${{< /math >}}.</span> As a result, we will not have a uniform
distribution of values. We therefore want to avoid making {{< math >}}$ x ${{< /math >}} too small.

Putting all this together, choosing {{< math >}}$ x ${{< /math >}} to be an odd number between {{< math >}}$ 30 ${{< /math >}}
and {{< math >}}$ 40 ${{< /math >}} works pretty well. These values are large enough so that seven key
components will usually overflow an **int**. Furthermore, they all have
a cycle length greater than {{< math >}}$ 100 ${{< /math >}} million.

We should always save the hash code in a **private** field after we
compute it so that subsequent requests for the same hash code don't
result in repeating the computation. This can be done in either of two
ways. One way is to compute it in an *eager* fashion by doing it in the
constructor. When doing it this way, the **GetHashCode** method simply
needs to return the value of the **private** field. While this is often
the easiest way, it sometimes results in computing a hash code that we
end up not using. The alternative is to compute it in a *lazy* fashion.
This requires an extra **private** field of type **bool**. This field is
used to indicate whether the hash code has been computed yet or not.
With this approach, the **GetHashCode** method first checks this field
to see if the hash code has been computed. If not, it computes the hash
code and saves it in its field. In either case, it then returns the
value of the hash code field.
