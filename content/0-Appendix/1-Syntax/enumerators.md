---
title: "Enumerators"
weight: 55
pre: "11. "
---

As we saw in [the previous section](/~rhowell/DataStructures/redirect/foreach), in order for a data structure to support a **foreach** loop, it must be a subtype of either [**IEnumerable**](http://msdn.microsoft.com/en-us/library/system.collections.ienumerable.aspx) or [**IEnumerable\<T\>**](http://msdn.microsoft.com/en-us/library/9eekhta0\(v=vs.110\).aspx), where **T** is the type of the elements in the data structure. Thus, because [**Dictionary\<TKey, TValue\>**](https://msdn.microsoft.com/en-us/library/xfhwa508.aspx) is a subtype of **IEnumerable\<KeyValuePair\<TKey, TValue\>\>**, we can use a **foreach** loop to iterate through the key-value pairs that it stores. Likewise, its [**Keys**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2.keys?view=netframework-4.7.2#System_Collections_Generic_Dictionary_2_Keys) and [**Values**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2.values?view=netframework-4.7.2) properties get objects that are subtypes of **IEnumerable\<TKey\>** and **IEnumerable\<TValue\>**, respectively, **foreach** loops may be used to iterate these objects as well, in order to process all the keys or all the values stored in the dictionary. **IEnumerable** and **IEnumerable\<T\>** are [interfaces](http://people.cs.ksu.edu/~rhowell/DataStructures/redirect/interfaces); hence, we must define any subtypes so that they implement these interfaces. In this section, we will show how to implement the **IEnumerable\<T\>** interface to support a **foreach** loop.

The **IEnumerable\<T\>** interface requires two methods:

- **public IEnumerator\<T\> GetEnumerator()**
- **IEnumerator IEnumerable.GetEnumerator()**

The latter method is required only because **IEnumerable\<T\>** is a subtype of **IEnumerable**, and that interface requires a **GetEnumerator** method that returns a non-generic **IEnumerator**. Both of these methods should return the same object; hence, because **IEnumerator\<T\>** is also a subtype of **IEnumerator**, this method can simply call the first method:

```C#
IEnumerator IEnumerable.GetEnumerator()
{
    return GetEnumerator();
}
```

The **public GetEnumerator** method returns an **IEnumerator\<T\>**. In order to get instances of this interface, we could define a class that implements it; however, C\# provides a simpler way to define a subtype of this interface, or, when needed, the **IEnumerable\<T\>** interface.

Defining such an enumerator is as simple as writing code to iterate through the elements of the data structure. As each element is reached, it is enumerated via a **yield return** statement. For example, suppose a dictionary implementation uses a **List\<KeyValuePair\<TKey, TValue\>\>** called `_elements` to store its key-value pairs. We can then define its **GetEnumerator** method as follows:

```C#
public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator()
{
    foreach (KeyValuePair<TKey, TValue> p in _elements)
    {
        yield return p;
    }
}
```

Suppose user code contains a **Dictionary\<string, int\>** called `d` and a **foreach** loop structured as follows:

```C#
foreach (KeyValuePair<string, int> x in d)
{

}
```

Then the **GetEnumerator** method is executed until the **yield return** is reached. The state of this method is then saved, and the value `p` is used as the value for `x` in the first iteration of the **foreach** in the user code. When this loop reaches its second iteration, the **GetEnumerator** method resumes its execution until it reaches the **yield return** a second time, and again, the current value of `p` is used as the value of `x` in the second iteration of the loop in user code. This continues until the **GetEnumerator** method finishes; at this point, the loop in user code terminates.

Before continuing, we should mention that there is a simpler way of implementing the **public GetEnumerator** method in the above example. Because **List\<T\>** implements **IEnumerable\<T\>**, we can simply use its enumerator:

```C#
public IEnumerator> GetEnumerator()
{
    return _elements.GetEnumerator();
}
```

However, the above example illustrates a more general technique that can be used when we don't have the desired enumerator already available. For instance, continuing the above example, suppose we wish to define a **Keys** property to get an **IEnumerable\<KeyValuePair\<TKey, TValue\>\>** that iterates through the keys in the dictionary. Because the dictionary now supports a **foreach** loop, we can define this code to iterate through the key-value pairs in the dictionary, rather than the key-value pairs stored in the **List\<KeyVauePair\<TKey, TValue\>\>**:

```C#
public IEnumerable<TKey> Keys
{
    get
    {
        foreach (KeyValuePair<TKey, TValue> p in this)
        {
            yield return p.Key;
        }
    }
}
```

The above code is more maintainable than iterating through the **List\<KeyValuePair\<TKey, TValue\>\>** as it doesn't depend on the specific implementation of the dictionary.

While this technique usually works best with iterative code, it can also be used with recursion, although the translation usually ends up being less direct and less efficient. Suppose, for example, our dictionary were implemented as in "[Binary Search Trees](http://people.cs.ksu.edu/~rhowell/DataStructures/redirect/binary-search-trees)", where a binary search tree is used. The idea is to adapt the [inorder traversal](http://people.cs.ksu.edu/~rhowell/DataStructures/redirect/inorder-traversal) algorithm. However, we can't use this directly to implement a recursive version of the **GetEnumerator** method because this method does not take any parameters; hence, we can't apply it to arbitrary subtrees. Instead, we need a separate recursive method that takes a **BinaryTreeNode\<KeyValuePair\<TKey, TValue\>\>** as its parameter and returns the enumerator we need. Another problem, though, is that the recursive calls will no longer do the processing that needs to be done on the children - they will simply return enumerators. We therefore need to iterate through each of these enumerators to include their elements in the enumerator we are returning:

```C#
private static IEnumerable<KeyValuePair<TKey, TValue>> GetEnumerable(BinaryTreeNode<KeyValuePair<TKey, TValue>> t)
{
    if (t != null)
    {
        foreach (KeyValuePair<TKey, TValue> p in GetEnumerable(t.LeftChild))
        {
            yield return p;
        }
        yield return t.Data;
        foreach (KeyValuePair<TKey, TValue> p in GetEnumerable(t.RightChild))
        {
            yield return p;
        }
    }
}
```

Note that we've made the return type of this method **IEnumerable\<KeyValuePair\<TKey, TValue\>\>** because we need to use a **foreach** loop on the result of the recursive calls. Then because any instance of this type must have a **GetEnumerator** method, we can implement the **GetEnumerator** method for the dictionary as follows:

```C#
public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator()
{
    return GetEnumerable(_elements).GetEnumerator();
}
```

In transforming the inorder traversal into the above code, we have introduced some extra loops. These loops lead to less efficient code. Specifically, if the binary search tree is an AVL tree or other balanced binary tree, the time to iterate through this enumerator is in *O*(*n* lg *n*), where *n* is the number of nodes in the tree. The inorder traversal, by contrast, runs in *O*(*n*) time. In order to achieve this running time with an enumerator, we need to translate the inorder traversal to iterative code using a stack. However, this code isn't easy to understand:

```C#
public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator()
{
    Stack<BinaryTreeNode<KeyValuePair<TKey, TValue>>> s = new Stack<BinaryTreeNode<KeyValuePair<TKey, TValue>>>();
    BinaryTreeNode<KeyValuePair<TKey, TValue>> t = _elements;
    while (t != null || s.Count > 0)
    {
        while (t != null)
        {
            s.Push(t);
            t = t.LeftChild;
        }
        t = s.Pop();
        yield return t.Data;
        t = t.RightChild;
    }
}
```
