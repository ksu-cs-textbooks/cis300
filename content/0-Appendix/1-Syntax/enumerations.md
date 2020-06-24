---
title: "Enumerations"
weight: 10
pre: "2. "
---

An *enumeration* is a [value type](/~rhowell/DataStructures/redirect/reference-value) containing a set of named constants. An example of an enumeration is [**DialogResult**](http://msdn.microsoft.com/en-us/library/system.windows.forms.dialogresult\(v=vs.110\).aspx) (see ["**MessageBox**es"](/~rhowell/DataStructures/redirect/message-boxes) and ["File Dialogs"](/~rhowell/DataStructures/redirect/file-dialogs)). The **DialogResult** type contains the following members:

- **DialogResult.Abort**
- **DialogResult.Cancel**
- **DialogResult.Ignore**
- **DialogResult.No**
- **DialogResult.None**
- **DialogResult.OK**
- **DialogResult.Retry**
- **DialogResult.Yes**

Each of the above members has a different constant value. In many cases, we are not interested in the specific value of a given member. Instead, we are often only interested in whether two expressions of this type have the same value. For example, the following code fragment is given in the ["**MessageBox**es"](/~rhowell/DataStructures/redirect/message-boxes) section: 

```C#
DialogResult result = MessageBox.Show("The file is not saved. Really quit?", "Confirm Quit", MessageBoxButtons.YesNo);
if (result == DialogResult.Yes)
{
    Application.Exit();
}
```

In the **if**-statement above, we are only interested in whether the user closed the **MessageBox** with the "Yes" button; i.e., we want to know whether the **Show** method returned the same value as **DialogResult.Yes**. For this purpose, we don't need to know anything about the value of **DialogResult.Yes** or any of the other **DialogResult** members.

However, there are times when it is useful to know that the values in an enumeration are always integers. Using a [cast](/~rhowell/DataStructures/redirect/casts), we can assign a member of an enumeration to an **int** variable or otherwise use it as we would an **int**; for example, after the code fragment above, we can write:

```C#
int i = (int)result;
```

As a more involved example, we can loop through the values of an enumeration:

```c#
for (DialogResult r = 0; (int)r < 8; r++)
{
    MessageBox.Show(r.ToString());
}
```

The above loop will display 8 **MessageBox**es in sequence, each displaying the name of a member of the enumeration (i.e., "None", "OK", etc.).

Variables of an enumeration type may be assigned any value of the enumeration's underlying type (usually **int**, as we will discuss below). For example, if we had used the condition `(int)r < 10` in the above **for** statement, the loop would continue two more iterations, showing 8 and 9 in the last two **MessageBox**es.

An enumeration is defined using an [**enum**](http://msdn.microsoft.com/en-us/library/sbbt4032.aspx) statement, which is similar to a **class** statement except that in the simplest case, the body of an **enum** is simply a listing of the members of the enumeration. For example, the **DialogResult** enumeration is defined as follows:

```C#
public enum DialogResult
{
    None, OK, Cancel, Abort, Retry, Ignore, Yes, No
}
```

This definition defines **DialogResult.None** as having the value 0, **DialogResult.OK** as having the value 1, etc.

As mentioned above, each enumeration has underlying type. By default, this type is **int**, but an **enum** statement may specify another underlying type, as follows:

```C#
public enum Beatles : byte
{
    John, Paul, George, Ringo
}
```

The above construct defines the underlying type for the enumeration **Beatles** to be **byte**; thus, a variable of type **Beatles** may be assigned any **byte** value. The following integer types may be used as underlying types for enumerations:

- **byte** (0 through 255)
- **sbyte** (-128 through 127)
- **short** (-32,768 through 32,767)
- **ushort** (0 through 65,535)
- **int** (-2,147,483,648 through 2,147,483,647)
- **uint** (0 through 4,294,967,295)
- **long** (-9,223,372,036,854,775,808 through 9,223,372,036,854,775,807)
- **ulong** (0 through 18,446,744,073,709,551,615)

It is also possible to define members of an enumeration so that they are not simply the values 0, 1, etc. For example, we might alter the **Beatles** enumeration as follows:

```C#
public enum Beatles : byte
{
    John = 1, Paul, George = 5, Ringo
}
```

This defines the following values for the members:

  - **Beatles.John**: 1
  - **Beatles.Paul**: 2
  - **Beatles.George**: 5
  - **Beatles.Ringo**: 6

Thus, if a value is explicitly assigned to a member, that member takes
on that value; otherwise, that member takes on the next value greater
than the previous member listed, or 0 if that member is the first
listed. Note that using this technique, it is possible to define two
members with the same value, although this is usually undesirable. If
assigning values in this way would lead to a value outside the range of
the underlying type, a syntax error results (for example, if **George**
were assigned 255 in the above definition).

One reason we might want to define explicit values for members of an
enumeration is if we want to use the members as flags. For example, one
of the
[**MessageBox.Show**](http://msdn.microsoft.com/en-us/library/ba3x8zfh\(v=vs.110\).aspx)
methods takes as one of its parameters a
[**MessageBoxOptions**](http://msdn.microsoft.com/en-us/library/system.windows.forms.messageboxoptions\(v=vs.110\).aspx),
which is an enumeration containing the following members:

  - **MessageBoxOptions.DefaultDesktopOnly**
  - **MessageBoxOptions.RightAlign**
  - **MessageBoxOptions.RtlReading**
  - **MessageBoxOptions.ServiceNotification**

The meaning of each of these members is unimportant for the purposes of
this discussion. The point is that the values of these members are
chosen in such a way that more than one of them can be combined into a
single value. The way this is done is to define each member as a
different power of 2. The binary representation of a power of 2 contains
exactly one bit with a value of 1. Thus, these values can be combined
using a *logical OR* operator, and the original values can be retrieved
using a *logical AND* operator.

For example, suppose the **MessageBoxOptions** enumeration is defined as
follows:

    public enum MessageBoxOptions
    {
        DefaultDesktopOnly = 1,
        RightAlign = 2,
        RtlReading = 4,
        ServiceNotification = 8
    }

(The definition in the .NET Framework uses different powers of 2, but
the priciple is the same.) Now suppose we want to create a
**MessageBox** that will be displayed on the default desktop with
right-aligned text. We can combine these options using the expression

    MessageBoxOptions.DefaultDesktopOnly | MessageBoxOptions.RightAlign

This expression combines corresponding bits of the two operands using a
logical OR. Recall that the logical OR of two bits is 1 if at least one
of the two bits is 1. If both operands are 0, the result is 0. In this
example, the operands have a 1 in different bit locations. When we
combine them using logical OR, both of these bit positions will contain
a 1:

    0000 0000 0000 0000 0000 0000 0000 0001
    0000 0000 0000 0000 0000 0000 0000 0010
    ---------------------------------------
    0000 0000 0000 0000 0000 0000 0000 0011

We can therefore specify both of these options to the **Show** method as
folows:

    MessageBox.Show("Hello\nworld!", "Hello", MessageBoxButtons.OK,
        MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, 
        MessageBoxOptions.DefaultDesktopOnly |
        MessageBoxOptions.RightAlign);

The `\n` in the above example specifies the end of a line; hence,
"Hello" and "world\!" will be displayed on separate lines, aligned on
the right:

![A picture of a dialog should appear here.](message-box-options.jpg)

The **Show** method determines which bits are 1 in the
**MessageBoxOptions** parameter using a logical AND. Recall that a
logical AND of two bits is 1 only if both bits are 1. In all othercases,
the result is 0. Suppose, then, that `options` is a
**MessageBoxOptions** variable with an unknown value. Because each named
member of the **MessageBoxOptions** enumeration (e.g.,
**MessageBoxOptions.RightAlign**) has exactly one bit with a value of 1,
an expression like

    options & MessageBoxOptions.RightAlign

can have only two possible values:

  - If the bit position containing the 1 in
    **MessageBoxOptions.RightAlign** also contains a 1 in `options`,
    then the expression's value is **MessageBoxOptions.RightAlign**.
  - Otherwise, the expression's value is 0.

Thus, the **Show** method can use code like:

    if ((options & MessageBoxOptions.RightAlign) == MessageBoxOptions.RightAlign)
    {
        // Code to right-align the text
    }
    else
    {
        // Code to left-align the text
    }

Defining enumerations to be used as flags in this way can be made easier
by writing the powers of 2 in hexadecimal, or base 16. Each hex digit
contains one of 16 possible values: the ten digits 0-9 or the six
letters a-f (in either lower or upper case). A hex digit is exactly four
bits; hence, the hex values containing one occurrence of either 1, 2, 4,
or 8, with all other digits 0, are exactly the powers of 2. To write a
number in hex in a C\# program, start with `0x`, then give the hex
digits. For example, we can define the following enumeration to
represent the positions a baseball player is capable of playing:

    public enum Positions
    {
        Pitcher = 0x1,
        Catcher = 0x2,
        FirstBase = 0x4,
        SecondBase = 0x8,
        ThirdBase = 0x10,
        Shortstop = 0x20,
        LeftField = 0x40,
        CenterField = 0x80,
        RightField = 0x100
    }

We can then encode that a player is capable of playing 1st base, left
field, center field, or right field with the expression:

    Positions.FirstBase | Positions.LeftField | Positions.CenterField | Positions.RightField

This expression would give a value having four bit positions containing
1:

    0000 0000 0000 0000 0000 0001 1100 0100

For more information on enumerations, see the section,
[enum](http://msdn.microsoft.com/en-us/library/sbbt4032.aspx) in the
*C\# Reference* and the section [Enumeration
Types](http://msdn.microsoft.com/en-us/library/cc138362.aspx) in the
*C\# Programming Guide*.
