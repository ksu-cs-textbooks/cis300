+++
title = "The Dictionary<TKey, TValue> Class"
weight = 10

pre = "<b>5.1. </b>"
+++

## The **Dictionary\<TKey, TValue\>** Class

In this section, we will discuss the use of the [**Dictionary\<TKey, TValue\>**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2?view=net-6.0) 
class, which implements a dictionary. In [the next
section](/dictionaries/linked-list-impl), we
will discuss how this data structure can be implemented using a linked
list. In subsequent sections, we will consider alternative
implementations.

Note that the **Dictionary\<TKey, TValue\>** type has two type parameters,
**TKey** and **TValue**. **TKey** is the type of the keys, and
**TValue** is the type of the values (i.e., the data elements associated
with the keys). Keys must always be non-**null** --- any attempt to use a
**null** key will result in an **ArgumentNullException**. A
**Dictionary\<TKey, TValue\>**'s most basic **public** methods are:

  - [**void Add(TKey key, TValue
    value)**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2.add?view=net-6.0#system-collections-generic-dictionary-2-add(-0-1)):
    Associates the given value with the given key. If there is already a
    value associated with the given key, it throws an
    **ArgumentException**.
  - [**bool Remove(TKey
    key)**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2.remove?view=net-6.0#system-collections-generic-dictionary-2-remove(-0-1@)):
    Removes the given key and its associated value from the dictionary,
    and returns whether the key was found.
  - [**bool TryGetValue(TKey key, out TValue?
    value)**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2.trygetvalue?view=net-6.0#system-collections-generic-dictionary-2-trygetvalue(-0-1@)):
    Returns whether the given key is in the dictionary. If so, the
    [**out**
    parameter](/appendix/syntax/out-ref)
    `value` is assigned the value associated with `key`; otherwise,
    `value` is assigned the [default
    value](/stacks-queues/stack-impl/#default-value) for its
    type.

{{% notice note %}}

The type of the `value` parameter for **TryGetValue** is actually **TValue**, not **TValue?**. Another kind of annotation is used to indicate that this **out** parameter may be **null** only when the method returns **false**. Because such annotations are beyond the scope of CIS 300, we will treat this parameter as if it were simply defined as being nullable.

{{% /notice %}}

The above methods can be used for building and updating a
**Dictionary**, as well as for looking up values by their keys. It is
also possible to do updates and lookups using indexing. Specifically, a
key may be used as an index in a **Dictionary**, as if the
**Dictionary** were an array. For example, suppose that `dictionary` is
a **Dictionary\<TKey, TValue\>**, `k` is a **TKey**, and `v` is a
**TValue**. We can then do the following:

```C#
dictionary[k] = v;
```
This will associate the value `v` with the key `k`, as the **Add**
method does; however, its behavior is slightly different if `k` already
has a value associated with it. Whereas the **Add** method would throw
an exception in this case, using the indexer will simply replace the
value previously associated with `k` by the new value `v`. Thus, we use
the **Add** method when we expect the key to be a new key for the
dictionary, but we use the indexer when we want to associate the value
with the key, regardless of whether the key is already in the
dictionary.

Likewise, we can use the indexer to look up a key:
```C#
v = dictionary[k];
```
Again, the behavior is similar to the **TryGetValue** method, but
slightly different, as there is no **bool** in the above statement. When
using the indexer, if the key is not in the dictionary, it will throw a
**KeyNotFoundException**. Thus, we use the indexer when we expect the
key to be in the dictionary, but we use the **TryGetValue** method when
we don't know if the key is in the dictionary.
