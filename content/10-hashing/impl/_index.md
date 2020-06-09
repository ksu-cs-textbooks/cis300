+++
title = "Chapter 10.1  Hash Table Implementation"
date = 2018-08-24T10:53:05-05:00
weight = 51
chapter = true
pre = "<b>10.1 </b>"
+++

# Implementing a Hash Table

Because a hash table has a more complex structure than the data
structures we've examined up to this point, we will look at the
implementation details in stages. First, we will describe a simple
implementation using a fixed table size. This implementation will
provide only the most basic methods for adding, removing, and finding
keys and values. We will then consider *rehashing*, or increasing the
size of the table as necessary to improve performance. We will then show
how to implement enumerators for iterating through the keys and values.
Finally, we will show how to implement indexers.

The implementation we describe here is similar to the implementation of
[**Dictionary\<TKey,Ã‚Â TValue\>**](https://msdn.microsoft.com/en-us/library/xfhwa508.aspx)
in the .NET Framework. However, we will not discuss all of the
optimizations found in that implementation.
