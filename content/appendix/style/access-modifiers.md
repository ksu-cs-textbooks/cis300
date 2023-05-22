+++
title = "Access Modifiers"
weight = 20

pre = "<b>A3.2. </b>"
+++

## Access Modifiers

C# provides 4 access modifiers for classes, fields, etc.: **public**, **internal**, **protected**, and **private**. For simplicity, however, we will not allow the use of the **internal** or **protected** access modifiers unless they are required by the compiler (for example, when overriding a **protected** method).

When classes, fields, etc., are declared, C# does not require that an access modifier be used. If the access modifier is omitted, a default accessibility level will be used. However, the default depends on where it is being declared. For example, the default accessibility level of a top-level type is **internal**, whereas the default accessibility level of a class member is **private**. In order to avoid confusion, we will require that access modifiers (i.e., **public** or **private**) be used on all declarations except where C# does not allow them (C# does not allow access modifiers for namespaces, members of interfaces or enumerations, or local variables within methods). In particular, note that when Visual Studio® automatically generates a **class** statement, it does not always supply an access modifier. We require that **public** be explicitly inserted (C# does not allow **private** here).

In addition, fields within classes and structures should be declared **private**, unless they are also declared either [**const**](/appendix/syntax/const) or [**readonly**](/appendix/syntax/const). If you want to make a variable accessible to outside code, you can instead do something like the following:
```C#
public double Force { get; set; }
```
Or if you want the outside code to be able to access it, but you don't
want it to change its value you can instead define it as:
```C#
public double Force { get; private set; }
```
In these examples, `Force` is not a field, but a [property](/appendix/syntax/properties). It can be used like a field, but defining it as a property makes it more maintainable (see ["Properties"](/appendix/syntax/properties) for more details).

{{% notice warning %}}

Don't define a **private** property when a **private** field will accomplish the same thing - using a **private** field with the appropriate [naming convention](/appendix/style/naming/) makes the code more readable.

{{% /notice %}}

For more information on access modifiers and accessibility levels, see the section on [Accessibility Levels](http://msdn.microsoft.com/en-us/library/ba0a1yw2.aspx) in the [*C# Reference*](http://msdn.microsoft.com/en-us/library/618ayhy6.aspx).
