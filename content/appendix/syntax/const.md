+++
title = "Read-Only and Constant Fields"
date = 2018-08-24T10:53:05-05:00
weight = 50
chapter = true
pre = "<b>A1.5. </b>"

+++

## Read-Only and Constant Fields

Field declarations may contain one of the the keywords **readonly** or  **const** to indicate that these fields will always contain the same values. Such declarations are useful for defining a value that is to be used throughout a class or [structure](/appendix/syntax/structs) definition, or throughout an entire program. For example, we might define:

```C#
public class ConstantsExample
{
    public readonly int VerticalPadding = 12;

    private const string _humanPlayer = "X";

    . . .

}
```

Subsequently throughout the above class, the identifier `_humanPlayer` will refer to the string, "X". Because `VerticalPadding` is **public**, the `VerticalPadding` field of any instance of this **ConstantsExample** will contain the value 12 throughout the program. Such definitions are useful for various reasons, but perhaps the most important is that they make the program more maintainable. For example, `VerticalPadding` may represent some distance within a graphical layout. At some point in the lifetime of the software, it may be decided that this distance should be changed to 10 in order to give a more compact layout. Because we are using a **readonly** field rather than a literal 12 everywhere this distance is needed, we can make this change by simply changing the 12 in the above definition to 10.

When defining a **const** field, an initializer is required. The value assigned by the initializer must be a value that can be computed at compile time. For this reason, a constant field of a [reference type](/appendix/syntax/reference-value) can only be a **string** or **null**. The assigned value may be an expression, and this expression may contain other **const** fields, provided these definitions don't mutually depend on each other. Thus, for example, we could add the following to the above definition:
```C#
private const string _paddedHumanPlayer = " " + _humanPlayer + " ";
```
**const** fields may not be declared as [**static**](/appendix/syntax/static-this), as they are already implicitly **static**.

A **readonly** field differs from a **const** field mainly in that it is initialized at runtime, whereas a **const** field is initialized at compile time. This difference has several ramifications. First, a **readonly** field may be initialized in a constructor as an alternative to using an initializer. Second, a **readonly** field may be either **static** or non-**static**. These differences imply that in different instances of the same class or structure, a **readonly** field may have different values. 

One final difference between a **readonly** field and a **const** field is that a **readonly** field may be of any type and contain any value. Care must be taken, however, when defining a **readonly** reference type. For example, suppose we define the following:

```c#
private readonly string[] _names = { "Peter", "Paul", "Mary" };
```

Defining `_names` to be **readonly** guarantees that this field will always refer to the same array after its containing instance is constructed. However, it does *not* guarantee that the three array locations will always contain the same values. For this reason, the use of **readonly** for **public** fields of mutable reference types is discouraged.

**readonly** is preferred over **const** for a **public** field whose value may change later in the software lifecycle. If the value of a **public const** field is changed by a code revision, any code using that field will need to be recompiled to incorporate that change.
