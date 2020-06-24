---
title: "Out and Ref Parameters"
weight: 45
pre: "9. "
---

Normally, when a method is called, the *call-by-value* mechanism is used. Suppose, for example, we have a method:

```C#
private void DoSomething(int k)
{

}
```

We can call this method with a statement like:

```C#
DoSomething(n);
```

provided `n` is an initialized variable consistent with the **int** type. For example, suppose `n` is an **int** variable containing a value of 28. The call-by-value mechanism works by copying the value of `n` (i.e., 28) to `k`. Whatever the **DoSomething** method may do to `k` has no effect on `n` - they are different variables. The same can be said if we had instead passed a variable `k` - the `k` in the calling code is still a different variable from the `k` in the **DoSomething** method. Finally, if we call **DoSomething** with an expression like 42 or 9 + n, the mechanism is the same.

If a parameter is of a [reference type](/~rhowell/DataStructures/redirect/reference-value), the same mechanism is used, but it is worth considering that case separately to see exactly what happens. Suppose, for example, that we have the following method:

```C#
private void DoSomethingElse(int[] a)
{
    a[0] = 1;
    a = new int[10];
    a[1] = 2;
}
```

Further suppose that we call this method with

```C#
int[] b = new int[5];
DoSomethingElse(b);
```

The initialization of `b` above assigns to `b` a reference to an array containing five 0s. The call to **DoSomethingElse** copies the value of `b` to `a`. Note, however, that the value of `b` is a reference; hence, after this value is copied, `a` and `b` refer to the same five-element array. Therefore, when `a[0]` is assigned `1`, `b[0]` also becomes `1`. When `a` is assigned a new array, however, this does not affect `b`, as `b` is a different variable - `b` still refers to the same five-element array. Furthermore, when `a[1]` is assigned a value of 2, because `a` and `b` now refer to different arrays, the contents of `b` are unchanged. Thus, when **DoSomethingElse** completes, `b` will refer to a five-element array whose element at location 0 is 1, and whose other elements are 0.

While the call-by-value mechanism is used by default, another mechanism, known as the *call-by-reference* mechanism, can be specified. When call-by-reference is used, the parameter passed in the calling code must be a variable, not a property or expression. Instead of copying the value of this variable into the corresponding parameter within the method, this mechanism causes the variable within the method to be an *alias* for the variable being passed. In other words, the two variables are simply different names for the same underlying variable (consequently, the types of the two variables must be identical). Thus, whatever changes are made to the parameter within the method are reflected in the variable passed to the method in the calling code as well.

One case in which this mechanism is useful is when we would like to have a method return more than one value. Suppose, for example, that we would like to find both the maximum and minimum values in a given **int\[ \]**. A **return** statement can return only one value. Although there are ways of packaging more than one value together in one object, a cleaner way is to use two parameters that use the call-by-reference mechanism. The method can then change the values of these variables to the maximum and minimum values, and these values would be available to the calling code.

Specifically, we can define the method using **out** parameters:

```C#
private void MinimumAndMaximum(int[] array, out int min, out int max)
{
    min = array[0];
    max = array[0];
    for (int i = 1; i < array.Length; i++)
    {
        if (array[i] < min)
        {
            min = array[i];
        }
        if (array[i] > max)
        {
            max = array[i];
        }
    }
}
```

The **out** keyword in the first line above specifies the call-by-reference mechanism for `min` and `max`. We could then call this code as follows, assuming `a` is an **int\[ \]** containing at least one element:

```C#
int minimum;
int maximum;
MinimumAndMaximum(a, out minimum, out maximum);
```

When this code completes, `minimum` will contain the minimum element in `a` and `maximum` will contain the maximum element in `a`.

When using **out** parameters, it is important that the keyword **out** is placed prior to the variable name in both the method call and the method definition. If you omit this keyword in one of these places, then the parameter lists won't match, and you'll get a syntax error to this effect.

Note that **out** parameters do not need to be initialized prior to the method call in which they are used. However, they need to be assigned a value within the method to which they are passed. Another way of using the call-by-reference mechanism places a slightly different requirement on where the variables need to be initialized. This other way is to use **ref** parameters. The only difference between **ref** parameters and **out** parameters is that **ref** parameters must be initialized prior to being passed to the method. Thus, we would typically use an **out** parameter when we expect the method to assign it its first value, but we would use a **ref** parameter when we expect the method to change a value that the variable already has (the method may, in fact, use this value prior to changing it).

For example, suppose we want to define a method to swap the contents of two **int** variables. We use **ref** parameters to accomplish this:

```C#
private void Swap(ref int i, ref int j)
{
    int temp = i;
    i = j;
    j = temp;
}
```

We could then call this method as follows:

```C#
int m = 10;
int n = 12;
Swap(ref m, ref n);
```

After this code is executed, `m` will contain 12 and `n` will contain 10.
