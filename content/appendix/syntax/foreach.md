+++
title = "The foreach Statement"
weight = 100

pre = "<b>A1.10. </b>"
+++

## The **foreach** Statement

C# provides a **foreach** statement that is often useful for iterating through the elements of certain data structures. A **foreach** can be used when all of the following conditions hold:

1.  The data structure is a subtype of either [**IEnumerable**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.ienumerable?view=net-6.0) or [**IEnumerable\<T\>**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.ienumerable-1?view=net-6.0) for some type **T**. 
2.  You do not need to know the locations in the data structure of the individual elements. 
3.  You do not need to modify the data structure with this loop.

{{% notice warning %}}
Many of the data structures provided to you in CIS 300, as well as
many that you are to write yourself for this class, are not subtypes
of either of the types mentioned in 1 above. Consequently, we cannot
use a **foreach** loop to iterate through any of these data
structures. However, most of the data structures provided in the .NET
Framework, as well as all arrays, are subtypes of one of these types.
{{% /notice %}}

For example, the **string** class is a subtype of both **IEnumerable**
and **IEnumerable\<Char\>**. To see that this is the case, look in
[the documentation for the **string**
class](https://learn.microsoft.com/en-us/dotnet/api/system.string?view=net-6.0). In
the "Implements" section, we see all of the
[interfaces](/trees/tries/multiple-impl) implemented by **string**.
Because **string** implements both of these interfaces, it is a
subtype of each.  We can therefore iterate through the elements (i.e., the characters) of a **string** using a **foreach** statement, provided we don't need to know the location of each character in the **string** (because a **string** is immutable, we can't change its contents).

Suppose, for example, that we want to find out how many times the letter 'i' occurs in a **string** `s`. Because we don't need to know the locations of these occurrences, we can iterate through the characters with a **foreach** loop, as follows:

```C#
int count = 0;
foreach (char c in s)
{
    if (c == 'i')
    {
        count++;
    }
}
```

The **foreach** statement requires three pieces of information:

- The type of the elements in the data structure (**char** in the above example).
- The name of a new variable (`c` in the above example). The type of this variable will be the type of the elements in the data structure (i.e., **char** in the above example). It will take on the values of the elements as the loop iterates.
- Following the keyword **in**, the data structure being traversed (`s` in the above example).

The loop then iterates once for each element in the data structure (unless a statement like **return** or **break** causes it to terminate prematurely). On each iteration, the variable defined in the **foreach** statement stores one of the elements in the data structure. Thus, in the above example, `c` takes the value of a different character in `s` on each iteration. Note, however, that we have no access to the location containing `c` on any particular iteration - this is why we don't use a **foreach** loop when we need to know the locations of the elements. Because `c` takes on the value of each character in `s`, we are able to count how many of them equal 'i'.

Occasionally, it may not be obvious what type to use for the
**foreach** loop variable. In such cases, if the data structure is a
subtype of **IEnumerable\<T\>**, then the type should be whatever type
is used for **T**. Otherwise, it is safe to use **object**. Note,
however, that if the data structure is not a subtype of
**IEnumerable\<T\>**, but you know that the elements are some specific
subtype of **object**, you can use that type for the loop variable -
the type will not be checked until the code is executed. For example,
[**ListBox**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.listbox?view=windowsdesktop-6.0)
is a class that implements a GUI control displaying a list of
elements. The elements in the **ListBox** are accessed via its
[**Items**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.listbox.items?view=windowsdesktop-6.0#system-windows-forms-listbox-items)
property, which gets a data structure of type
[**ListBox.ObjectCollection**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.listbox.objectcollection?view=windowsdesktop-6.0). Any
**object** can be added to this data structure, but we often just add **string**s. **ListBox.ObjectCollection** is a subtype of **IEnumerable**; however, it is permissible to set up a **foreach** loop as follows:

```C#
foreach (string s in uxList.Items)
{

}
```

where `uxList` is a **ListBox** variable. As long as all of the elements in **uxList.Items** are **string**s, no exception will be thrown.

While the **foreach** statement provides a clean way to iterate through a data structure, it is important to keep in mind its limitations. First, it can't even be used on data structures that aren't subtypes of **IEnumerable** or **IEnumerable\<T\>**. Second, there are many cases, especially when iterating through arrays, where the processing we need to do on the elements depends on the locations of the elements. For example, consider the problem of determining whether two arrays contain the same elements in the same order. For each element of one array, we need to know if the element *at the same location* in the other array is the same. Because the locations are important, a **foreach** loop isn't appropriate - we should use a **for** loop instead. Finally, a **foreach** should never be used to modify a data structure, as this causes unpredictable results.

Even when a **foreach** would work, it is not always the best choice. For example, in order to determine whether a data structure contains a given element, we could iterate through the structure with a **foreach** loop and compare each element to the given element. While this would work, most data structures provide methods for determining whether they contain a given element. These methods are often far more efficient than using a **foreach** loop.
