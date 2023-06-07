+++
title = "Implementing a Dictionary with a Linked List"
weight = 20

pre = "<b>5.2. </b>"
+++

## Implementing a Dictionary with a Linked List

One way of implementing a dictionary is to store all the keys and values
in a linked list. We want to do this in such a way that a key is stored
together with its associated value. To facilitate this, .NET
provides a structure
[**KeyValuePair\<TKey, TValue\>**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.keyvaluepair-2?view=net-6.0)
in the **System.Collections.Generic** namespace. This structure is used
simply for storing a key and a value. The type parameter **TKey** is
used to define the type of the keys, and the other type parameter
**TValue** is used to define the type of the values. It has two
**public** properties:

  -  [**Key**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.keyvaluepair-2.key?view=net-6.0#system-collections-generic-keyvaluepair-2-key),
    which gets the key stored; and
  - [**Value**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.keyvaluepair-2.value?view=net-6.0#system-collections-generic-keyvaluepair-2-value),
    which gets the value stored.

Note that neither of these properties can be set; i.e., the structure is
immutable. In order to set the key and value, we need to construct a new
instance using its [2-parameter
constructor](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.keyvaluepair-2.-ctor?view=net-6.0#system-collections-generic-keyvaluepair-2-ctor(-0-1)).
The first parameter to this constructor is the key, and the second is
the value.

Now that we have a way of storing keys and values together, we can
implement a **Dictionary\<TKey, TValue\>** with a linked list
comprised of instances of
**LinkedListCell\<KeyValuePair\<TKey, TValue\>\>**. Thus, each
cell of the list stores as its **Data** a
**KeyValuePair\<TKey, TValue\>** containing a key and its
associated value. To add a key and a value, we first need to search the
list for a cell containing that key. If we find such a cell, we either
replace the **KeyValuePair** in that cell with a new **KeyValuePair**
containing the given key and value, or we throw an exception, depending
on the specific behavior required. If we don't find such a cell, we
insert a new cell containing the given key and value. Because it doesn't
matter where we insert it, we might as well insert it at the beginning
of the list, as that is the easiest way. We can remove a key using
techniques described in "[Finding Prime
Numbers"](/linked-lists/sieve-eratosthenes).

The main disadvantage to this approach is that searching for a key is
expensive. For example, to search for a key that is not in the
dictionary, we need to examine every key in the dictionary. We would
like to improve on this performance.

One way of improving the performance of searching is to store the keys
in increasing order. Then as we search, if we see a key that is larger
than the key we are looking for, we can stop. However, recall that keys
can be of any type. For some types of keys, "increasing order" and
"larger than" make no sense.

<span id="where"></span> C\# does provide a way to restrict the types
that can be passed as type parameters to generic types. Specifically, we
can restrict the type **TKey** by writing the **class** statement as
follows:

```C#
public class Dictionary<TKey, TValue> where TKey : notnull, IComparable<TKey>   
```

The **where** clause in this statement constrains **TKey** in two ways:

- `notnull` constrains it to be a [non-nullable](/appendix/syntax/reference-value#nullable-types) type. The compiler doesn't actually enforce this constraint, but will give a warning if a nullable type is used for **TKey**.
- `IComparable<TKey>` constrains it to be a
  subtype of
  [**IComparable\<TKey\>**](https://learn.microsoft.com/en-us/dotnet/api/system.icomparable-1?view=net-6.0).
  Each subtype of **IComparable\<TKey\>** contains a method [**public int
  CompareTo(TKey?
  x)**](https://learn.microsoft.com/en-us/dotnet/api/system.icomparable-1.compareto?view=net-6.0#system-icomparable-1-compareto(-0)). If `a`
  and `b` are of type **TKey**, then `a.CompareTo(b)` returns:

  - A negative number if `a` is considered to be less than `b`;
  - 0 if `a` is considered to be equal to `b`; or
  - A positive number if `a` is considered to be greater than `b` or if `b` is **null**.

We can therefore use this **CompareTo** method to keep the list in
increasing order.

Note that by constraining the key type in this way, we are making the
**Dictionary\<TKey, TValue\>** less general, as we may sometimes want
to use a key type that can't be ordered. On the other hand, there are
times when not only do we have a key type that can be ordered, but also
we need to access the keys in increasing order (for example, to print an
ordered list of keys with their values). In such cases, what we actually
need is an *ordered dictionary*, which both restricts the keys in this
way and provides a means of accessing them in increasing order. While we
won't consider the full implementation of an ordered dictionary here, it
is worth considering how we can improve performance by keeping the keys
in increasing order.

Let's now consider how to add a key and value to a linked list storing
keys in increasing order. We first need to find where the key belongs in
the ordering. Specifically, the cell whose **Next** property needs to be
changed (assuming the key is not already in the list) is the one that
must precede the new cell. We therefore need to find the last cell whose
key is less than the key we need to add. Note also that when we are
removing a key, the cell whose **Next** property needs to be changed is
the last cell whose key is less than the key we are removing.
Furthermore, if we are looking up a key, we need to look in the cell
that follows the last cell whose key is less than the key we are looking
for. This suggests that we should provide a **private** method to find
the last cell whose key is less than a given key, provided such a cell exists.

Before we can write such a method, however, we first need to address a
problem that occurs if we are trying to add, remove, or look up a key
that is smaller than all other keys in the list. In this case, there are
no cells containing keys smaller than the given key.

We can avoid needing a special case to deal with this problem if we
include a special *header cell* at the beginning of our linked list.
This cell will not contain any meaningful data, but it will always be
present. If we consider that its key is less than any other key (though
we will never actually examine its key), then there will always be at
least one key less than any given key. We can obtain this
header cell by initializing the linked list to contain a new cell containing the [default](/stacks-queues/stack-impl#default-value) key-value pair,
rather than to **null**. Note that because the linked list will always contain at least the header cell, the reference to it should *not* be nullable.

{{% notice warning %}}

Setting the data in the header cell to the default key-value pair means that if the key type and/or the value type is a reference type, then it will be **null** in this pair, even if the type isn't nullable. There is no way to avoid this, as the only key and value objects that we know of are the default values, which may be **null**. However, it doesn't make sense to use **KeyValuePair\<TKey?, TValue?\>** as the type of the data items within the linked list just because of the header cell, whose data we don't intend to use. Furthermore, the compiler won't generate a warning when **KeyValuePair\<TKey, TValue\>** is used. We should therefore use this latter type, and be sure not to use the data stored in the header cell. We should also include a warning of possible null values in a comment when we initialize the header cell.

{{% /notice %}}

A method to find the last cell containing a key less than a given key is
now straightforward. We initialize a variable to the first cell (i.e.,
the header cell), and set up a loop that iterates as long as the *next*
cell is non-**null** and contains a key less than the given key. Each
iteration advances to the next cell. When the loop terminates, we return
the cell we have reached.

To look up a key, we use the above method to find the last cell
containing a key less than the key we are looking for. If the next cell
is non-**null** and contains the key we are looking for, then we have
found it; otherwise, it cannot be in the list. To add a key and value,
we first need to look up the key in the same way. If we don't find it,
we insert a new cell containing this key and value following the last
cell containing a key less than this key. To remove a key, we proceed in
a similar way, but if we find the key, we remove this cell from the
list.

While keeping the keys in increasing order improves the performance of
many searches, the overall performance is still unsatisfactory for even
data sets of moderate size. In subsequent sections, we will explore ways
of improving this performance using various data structures.
