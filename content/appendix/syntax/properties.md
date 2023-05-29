+++
title = "Properties"
weight = 60

pre = "<b>A1.6. </b>"
+++

## Properties

A property is used syntactically like a field of a class or structure,
but provides greater flexibility in implementation. For example, the
**string** class contains a **public** property called
[**Length**](https://learn.microsoft.com/en-us/dotnet/api/system.string.length?view=net-6.0). This
property is accessed in code much as if it were a **public int**
field; i.e., if `s` is a **string** variable, we can access its
**Length** property with the expression `s.Length`,
which evaluates to an **int**. If **Length** were a **public int** field, we would access it in just the same way. However, it turns out that we cannot assign a value to this property, as we can to a **public** field; i.e., the statement,

```C#
s.Length = 0;
```

is not allowed. The reason for this limitation is that properties can be defined to restrict whether they can be read from or written to. The **Length** property is defined so that it can be read from, but not written to. This flexibility is one of the two main differences between a field and a property. The other main difference has to do with maintainability and is therefore easier to understand once we see how to define a property.

Suppose we wish to provide full read/write access to a **double** value. Rather than defining a **public double** field, we can define a simple **double** property as follows:

```C#
public double X { get; set; }
```

This property then functions just like a **public** field - the **get** keyword allows code to read from the property, and the **set** keyword allows code to write to the property. A property definition requires at least one of these keywords, but one of them may be omitted to define a read-only property (if **set** is omitted) or a write-only property (if **get** is omitted). For example, the following defines **X** to be a read-only property:

```C#
public double X { get; }
```

Although this property is read-only, the constructor for the class or structure containing this definition is allowed to initialize it. Sometimes, however we want certain methods of the containing class or structure to be able to modify the property's value without allowing user code to do so. To accomplish this, We can define **X** in this way:

```C#
public double X { get; private set; }
```

The above examples are the simplest ways to define properties. They all rely on the *default implementation* of the property. Unlike a field, the name of the property is not actually a variable; instead, there is a *hidden* variable that is automatically defined. The only way this hidden variable can be accessed is through the property.

{{% notice warning %}}

Don't define a **private** property using the default implementation. Use a **private** field instead.

{{% /notice %}}

The distinction between a property and its hidden variable may seem artificial at first. However, the real flexibility of a property is revealed by the fact that we can define our own implementation, rather than relying on the default implementation. For example, suppose a certain data structure stores a **StringBuilder** called `_word`, and we want to provide read-only access to its length. We can facilitate this by defining the following property:

```C#
public int WordLength
{
    get => _word.Length;
}
```

In fact, we can abbreviate this definition as follows:

```C#
public int WordLength => _word.Length;
```

In this case, the **get** keyword is implied. In either case, the code to the right of the "=\>" must be an expression whose type is the same as the property's type. Note that when we provide such an expression, there is no longer a hidden variable, as we have provided explicit code indicating how the value of the property is to be computed.

We can also provide an explicit implementation for the **set** accessor. Suppose, for example, that we want to allow the user read/write access to the length of `_word`. In order to be able to provide write access, we must be able to acquire the value that the user wishes to assign to the length. C# provides a keyword **value** for this purpose - its type is the same as the type of the property, and it stores the value that user code assigns to the property. Hence, we can define the property as follows:

```C#
public int WordLength
{
    get => _word.Length;
    set => _word.Length = value;
}
```

It is this flexibility in defining the implementation of a property that makes **public** properties more maintainable than **public** fields. Returning to the example at the beginning of this section, suppose we had simply defined **X** as a **public double** field. As we pointed out above, such a field could be used by user code in the same way as the first definition of the property **X**. However, a field is part of the implementation of a class or structure. By making it **public**, we have exposed part of the implementation to user code. This means that if we later change this part of the implementation, we will potentially break user code that relies on it. If, instead, we were to use a property, we can then change the implementation by modifying the **get** and/or **set** accessors. As long as we don't remove either accessor (or make it **private**), such a change is invisible to user code. Due to this maintainability, good programmers will never use **public** fields (unless they are [constants](/appendix/syntax/const)); instead, they will use **public** properties.

In some cases, we need more than a single to expression to define a **get** or **set** accessor. For example, suppose a data structure stores an **int\[ \]** `_elements`, and we wish to provide read-only access to this array. In order to ensure read-only access, we don't want to give user code a reference to the array, as the code would then be able to modify its contents. We therefore wish to make a copy of the array, and return that array to the user code (though a better solution might be to define an [indexer](/appendix/syntax/indexers)). We can accomplish this as follows:

```C#
public int[ ] Elements
{
    get
    {
        int[] temp = new int[_elements.Length];
        _elements.CopyTo(temp, 0);
        return temp;
    }
}
```
Thus, arbitrary code may be included within the **get** accessor, provided it returns a value of the appropriate type; however, it is good programming practice to avoid changing the fields of a class or structure within the **get** accessor of one of its properties. In a similar way, arbitrary code may be used to implement a **set** accessor. As we can see from this most general way of defining properties, they are really more like methods than fields.

Given how similar accessors are to methods, we might also wonder why we don't just use methods instead of properties. In fact, we can do just that - properties don't give any functional advantage over methods, and in fact, some object-oriented languages don't have properties. The advantage is stylistic. Methods are meant to perform actions, whereas properties are meant to represent entities. Thus, we could define methods **GetX** and **SetX** to provide access to the **private** field `_x`; however, it is stylistically cleaner to define a property called **X**.
