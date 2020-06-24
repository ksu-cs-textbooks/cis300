# The Dictionary\<TKey, TValue\> Class

A common problem in computing is that of keyed storage and retrieval.
Specifically, we have a number of data items, each having a unique
*key*. This key may be any type, and is used to find the associated data
item; i.e., given a key we need to find the data item associated with
that key. A data structure that provides this kind of access is called a
*dictionary*. The .NET Framework provides the
[**Dictionary\<TKey, TValue\>**](https://msdn.microsoft.com/en-us/library/xfhwa508.aspx)
class for this purpose. In this section, we will discuss the use of this
class. In [the next
section](/~rhowell/DataStructures/redirect/dictionary-linked-lists), we
will discuss how this data structure can be implemented using a linked
list. In subsequent sections, we will consider alternative
implementations.

Note that the **Dictionary\<TKey, TValue\>** has two type parameters,
**TKey** and **TValue**. **TKey** is the type of the keys, and
**TValue** is the type of the values (i.e., the data elements associated
the keys). Keys must always be non-**null** - any attempt to use a
**null** key will result in an **ArgumentNullException**. A
**Dictionary\<TKey, TValue\>**'s most basic **public** methods are:

  - [**void Add(TKey key, TValue
    value)**](http://msdn.microsoft.com/en-us/library/k7z0zy8k.aspx):
    Associates the given value with the given key. If there is already a
    value associated with the given key, it throws an
    **ArgumentException**.
  - [**bool Remove(TKey
    key)**](http://msdn.microsoft.com/en-us/library/kabs04ac.aspx):
    Removes the given key and its associated value from the dictionary,
    and returns whether the key was found.
  - [**bool TryGetValue(TKey key, out TValue
    value)**](http://msdn.microsoft.com/en-us/library/bb347013.aspx):
    Returns whether the given key is in the dictionary. If so, the
    [**out**
    parameter](http://people.cs.ksu.edu/~rhowell/DataStructures/redirect/out-ref)
    `value` is assigned the value associated with `key`; otherwise,
    `value` is assigned the default value for its type.

The above methods can be used for building and updating a
**Dictionary**, as well as for looking up values by their keys. It is
also possible to do updates and lookups using indexing. Specifically, a
key may be used as an index in a **Dictionary**, as if the
**Dictionary** were an array. For example, suppose that `dictionary` is
a **Dictionary\<TKey, TValue\>**, `k` is a **TKey**, and `v` is a
**TValue**. We can then do the following:

    dictionary[k] = v;

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

    v = dictionary[k];

Again, the behavior is similar to the **TryGetValue** method, but
slightly different, as there is no **bool** in the above statement. When
using the indexer, if the key is not in the dictionary, it will throw a
**KeyNotFoundException**. Thus, we use the indexer when we expect the
key to be in the dictionary, but we use the **TryGetValue** method when
we don't know if the key is in the dictionary.
