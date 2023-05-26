+++
title = "Naming Conventions"
weight = 30

pre = "<b>A3.3. </b>"
+++

## Naming Conventions

The naming conventions described below use the following terminology:
- **Pascal case:** Multiple words are joined without spaces, using
capital letters at the beginning of each word. If acronyms of 3 or
more letters are included, only the first letter of the acronym is
capitalized. For example, `AverageAge`, `ContextBoundObject`, `RgbCode`.
- **Camel case:** The same as pascal case, except the first letter is
not capitalized. For example, `averageAge`, `contextBoundObject`,
`rgbCode`.

### Namespaces

In CIS 300 programming assignments, namespace names will typically be provided. They will use the form `Ksu.Cis300.ProgramName`, where each of the 3 components is in pascal case. For example:

```C#
namespace Ksu.Cis300.Spreadsheet
{

}
```

### Classes, Structures, and Enumerations

Use pascal case. If the name begins with "I", the following letter must not be capitalized, as this would look like an interface - see below. For an exception class, append the word "Exception". Make your names descriptive nouns or noun phrases without abbreviations (common abbreviations like "Min" are allowed). For example:

```c#
public class AccountManager
{

}
```

### [Interfaces](/trees/tries/multiple-impl)

Use the convention for a class name with a capital "I" preceding the first letter (which must also be capitalized). For example:

```c#
public interface IPriorityQueue
{

}
```

### Methods

Use pascal case. Make your names descriptive without abbreviations (common abbreviations like "Min" are allowed). For example:

```c#
private void InitializeComponent()
{

}
```

{{% notice warning %}}
Automatically-generated event handlers don't follow this convention. For example, suppose you generate a Click event handler by double-clicking a **Button** named `uxUpdate`. The event handler generated will then be given a name of **uxUpdate_Click**. You will need to rename it to **UpdateClick**. Be sure to use [Visual Studio's Rename feature](/appendix/vs/code-window/#renaming), as this name will also need to be changed in automatically-generated code that you normally won't edit.
{{% /notice %}}

### [Properties](/appendix/syntax/properties)

Use pascal case. Make your names descriptive without abbreviations (common abbreviations are allowed). For example:

```c#
public int Count { get; private set; }
```

### Controls on Forms

Use camel case, and begin names with "ux" followed by a capital letter
(this "ux" stands for "user experience"). Make your names descriptive
of the functionality, not the type of control. For example,
`uxAccept`, `uxCustomerName`. 

{{% notice note %}}
You will not typically declare these names in code, but will enter
them in the Visual Studio® design window.
{{% /notice %}}

### **public** [Constants](/appendix/syntax/const) (const or readonly)

Use pascal case. Make your names descriptive. For example:

```c#
public const double GravitationalAcceleration = 9.80665;
```

### **private** Fields

Use camel case with an underscore character preceding the first letter. For example:

```c#
private double _weight;
```

This applies to all **private** fields, including those defined as **const** or **readonly**.

### Parameters and Local Variables Within Methods

Use camel case. For example, `inString` and `outString` in the
following code:

```c#
public string ToMixedCase(string inString)
{
    string outString;
    // code here
    return outString;
}
```
