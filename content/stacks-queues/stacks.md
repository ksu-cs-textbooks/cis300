+++
title = "Introduction to Stacks"
weight = 10

pre = "<b>3.1. </b>"
+++

## Introduction to Stacks

A *stack* provides last-in-first-out (LIFO) access to data items. We
usually think of a stack as arranging data items vertically, like a
stack of trays in a cafeteria. Access is normally provided only at the
top of the stack; hence, if we want to add an item, we *push* it onto
the top, and if we want to remove an item, we *pop* it from the top.
Because we only access the top of the stack, the item that we pop is
always the remaining item that we had pushed the most recently.

.NET provides two kinds of stacks. One is the
[**Stack**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.stack?view=net-6.0)
class found in the
[**System.Collections**](https://learn.microsoft.com/en-us/dotnet/api/system.collections?view=net-6.0)
namespace. Because this namespace isn't typically included in the list of namespaces searched by the compiler, but the namespace containing the other **Stack** definition (discussed a bit later below) is included, we need to refer to it in code as **System.Collections.Stack**. This class provides a stack of <strong>object?</strong>s. Because every
type in C\# is a subtype of **object**, we can push any data items we
want onto a **Stack**. Because **object?** is a [nullable](/appendix/syntax/reference-value#nullable-types) type, we can even push **null**. The most commonly-used **public** members of this
class are:

  - A
    [constructor](https://learn.microsoft.com/en-us/dotnet/api/system.collections.stack.-ctor?view=net-6.0#system-collections-stack-ctor)
    that takes no parameters and constructs an empty stack.
  - A
    [**Count**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.stack.count?view=net-6.0#system-collections-stack-count)
    property, which gets the number of elements on the **Stack** as an
    **int**.
  - A
    [**Push**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.stack.push?view=net-6.0#system-collections-stack-push(system-object))
    method, which takes a single parameter of type **object?**, and
    pushes it onto the top of the **Stack**.
  - A
    [**Peek**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.stack.peek?view=net-6.0#system-collections-stack-peek)
    method, which takes no parameters and returns the element at the top
    of the **Stack** (as an **object?**) without changing the **Stack**'s
    contents. If the **Stack** is empty, this method throws an
    **InvalidOperationException**.
  - A
    [**Pop**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.stack.pop?view=net-6.0#system-collections-stack-pop)
    method, which takes no parameters, and removes and returns the
    element at the top of the **Stack** (as an **object?**). If the
    **Stack** is empty, this method throws an
    **InvalidOperationException**.

As we mentioned above, because the **Push** method takes an **object?**
as its parameter, we can push any data elements we want, including **null**, onto a
**Stack**. What this means, however, is that the compiler can't
determine the type of these elements when we retrieve them; i.e., both
the **Peek** and **Pop** methods return <strong>object?</strong>s. Thus, for example,
the following code will not compile:

```C#
System.Collections.Stack s = new();
s.Push(7);
int n = s.Pop() + 1;
```
The problem is that the **Pop** method returns an **object?**, and we
can't add an **int** to an **object?**. Although it's pretty easy to see
from this code that **Pop** will return 7, in many cases it's impossible
to know at compile time the exact type of the element returned (for
example, the **Stack** may be a parameter to a **public** method, and that method
may be called by code that has not yet been written). Consequently, the
compiler simply uses the return type of **Pop** - it doesn't even try to
figure out the type any more precisely.

<span id="cast"></span> If you want to use the value returned by **Pop**
or **Peek** as something other than an **object?**, you need to tell the
compiler what its type actually is. You do this with a *cast*:

```C#
int n = (int)s.Pop() + 1;
```
This tells the compiler to assume that the value returned by **Pop** is
an **int**. The type is still checked, but now it is checked at run
time, rather than at compile time. If the runtime environment detects
that the value is not, in fact, an **int**, it will throw an
**InvalidCastException**.

While the above line of code will now compile, it generates a warning because **Pop** might return **null**, which cannot be cast to **int**. In order to avoid this warning, once we have determined that the call won't return a **null** value, we need to use the `!` operator:

```C#
// The element on the top of the stack is the int 7
int n = (int)s.Pop()! + 1;
```

Note that we include a comment explaining why **Pop** won't return **null** here.

<span id="generic"></span> Often when we need a stack, the data items
that we wish to store are all of the same type. In such a case, it is
rather awkward to include a cast whenever we retrieve an item from the
stack. In order to avoid this casting, .NET provides a
*generic* stack,
[**Stack\<T\>**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.stack-1?view=net-6.0),
found in the
[**System.Collections.Generic**](https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic?view=net-6.0)
namespace. The **T** within angle brackets is a *type parameter* - we
may replace it with any type we want. This type tells what type of
elements may be placed in this stack. For example, if we want a stack
that will only contain **int**s, we can write:

```C#
Stack<int> s = new();
```
This class has members similar to those listed above for the non-generic
**Stack** class, except that the **Push** method takes a parameter of
type **T** (i.e., whatever type we placed within the angle brackets in
the type declaration and constructor call), and the **Peek** and **Pop**
methods each return a value of type **T**. As a result, the following is
now legal code:
```C#
Stack<int> s = new();
s.Push(7);
int n = s.Pop() + 1;
```
We will show how you can define your own generic types in "[Implementing
a Stack](/stacks-queues/stack-impl)". First, however,
we want to work through two example applications of stacks. We will do
that in the next two sections.
