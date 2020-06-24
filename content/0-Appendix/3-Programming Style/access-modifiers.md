---
title: "Access Modifiers"
weight: 10
pre: "2. "
---

C# provides 4 access modifiers for classes, fields, etc.: **public**, **internal**, **protected**, and **private**. For simplicity, however, we will not allow the use of the **internal** or **protected** access modifiers.

When classes, fields, etc., are declared, C# does not require that an access modifier be used. If the access modifier is omitted, a default accessibility level will be used. However, the default depends on where it is being declared. For example, the default accessibility level of a top-level type is **internal**, whereas the default accessibility level of a class member is **private**. In order to avoid confusion, we will require that access modifiers (i.e., **public** or **private**) be used on all declarations except where C# does not allow them (C# does not allow access modifiers for namespaces, members of interfaces or enumerations, or local variables within methods). In particular, note that when Visual Studio® automatically generates a **class** statement, it does not always supply an access modifier. We require that **public** be explicitly inserted (C# does not allow **private** here).

In addition, fields within classes and structures should be declared **private**, unless they are also declared [**const**](/~rhowell/DataStructures/redirect/const). If you want to make a variable accessible to outside code, you can instead do something like the following:

```C#
private double _force;

public double Force
{
    get
    {
        return _force;
    }
    set
    {
        _force = value;
    }
}
```

In this example, `Force` is not a field, but a [property](/~rhowell/DataStructures/redirect/properties). It can be used just like a field, but when values are read from it, its **get** code is executed, and when values are written to it, its **set** code is executed, using the C# keyword **value** as the value to be written to it. (Note that either the **get** or **set** accessor may be omitted, in which case the property is write-only or read-only, respectively.) Though more wordy, this construct is more maintainable, as it allows the implementation to change without changing how it is used. For example, if we wanted to change the implementation so that the value represented is no longer stored, but instead is computed as the product of two other variables, `Mass` and `_acceleration`, we could change the definition of `Force` to

```C#
public double Force
{
    get
    {
        return Mass * _acceleration;
    }
    set
    {
        _acceleration = value / Mass;
    }
}
```
For more information on access modifiers and accessibility levels, see the section on [Accessibility Levels](http://msdn.microsoft.com/en-us/library/ba0a1yw2.aspx) in the [*C# Reference*](http://msdn.microsoft.com/en-us/library/618ayhy6.aspx).
