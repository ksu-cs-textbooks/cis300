---
title: "Structures"
weight: 9
pre: "3. "
---

A structure is similar to a class, except that it is a [value type](/~rhowell/DataStructures/redirect/reference-value), whereas a class is a [reference type](/~rhowell/DataStructures/redirect/reference-value). A structure definition looks a lot like a class definition; for example, the following defines a structure for storing information associated with a name:

```c#
/// <summary>
/// A structure containing a name, frequency, and rank.
/// </summary>
public struct NameInformation
{
    /// <summary>
    /// The name.
    /// </summary>
    private string _name;

    /// <summary>
    /// The frequency.
    /// </summary>
    private float _frequency;

    /// <summary>
    /// The rank.
    /// </summary>
    private int _rank;

    /// <summary>
    /// Gets the name.
    /// </summary>
    public string Name
    {
        get
        {
            return _name;
        }
    }

    /// <summary>
    /// Gets the frequency.
    /// </summary>
    public float Frequency
    {
        get
        {
            return _frequency;
        }
    }

    /// <summary>
    /// Gets the rank.
    /// </summary>
    public int Rank
    {
        get
        {
            return _rank;
        }
    }

    /// <summary>
    /// Constructs a new NameInformation containing the given name,
    /// frequency, and rank.
    /// </summary>
    /// <param name="name">The name.</param>
    /// <param name="frequency">The frequency.</param>
    /// <param name="rank">The rank.</param>
    public NameInformation(string name, float frequency, int rank)
    {
        _name = name;
        _frequency = frequency;
        _rank = rank;
    }
}
```

Note that the above definition looks just like a class definition, except that the keyword **struct** is used instead of the keyword **class**. A structure can be defined anywhere a class can be defined. However, there are several restrictions on what a structure definition may contain. Some of the more important restrictions include:

- A field may not be initialized in the statement that defines it unless it is declared to be [**const**](/~rhowell/DataStructures/redirect/const) or [**static**](/~rhowell/DataStructures/redirect/static-this). For example, while the following would be allowed in a class definition, it is not allowed in a structure definition:

```c#
    private int _rank = -1;
```

These fields are instead automatically initialized to the default values for their types. If you want to initialize a field to another value, you will need to use a constructor (but see the next restriction).

- All constructors must contain at least one parameter. There will always be a default constructor containing no parameters. It will initialize all non-**static**, non-**const** fields to the default values for their types.

- A field may not be defined to have same type as the structure containing it. For example, the following is not allowed:

```c#
public struct S
{
    private S _nextS;

}
```

For more information on structures, see the sections, "[Structs](http://msdn.microsoft.com/en-us/library/saxz13w4.aspx)" and "[Using Structs](http://msdn.microsoft.com/en-us/library/0taef578.aspx)" in the C\# Programming Guide.
