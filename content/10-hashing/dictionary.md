# The Dictionary\<TKey,Ã‚Â TValue\> Class

The generic term for a data structure providing storage and retrieval
via keys, but not necessarily the ability to process the data in any
particular order, is *dictionary*. Thus, AVL trees can be used to
implement dictionaries that can add new elements, remove elements, and
find keys in *O*(log *n*) time in the worst case, (not counting the cost
of comparing keys) where *n* is the number of elements in the structure.
In this section, we will give an overview of a data structure called a
*hash table*, which provides even better performance without keeping the
keys in any particular order. We then present the
**Dictionary\<TKey,Ã‚Â TValue\>** class, which is provided by the
.NET Framework for keyed storage and retrieval and is implemented using
a hash table.

A hash table is typically organized as an array of linked lists. The
individual cells in the linked lists each store a key and a value.
Associated with this structure is a *hash function*, which takes a key
as its parameter and computes an array location. This array location
contains the linked list that will contain the given key if it is in the
hash table. Thus, in order to find a key in a hash table, we first apply
the hash function to the key, then search the linked list at the
location computed by the hash function. The following picture
illustrates the layout of a hash table in which the keys are
**strings**s and the values are **int**s, and the hash function is
denoted by *h*:

![A hash table.](hash-table.jpg)

For simplicity, the **string**s in the above figure are shown inside the
linked list cells, even though **string** is a reference type.

In order to achieve good performance, we want all of the linked lists to
be short. This requires, among other things, that we make the array
sufficiently large. We therefore increase the size of the array as the
number of elements increases.

We will look at the implementation details more carefully in later
sections. For now, we will focus on the
[**Dictionary\<TKey,Ã‚Â TValue\>**](http://msdn.microsoft.com/en-us/library/xfhwa508.aspx)
class, an implementation of a hash table found in the
**System.Collections.Generic** namespace. In order to be able to utilize
a **Dictionary\<TKey,Ã‚Â TValue\>** fully, though, it's important to
have some understanding of its implementation. Specifically, in order
for a **Dictionary\<TKey,Ã‚Â TValue\>** to work on a user-defined key
type, it must have a hash function that maps instances of this key type
to array locations. A part of this hash function must be provided by the
implementer of the key type. For now, however, we will focus on
predefined key types such as **string** and **int** which already have
hash functions defined.

Within a **Dictionary\<TKey,Ã‚Â TValue\>**, the keys are of type
**TKey** and the values are of type **TValue**. Keys must always be
non-**null** - any attempt to use a **null** key will result in an
**ArgumentNullException**. Its most basic **public** methods are:

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
    Returns whether the given key is in the dictionary. If so, `value`
    is assigned the value associated with `key`; otherwise, `value` is
    assigned the default value for its type.

The above methods can be used for building and updating a dictionary, as
well as for looking up values by their keys. It is also possible to do
updates and lookups using indexing. Specifically, a key may be used as
an index in a dictionary, as if the dictionary were an array. For
example, suppose that `dictionary` is a
**Dictionary\<TKey,Ã‚Â TValue\>**, `k` is a **TKey**, and `v` is a
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

This class also has two **public** properties that can be used to
iterate through the keys or the values in some unspecified order:

  - [**Keys**](http://msdn.microsoft.com/en-us/library/yt2fy5zk.aspx):
    gets an **IEnumerable\<TKey\>** containing all of the keys.
  - [**Values**](http://msdn.microsoft.com/en-us/library/ekcfxy3x.aspx):
    gets an **IEnumerable\<TValue\>** containing all of the values.

Because the values returned by these properties are sub-types of
**IEnumerable\<T\>** for some type **T**, we can use a
[**foreach**](/~rhowell/DataStructures/redirect/foreach) loop to iterate
through them. Thus, for example, within the following loop, `k` takes on
the value of each key in turn:

    foreach (TKey k in dictionary.Keys)
    {
        . . .
    }

Thus, using a **Dictionary\<TKey,Ã‚Â TValue\>** with key types such as
**string** or **int** is fairly straightforward. In the sections that
follow, we'll consider how user-defined types may be built to be used as
keys.
