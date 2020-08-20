+++
title = "Introduction to Stacks"
date = 2018-08-24T10:53:05-05:00
weight = 10
chapter = true
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

The .NET Framework provides two kinds of stacks. One is the
[**Stack**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.stack?view=netframework-4.7.2)
class found in the
[**System.Collections**](https://docs.microsoft.com/en-us/dotnet/api/system.collections?view=netframework-4.7.2)
namespace. This class provides a stack of **object**s. Because every
type in C\# is a subtype of **object**, we can push any data items we
want onto a **Stack**. The most commonly-used **public** members of this
class are:

  - A
    [constructor](https://docs.microsoft.com/en-us/dotnet/api/system.collections.stack.-ctor?view=netframework-4.7.2#System_Collections_Stack__ctor)
    that takes no parameters and constructs an empty stack.
  - A
    [**Count**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.stack.count?view=netframework-4.7.2)
    property, which gets the number of elements on the **Stack** as an
    **int**.
  - A
    [**Push**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.stack.push?view=netframework-4.7.2)
    method, which takes a single parameter of type **object**, and
    pushes it onto the top of the **Stack**.
  - A
    [**Peek**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.stack.peek?view=netframework-4.7.2)
    method, which takes no parameters and returns the element at the top
    of the **Stack** (as an **object**) without changing the **Stack**'s
    contents. If the **Stack** is empty, this method throws an
    **InvalidOperationException**.
  - A
    [**Pop**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.stack.pop?view=netframework-4.7.2)
    method, which takes no parameters, and removes and returns the
    element at the top of the **Stack** (as an **object**). If the
    **Stack** is empty, this method throws an
    **InvalidOperationException**.

As we mentioned above, because the **Push** method takes an **object**
as its parameter, we can push any data elements we want onto a
**Stack**. What this means, however, is that the compiler can't
determine the type of these elements when we retrieve them; i.e., both
the **Peek** and **Pop** methods return **object**s. Thus, for example,
the following code will not compile:
```C#
Stack s = new Stack();
s.Push(7);
int n = s.Pop() + 1;
```
The problem is that the **Pop** method returns an **object**, and we
can't add an **int** to an **object**. Although it's pretty easy to see
from this code that **Pop** will return 7, in many cases it's impossible
to know at compile time the exact type of the element returned (for
example, the **Stack** may be a parameter to a method, and that method
may be called by code that has not yet been written). Consequently, the
compiler simply uses the return type of **Pop** - it doesn't even try to
figure out the type any more precisely.

<span id="cast"></span> If you want to use the value returned by **Pop**
or **Peek** as something other than an **object**, you need to tell the
compiler what its type actually is. You do this with a *cast*:
```C#
int n = (int)s.Pop() + 1;
```
This tells the compiler to assume that the value returned by **Pop** is
an **int**. The type is still checked, but now it is checked at run
time, rather than at compile time. If the runtime environment detects
that the value is not, in fact, an **int** it will throw an
**InvalidCastException**.

<span id="generic"></span> Often when we need a stack, the data items
that we wish to store are all of the same type. In such a case, it is
rather awkward to include a cast whenever we retrieve an item from the
stack. In order to avoid this casting, the .NET Framework provides a
*generic* stack,
[**Stack\<T\>**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.stack-1?view=netframework-4.7.2),
found in the
[**System.Collections.Generic**](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic?view=netframework-4.7.2)
namespace. The **T** within angle brackets is a *type parameter* - we
may replace it with any type we want. This type tells what type of
elements may be placed in this stack. For example, if we want a stack
that will only contain **int**s, we can write:
```C#
Stack<int> s = new Stack<int>();
```
This class has members similar to those listed above for the non-generic
**Stack** class, except that the **Push** method takes a parameter of
type **T** (i.e., whatever type we placed within the angle brackets in
the type declaration and constructor call), and the **Peek** and **Pop**
methods each return a value of type **T**. As a result, the following is
now legal code:
```C#
Stack<int> s = new Stack<int>();
s.Push(7);
int n = s.Pop() + 1;
```
We will show how you can define your own generic types in "[Implementing
a Stack](/stacks-queues/stack-impl)". First, however,
we want to work through two example applications of stacks. We will do
that in the next two sections.
