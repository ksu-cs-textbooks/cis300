+++
title = "Structures"
weight = 30

pre = "<b>A1.3. </b>"
+++

## Structures

A structure is similar to a class, except that it is a [value type](/appendix/syntax/reference-value), whereas a class is a [reference type](/appendix/syntax/reference-value). A structure definition looks a lot like a class definition; for example, the following defines a structure for storing information associated with a name:

```c#
/// <summary>
/// Stores a frequency and a rank.
/// </summary>
public readonly struct FrequencyAndRank
{
    /// <summary>
    /// Gets the Frequency.
    /// </summary>
    public float Frequency { get; }

    /// <summary>
    /// Gets the Rank.
    /// </summary>
    public int Rank { get; }

    /// <summary>
    /// Initializes a FrequencyAndRank with the given values.
    /// </summary>
    /// <param name="freq">The frequency.</param>
    /// <param name="rank">The rank.</param>
    public FrequencyAndRank(float freq, int rank)
    {
        Frequency = freq;
        Rank = rank;
    }

    /// <summary>
    /// Obtains a string representation of the frequency and rank.
    /// </summary>
    /// <returns>The string representation.</returns>
    public override string ToString()
    {
        return Frequency + ", " + Rank;
    }
}
```

Note that the above definition looks just like a class definition, except that the keyword **struct** is used instead of the keyword **class**, and the **readonly** modifier is used. The **readonly** modifier cannot be used with a class definition, but is often used with a structure definition to indicate that the structure is *immutable*. The compiler then verifies that the structure definition does not allow any fields to be changed; for example, it verifies that no property has a **set** accessor. 

A structure can be defined anywhere a class can be defined. However, one important restriction on a structure definition is that no field can be of the same type as the structure itself. For example, the following definition is not allowed:

```c#
public struct S
{
    private S _nextS;
}
```

The reason for this restriction is that because a structure is a value type, each instance would need to contain enough space for another instance of the same type, and this instance would need enough space for another instance, and so on forever. This type of circular definition is prohibited even if it is indirect; for example, the following is also illegal:

```C#
public struct S
{
    public T NextT { get; }
}

public struct T
{
    public S? NextS { get; }
}
```

Because the **NextT** [property](/appendix/syntax/properties) uses the default implementation, each instance of **S** contains a hidden field of type **T**. Because **T** is a value type, each instance of **S** needs enough space to store an instance of **T**. Likewise, because the **NextS** property uses the default implementation, each instance of **T** contains a hidden field of type **S?**. Because **S** is a value type, each instance of **T** - and hence each instance of **S** - needs enough space to store an instance of **S?**, which in turn needs enough space to store an instance of **S**. Again, this results in circularity that is impossible to satisfy.

Any structure must have a constructor that takes no parameters. If one is not explicitly provided, a default constructor containing no statements is included. If one is explicitly provided, it must be **public**. Thus, an instance of a structure can always be constructed using a no-parameter constructor. If no code for such a constructor is provided, each field that does not contain an initializer is set to its default value.

If a variable of a structure type is assigned its [default value](/stacks-queues/stack-impl/#default-value), each of its fields is set to its default value, regardless of any initializers in the structure definition. For example, if **FrequencyAndRank** is defined as above, then the following statement will set both `x.Frequency` and `x.Rank` to 0:

```C#
FrequencyAndRank x = default;
```

{{% notice warning %}}

Because the default value of a type can always be assigned to a variable of that type, care should be taken when including fields of reference types within a structure definition. Because the default instance of this structure will contain **null** values for all fields of reference types, these fields should be defined to be [nullable](/appendix/syntax/reference-value#nullable-types). The compiler provides no warnings about this.

{{% /notice %}}  

For more information on structures, see the section, ["Structure types"](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/struct) in the *C\# Language Reference*.
