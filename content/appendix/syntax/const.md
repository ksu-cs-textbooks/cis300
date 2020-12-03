+++
title = "Constant Fields"
date = 2018-08-24T10:53:05-05:00
weight = 50
chapter = true
pre = "<b>A1.5. </b>"
+++

## Constant Fields

Field declarations may contain the keyword **const** to indicate that these fields will always contain the same values. Such declarations are useful for defining a value that is to be used throughout a class or [structure](/appendix/syntax/structs) definition, or throughout an entire program. For example, we might define:
```C#
public class ConstantsExample
{
    public const int VerticalPadding = 12;

    private const string _humanPlayer = "X";

    . . .

}
```

Subsequently throughout the above class, the identifier <tt>_humanPlayer</tt> will refer to the string, "X". Because <tt>VerticalPadding</tt> is **public**, **ConstantsExample.VerticalPadding** will contain the value 12 throughout the program. Such defintions are useful for various reasons, but perhaps the most important is that they make the program more maintainable. For example, **ConstantsExample.VerticalPadding** may represent some distance within a graphical layout. At some point in the lifetime of the software, it may be decided that this distance should be chaged to 10 in order to give a more compact layout. Because we are using a constant field rather than a literal 12 everywhere this distance is needed, we can make this change by simply changing the 12 in the above definition to 10.

When defining a constant field, an initializer is required. The value assigned by the initializer must be a value that can be computed at compile time. For this reason, the only values that a constant field of a [reference type](/appendix/syntax/reference-value) can be are a **string** or **null**. The assigned value may be an expression, and this expression may contain other constant fields, provided these definitions don't mutually depend on each other. Thus, for example, we could add the following to the above definition:
```C#
public const int HorizontalPadding = VerticalPadding / 2;
```
Constant fields may not be declared as [**static**](/appendix/syntax/static-this), as they are already implicitly **static**.

