+++
title = "Equality in C#"
weight = 40

pre = "<b>7.4. </b>"
+++

## Equality in C#

Continuing our discussion from [the previous
section](/hashing/memoization), we want to
define a type that represents a Nim board. Furthermore, we need to be
able to compare instances of this type for equality. Before we can
address how this can be done, we first need to take a careful look at
how C# handles equality. In what follows, we will discuss how C#
handles the `==` operator, the non-**static** **Equals** method, and two
**static** methods for determining equality. We will then show how the
comparison can be defined so that all of these mechanisms behave in a
consistent way.

We first consider the `==` operator. The behavior of this operator is
determined by the *compile-time* types of its operands. This is
determined by the declared types of variables, the declared return types
of methods or properties, and the rules for evaluating expressions.
Thus, for example, if we have a statement

```C#
object x = "abc";
```

the compile-time type of `x` is **object**, even though it actually
refers to a **string**.

For pre-defined [value
types](/appendix/syntax/reference-value), `==` evaluates
to **true** if its operands contain the same values. Because
[enumerations](/appendix/syntax/enumerations) are
represented as numeric types such as **int** or **byte**, this rule
applies to them as well. For user-defined structures, `==` is undefined
unless the structure definition explicitly defines the `==` and `!=`
operators. We will show how this can be done below.

By default, when `==` is applied to reference types, it evaluates to
**true** when the two operands refer to the same object (i.e., they
refer to the same memory location). A class may override this behavior
by explicitly defining the `==` and `!=` operators. For example, the
**string** class defines the `==` operator to evaluate to **true** if the
given **string**s are the same length and contain the same sequence of
characters.

Let's consider an example that illustrates the rules for reference
types:

```c#
string a = "abc";
string b = "0abc".Substring(1);
object x = a;
object y = b;
bool comp1 = a == b;
bool comp2 = x == y;
```

The first two lines assign to `a` and `b` the same sequence of
characters; however, because the **string**s are computed differently,
they are different objects. The next two lines copy the reference in `a`
to `x` and the reference in `b` to `y`. Thus, at this point, all four
variables refer to a **string** "abc"; however, `a` and `x` refer to a
different object than do `b` and `y`. The fifth line compares `a` and
`b` for equality using `==`. The compile-time types of `a` and `b` are
both **string**; hence, these variables are compared using the rules for
comparing **string**s. Because they refer to **string**s of the same
length and containing the same sequence of characters, `comp1` is
assigned **true**. The behavior of the last line is determined by the
compile-time types of `x` and `y`. These types are both **object**,
which defines the default behavior of this operator for reference types.
Thus, the comparison determines whether the two variables refer to the
same object. Because they do not, `comp2` is assigned **false**.

Now let's consider the non-**static** **Equals** method. The biggest
difference between this method and the `==` operator is that the behavior
of `x.Equals(y)` is determined by the *run-time* type of `x`. This is
determined by the actual type of the object, independent of how any
variables or return types are declared.

By default, if `x` is a value type and `y` can be treated as having the
same type, then `x.Equals(y)` returns **true** if `x` and `y` have the
same value (if `y` can't be treated as having the same type as `x`, then
this method returns **false**). Thus, for pre-defined value types, the
behavior is the same as for `==` once the types are determined (provided
the types are consistent). However, the **Equals** method is always
defined, whereas the `==` operator may not be. Furthermore, structures may
*override* this method to change this behavior --- we will show how to do
this below.

By default, if `x` is a reference type, `x.Equals(y)` returns **true**
if `x` and `y` refer to the same object. Hence, this behavior is the
same as for `==` once the types are determined (except that if `x` is
**null**, `x.Equals(y)` will throw a **NullReferenceException**,
whereas `x == y` will not). However, classes may override this
method to change this behavior. For example, the **string** class
overrides this method to return **true** if `y` is a **string** of the
same length and contains the same sequence of characters as `x`.

Let's now continue the above example by adding the following lines:

```c#
bool comp3 = a.Equals(b);
bool comp4 = a.Equals(x);
bool comp5 = x.Equals(a);
bool comp6 = x.Equals(y);
```

These all evaluate to **true** for one simple reason --- the behavior is
determined by the run-time type of `a` in the case of the first two
lines, or of `x` in the case of the last two lines. Because these types
are both **string**, the objects are compared as **string**s. 

{{% notice note %}}
It's actually a bit more complicated in the case of `comp3`, but we'll explain
this later.

{{% /notice %}}

The **object** class defines, in addition to the **Equals** method
described above, two **public static** methods, which are in turn
inherited by every type in C#:

  - **bool Equals(object x, object y)**: The main purpose of this method
    is to avoid the **NullReferenceException** that is thrown by
    `x.Equals(y)` when `x` is **null**. If neither `x` nor `y` is
    **null**, this method simply returns the value of `x.Equals(y)`.
    Otherwise, it will return **true** if both `x` and `y` are **null**, or **false** if only one is **null**.
    User-defined types cannot override this method, but because it calls
    the non-**static Equals** method, which they can override, they can
    affect its behavior indirectly.
  - **bool ReferenceEquals(object x, object y)**: This method returns
    **true** if `x` and `y` refer to the same object or are both
    **null**. If either `x` or `y` is a value type, it will return
    **false**. User-defined types cannot override this method.

Finally, there is nothing to prevent user-defined types from including
their own **Equals** methods with different parameter lists. In fact,
the **string** class includes definitions of the following **public**
methods:

  - **bool Equals(string s)**: This method actually does the same thing
    as the non-**static** **Equals** method defined in the **object**
    class, but is slightly more efficient because less run-time type
    checking needs to be done. This is the method that is called in the
    computation of `comp3` in the above example.
  - **static bool Equals(string x, string y)**: This method does the
    same thing as the **static Equals** method defined in the **object**
    class, but again is slightly more efficient because less run-time
    type checking needs to be done.

All of this can be rather daunting at first. Fortunately, in most cases
these comparisons end up working the way we expect them to. The main
thing we want to focus on here is how to define equality properly in a
user-defined type.

<span id="operator-overloading"></span> Let's start with the `==`
operator. This is one of several operators that may be defined within
class and structure definitions. If we are defining a class or structure
called **SomeType**, we can include a definition of the `==` operator as
follows:

```c#
public static bool operator ==(SomeType x, SomeType y)
{
    // Definition of the behavior of ==
}
```

Note the resemblance to the definition of a **static** method. Even
though we define it using the syntax for a method definition, we still
use it as we typically use the `==` operator; e.g.,

```c#
if (a == b)
{
    . . .
}
```

If `a` and `b` are both of type **SomeType**, the above definition will
be called using `a` as the parameter `x` and `b` as the parameter `y`.

Within the operator definition, if it is within a class definition, the
first thing we need to do is to handle the cases in which one or both
parameters are **null**. We don't need to do this for a structure
definition because value types can't be **null**, but if we omit this
part for a reference type, comparing a variable or expression of this
type to **null** will most likely result in a
**NullReferenceException**. We need to be a bit careful here, because if
we use `==` to compare one of the parameters to **null** it will be a
recursive call --- infinite recursion, in fact. Furthermore, using
`x.Equals(null)` is always a bad idea, as if `x` does, in fact, equal
**null**, this will throw a **NullReferenceException**. We therefore
need to use one of the **static** methods, **Equals** or
**ReferenceEquals**:

```c#
public static bool operator ==(SomeType x, SomeType y)
{
    if (Equals(x, null))
    {
         return (Equals(y, null));
    }
    else if (Equals(y, null))
    {
        return false;
    }
    else
    {
        // Code to determine if x == y
    }
}
```

Note that because all three calls to **Equals** have **null** as a
parameter, these calls won't result in calling the **Equals** method
that we will override below.

Whenever we define the `==` operator, C# requires that we also define the
`!=` operator. In virtually all cases, what we want this operator to do
is to return the negation of what the `==` operator does:

```c#
public static bool operator !=(SomeType x, SomeType y)
{
    return !(x == y);
}
```

We now turn to the (non-**static**) **Equals** method. This is defined
in the **object** class to be a **virtual** method, meaning that
sub-types are allowed to
[override](/strings/stringbuilder-impl/#overriding) its
behavior. Because every type in C# is a subtype of **object**, this
method is present in every type, and it can be overridden by any class
or structure.

We override this method as follows:

```c#
public override bool Equals(object obj)
{
    // Definition of the behavior of Equals
}
```

For the body of the method, we first need to take care of the fact that
the parameter is of type **object**; hence, it may not even have the
same type as what we want to compare it to. If this is the case, we can
immediately return **false**. Otherwise, in order to ensure consistency
between this method and the `==` operator, we can do the actual comparison
using the `==` operator:

```c#
public override bool Equals(object obj)
{
    if (obj is SomeType)
    {
        return this == (SomeType)obj;
    }
    else
    {
        return false;
    }
}
```

The above definitions give a template for defining the `==` and `!=`
operators and the non-**static Equals** method for most classes that we
would want to compare for equality. For structures, we can remove the
code that handles **null** parameters from the `==` definition. In either
case, all we then need to do to complete the definitions is to replace
the name **SomeType**, wherever it occurs, with the name of the type we
are defining, and to fill in the hole left in the definition of the `==`
operator. It is here where we actually define how the comparison is to
be made.

Suppose, for example, that we want to define a class to represent a Nim
board position (see the [previous
section](/hashing/memoization)). This class
will need to have two **private** fields: an **int\[ \]** storing the
number of stones on each pile and an **int\[ \]** storing the limit
for each pile. These two arrays should be non-**null** and have the same
length, but this should be enforced by the constructor. By default, two
instances of a class are considered to be equal (by either the `==`
operator or the non-**static Equals** method) if they are the same
object. This is too strong for our purposes; instead, two instances `x`
and `y` of the board position class should be considered equal if

  - Their arrays giving the number of stones on each pile have the same
    length; and
  - For each index`i` into the arrays giving the number of stones on
    each pile, the elements at location `i` of these arrays have the
    same value, and the elements at location `i` of the arrays giving
    the limit for each pile have the same value.

Code to make this determination and return the result can be inserted
into the above template defining of the `==` operator, and the other two
templates can be customized to refer to this type.

Any class that redefines equality should also redefine the hash code
computation to be consistent with the equality definition. We will show
how to do this in the next section.
