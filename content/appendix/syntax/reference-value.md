+++
title = "Reference Types and Value Types"
weight = 5
pre = "<b>A1.1. </b>"

+++

## Reference Types and Value Types

Data types in C# come in two distinct flavors: *value types* and *reference types*. In order to understand the distinction, it helps to consider how space is allocated in C#. Whenever a method is called, the space needed to execute that method is allocated from a data structure known as the *call stack*. The space for a method includes its local variables, including its parameters (except for [**out** or **ref** parameters](/appendix/syntax/out-ref)). The organization of the call stack is shown in the following figure:

![A picture of the call stack should appear here](images/call-stack.jpg)

When the currently-running method makes a method call, space for that method is taken from the beginning of the unused stack space. When the currently-running method returns, its space is returned to the unused space. Thus, the call stack works like [the array-based implementation of a stack](/stacks-queues/stack-impl), and this storage allocation is quite efficient.

What is stored in the space allocated for a variable depends on whether the variable is for a value type or a reference type. For a value type, the value of the variable is stored directly in the space allocated for it. There are two kinds of value types: [structures](/appendix/syntax/structs) and [enumerations](/appendix/syntax/enumerations). Examples of structures include numeric types such as **int**, **double**, and **char**. An example of an enumeration is [**DialogResult**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.dialogresult?view=windowsdesktop-6.0) (see ["**MessageBox**es"](/io/dialogs/message-boxes) and ["File Dialogs"](/io/dialogs/file-dialogs)).

Because value types are stored directly in variables, whenever a value is assigned to a variable of a value type, the entire value must be written to the variable. For performance reasons, value types therefore should be fairly small.

For reference types, the values are not stored directly into the space allocated for the variable. Instead, the variable stores a *reference*, which is like an address where the value of the variable can actually be found. When a reference type is constructed with a **new** expression, space for that instance is allocated from a large data structure called the *heap* (which is unrelated to a [heap used to implement a priority queue](/trees/priority-queues/heaps)). Essentially, the heap is a large pool of available memory from which space of different sizes may be allocated at any time. We will not go into detail about how the heap is implemented, but suffice it to say that it is more complicated and less efficient than the stack. When space for a reference type is allocated from the heap, a reference to that space is stored in the variable. Larger data types are more efficiently implemented as reference types because an assignment to a variable of a reference type only needs to write a reference, not the entire data value.

There are three kinds of reference types: classes, [interfaces](/trees/tries/multiple-impl), [records](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/record), and [delegates](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/reference-types#the-delegate-type). Records and delegates are beyond the scope of this course.

Variables of a reference type do not need to refer to any data value. In this case, they store a value of **null** (variables of a value type cannot store **null**). Any attempt to access a method, property, or other member of a **null** or to apply an index to it will result in a **NullReferenceException**.

The fields of classes or structures are stored in a similar way, depending on whether the field is a value type or a reference type. If it is a value type, the value is stored directly in the field, regardless of whether that field belongs to an object allocated from the stack or the heap. If it is a reference type, it stores either **null** or a reference to an object allocated from the heap.

The difference between value types and reference types can be illustrated with the following code example:

```c#
private int[] DoSomething(int i, int j)
{
    Point a = new(i, j);
    Point b = a;
    a.X = i + j;
    int[] c = new int[10];
    int[] d = c;
    c[0] = b.X;
    return d;
}
```

Suppose this method is called as follows:

```c#
    int[] values = DoSomething(1, 2);
```

The method contains six local variables: `i`, `j`, `a`, `b`, `c`, and `d`. **int** is a structure, and hence a value type. [**Point**](https://learn.microsoft.com/en-us/dotnet/api/system.drawing.point?view=net-6.0) is a structure (and hence a value type) containing **public int** properties **X** and **Y**, each of which can be read or modified. **int\[ \]**, however, is a reference type. Space for all six of these variables is allocated from the stack, and the space for the two **Point**s includes space to store two **int** fields for each. The values 1 and 2 passed for `i` and `j`, respectively, are stored directly in these variables.

The constructor in the first line of the method above sets the **X** property of `a` to 1 and the **Y** property of `a` to 2. The next statement simply copies the value of `a` - i.e., the point (1, 2) - to `b`. Thus, when the **X** property of `a` is then changed to 3, `b` is unchanged - it still contains the point (1, 2).

On the other hand, consider what happens when something similar is done with array variables. When `c` is constructed, it is assigned a new array allocated from the heap and containing 10 locations. These 10 locations are automatically initialized to 0. However, because an array is a reference type, the variable `c` contains a reference to the actual array object, not the array itself. Thus, when `c` is copied to `d`, the array itself is not copied - the reference to the array is copied. Consequently, `d` and `c` now refer to the same array object, not two different arrays that look the same. Hence, after we assign `c[0]` a value of 1, `d[0]` will also contain a value of 1 because `c` and `d` refer to the same array object. (If we want `c` and `d` to refer to different array objects, we need to construct a new array for each variable and make sure each location of each array contains the value we want.) The array returned therefore resides on the heap, and contains 1 at index 0, and 0 at each of its other nine locations. The six local variables are returned to unused stack space; however, because the array was allocated from the heap, the calling code may continue to use it.

<span id="nullable-types"></span>It is sometimes convenient to be able to store a **null** in a variable of a value type. For example, we may want to indicate that an **int** variable contains no meaningful value. In some cases, we can reserve a specific **int** value for this purpose, but in other cases, there may be no **int** value that does not have some other meaning within the context. In such cases, we can use the `?` operator to define a *nullable* version of a value type; e.g.,

```C#
int? i = null;
```

We can do this with any value type. Nullable value types such as **int?** are the only value types that can store **null**.

Beginning with C# version 8.0, similar annotations using the `?` operator are allowed for reference types. In contrast to its use with value types, this operator has no effect on the code execution when it is used with a reference type. Instead, such annotations are used to help programmers to avoid **NullReferenceException**s. For example, the type **string** is used for variables that should never be **null**, but **string?** is used for variables that might be **null**. Assigning **null** to a **string** variable will not throw an exception (though it might lead to a **NullReferenceException** later); however, starting with .NET 6, the compiler will generate a warning whenever it cannot determine that a value assigned to a non-nullable variable is not **null**. One way to avoid this warning is to use the nullable version of the type; e.g.,

```c#
string? s = null;
```

The compiler uses a technique called *static analysis* to try to determine whether a value assigned to a variable of a non-nullable reference type is non-**null**. This technique is limited, resulting in many cases in which the value assigned cannot be **null**, but the compiler gives a warning anyway. (This technique is especially limited in its ability to analyze arrays.) In such cases, the **null**-forgiving operator `!` can be used to remove the warning. Whenever you use this operator, the CIS 300 style requirements specify that you must include a comment explaining why the value assigned cannot be **null** (see ["Comments"](/appendix/style/comments/)).

For example, a [**StreamReader**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamreader?view=net-6.0)'s [**ReadLine**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamreader.readline?view=net-6.0) method returns **null** when there are no more lines left in the stream, but otherwise returns a non-**null** **string** (see ["Advanced Text File I/O"](/io/advanced-text-file/)). We can use the **StreamReader**'s [**EndOfStream**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamreader.endofstream?view=net-6.0) property to determine whether all lines have been read; for example, if `input` is a **StreamReader**:

```C#
while (!input.EndOfStream)
{
    string line = input.ReadLine();
    
    // Process the line
}
```

However, because **ReadLine** has a return type of **string?** and the type of `line` is **string**, the compiler generates a warning - even though **ReadLine** will never return **null** in this context. We can eliminate the warning as follows:

```c#
while (!input.EndOfStream)
{
    // Because input is not at the end of the stream, ReadLine won't return null.
    string line = input.ReadLine()!;
    
    // Process the line
}
```

Because classes are reference types, it is possible for the definition of a class **C** to contain one or more fields of type **C** or, more typically, type **C?**; for example:

```c#
public class C
{
    private C? _nextC;
    . . .
}
```

Such circularity would be impossible for a value type because there would not be room for anything else if we tried to include a value of type **C?** within a value of type **C**. However, because **C** is a class, and hence a reference type, `_nextC` simply contains either **null** or a reference to some object of type **C**. When the runtime system constructs an instance of type **C**, it just needs to make it large enough to hold a reference, along with any other fields defined within **C**. Such recursive definitions are a powerful way to link together many instances of a type. See "[Linked Lists](/linked-lists)" and "[Trees](/trees)" for more information.

Because all types in C# are subtypes of **object**, which is a reference type, every value type is a subtype of at least one reference type (however, value types cannot themselves have subtypes). It is therefore possible to assign an instance of a value type to a variable of a reference type; for example:

```c#
object x = 3;
```

When this is done, a *boxed* version of the value type is constructed,
 and the value copied to it. The boxed version of the value type is
 just like the original value type, except that it is allocated from
 the heap and accessed by reference, not by value. A reference to this boxed version is then assigned to the variable of the reference type. Note that multiple variables of the reference type may refer to the same boxed instance of the value type.
Note also that boxing may also occur when passing parameters. For example, suppose we have a method:

```c#
private object F(object x)
{

}
```

If we call **F** with a parameter of 3, then 3 will need to be copied to a boxed **int**, and a reference to this boxed **int** will be assigned to `x` within **F**.
