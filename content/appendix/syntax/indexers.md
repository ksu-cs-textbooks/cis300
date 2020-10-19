+++
title = "Indexers"
date = 2018-08-24T10:53:05-05:00
weight = 70
chapter = true
pre = "<b>A1.7. </b>"
+++

## Indexers

Recall that the ```System.Collections.Generic.Dictionary<TKey, TValue>``` class (see ["The **Dictionary\<TKey, TValue\>** Class"](/dictionaries/dictionary-tkey-tvalue)) allows keys to be used as indices for the purpose of adding new keys and values, changing the value associated with a key, and retrieving the value associated with a key in the table. In this section, we will discuss how to implement this functionality.

An indexer in C# is defined using the following syntax:

```C#
public TValue this[TKey k]
{
    get
    {
        // Code to retrieve the value with key k
    }
    set
    {
        // Code to associate the given value with key k
    }
}
```

Note the resemblance of the above code to the definition of a property. The biggest differences are:

- In place of a property name, an indexer uses the keyword ```this```.
- The keyword ```this``` is followed by a nonempty parameter list enclosed in square brackets.

Thus, an indexer is like a property with parameters. The parameters are the indices themselves; i.e., if `d` is a **Dictionary\<TKey, TValue\>** and `key` is a **TKey**, `d[key]` invokes the indexer with parameter `key`. In general, either the **get** accessor or the **set** accessor may be omitted, but at least one of them must be included. As in a property definition, the **set** accessor can use the keyword **value** for the value being assigned - in this case, the value to be associated with the given key. The **value** keyword and the return type of the **get** accessor will both be of type **TValue**, the type given prior to the keyword **this** in the above code.

We want to implement the indexer to behave in the same way as the indexer for **System.Collections.Generic.Dictionary\<TKey, TValue\>**. Thus, the **get** accessor is similar to the **TryGetValue** method, as outlined in ["A Simple Hash Table Implementation"](/hashing/simple), with a few important differences. First, the **get** accessor has no **out** parameter. Instead, it returns the value that **TryGetValue** assigns to its **out** parameter when the key is found. When the key is not found, because it can't return a **bool** to indicate this, it instead throws a **KeyNotFoundException**.

Likewise, the **set** accessor is similar to the **Add** method, as outlined in ["A Simple Hash Table Implementation"](/hashing/simple). However, whereas the **Add** method has a **TValue** parameter through which to pass the value to be associated with the given key, the **set** accessor gets this value from the **value** keyword. Furthermore, we don't want the **set** accessor to throw an exception if the key is found. Instead, we want it to replace the **Data** of the cell containing this key with a new **KeyValuePair** containing the key with the new value.
