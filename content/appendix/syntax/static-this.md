+++
title = "The Keywords static and this"
weight = 80

pre = "<b>A1.8. </b>"
+++

## The Keywords **static** and **this**

Object-oriented programming languages such as C# are centered on the concept of an object. Class and structure definitions give instructions for constructing individual objects of various types, normally by using the **new** keyword. When an object is constructed, it has its own fields in which values may be stored. Specifically, if type **T** has an **int** field called `_length`, then each object of type **T** will have have such a field, and each of these fields may store a different **int**. Thus, for example, if `x` and `y` are instances of type **T**, then `x._length` may contain 7, while `y._length` may contain 12.

Likewise, we can think of each object as having its own methods and properties, as when any of these methods or properties use the fields of the containing class or structure, they will access the fields belonging to a specific object. For example, if type **T** contains an **Add** method that changes the value stored in the `_length` filed, then a call **x.Add** will potentially change the value stored in `x._length`.

However, there are times when we want to define a field, method, or property, but we don't want it associated with any specific object. For example, suppose we want to define a unique **long** value for each instance of some class **C**. We can define a **private long** field `_id` within this class and give it a value within its constructor. But how do we get this value in a way that ensures that it is unique? One way is to define a **private static long** field `_nextId`, as in the following code:

```c#
public class C
{
    private static long _nextId = 0;

    private long _id;

    public C()
    {
        _id = _nextId;
        _nextId++;
    }

    // Other members could also be defined.
}
```

By defining `_nextId` to be **static**, we are specifying that each instance of **C** will not contain a `_nextId` field, but instead, there is a single `_nextId` field belonging to the entire class. As a result, code belonging to any instance of **C** can access this one field. Thus, each time an instance of **C** is constructed, this one field is incremented. This field therefore acts as a counter that keeps track of how many instances of **C** have been constructed. On the other hand, because `_id` is not **static**, each instance of **C** contains an `_id` field. Thus, when the assignment,

```c#
_id = _nextId;
```

is done, the value in the single `_nextId` field is copied to the value of the `_id` field belonging to the instance being constructed. Because the single `_nextId` field is incremented every time a new instance of **C** is constructed, each instance receives a different value for `_id`.

We can also define **static** methods or properties. For example, the [**MessageBox.Show(string text)**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.messagebox.show?view=windowsdesktop-6.0#system-windows-messagebox-show(system-string)) method is **static**. Because it is **static**, we don't need a **MessageBox** object in order to call this method - we simply call something like:

```c#
MessageBox.Show("Hello world!");
```

**static** methods can also be useful for avoiding **NullReferenceException**s. For example, there are times when we want to determine whether a variable `x` contains **null**, but `x` is of an unknown type (perhaps its type is defined by some [type parameter](/stacks-queues/stacks/#generic) **T**). In such a case, we cannot use == to make the comparison because == is not defined for all types. Furthermore, the following will never work:

```c#
if (x.Equals(null))
{

}
```

Such code will compile, but if `x` is **null**, then calling its **Equals** method will throw a **NullReferenceException**. In all other cases, the **if**-condition will evaluate to **false**. Fortunately, a [**static Equals**](https://learn.microsoft.com/en-us/dotnet/api/system.object.equals?view=net-6.0#system-object-equals(system-object-system-object)) method is available to handle this situation:

```C#
if (Equals(x, null))
{

}
```

Because this method is defined within the **object** class, which is a supertype of every other type in C#, we can refer to this method without specifying the containing class, just as if we had defined it in the class or structure we are writing. Because this method does not belong to individual objects, we don't need any specific object available in order to call it. It therefore avoids a **NullReferenceException**.

Because a **static** method or property does not belong to any instance of its type, it cannot access any non-**static** members directly, as they all belong to specific instances of the type. If however, the code has access to a specific instance of the type (for example, this instance might be passed as a parameter), the code may reference non-**static** members of that instance. For example, suppose we were to add to the class **C** above a method such as:

```c#
public static int DoSomething(C x)
{

}
```

Code inside this method would be able to access `_nextID`, but not `_id`. Furthermore, it would be able to access any **static** methods or properties contained in the class definition, as well as all constructors, but no non-**static** methods or properties. However, it may access `x._id`, as well as any other members of `x`.

Code within a constructor or a non-**static** method or property can also access the object that contains it by using the keyword **this**. Thus, in the constructor code above, we could have written the line

```c#
_id = _nextId;
```

as

```C#
this._id = _nextId;
```

In fact, the way we originally wrote the code is simply an abbreviation of the above line. Another way of thinking of the restrictions on code within a **static** method or property is that this code cannot use **this**, either explicitly or implicitly.
