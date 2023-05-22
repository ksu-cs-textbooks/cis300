+++
title = "The decimal Type"
weight = 40

pre = "<b>A1.4. </b>"
+++

## The **decimal** Type

A
[**decimal**](https://docs.microsoft.com/en-us/dotnet/api/system.decimal?view=netframework-4.7.2)
is a [structure](/appendix/syntax/structs) representing
a floating-point decimal number. The main difference between a
**decimal** and a **float** or a **double** is that a **decimal** can
store any value that can be written using no more than 28 decimal
digits, a decimal point, and optionally a '-', without rounding. For
example, the value 0.1 cannot be stored exactly in either a **float** or
a **double** because its binary representation is infinite
(0.000110011...); however, it can be stored exactly in a **decimal**.
Various types, such as **int**, **double**, or **string**, may be
converted to a **decimal** using a **Convert.ToDecimal** method; for
example, if `i` is an **int**, we can convert it to a decimal with:
```C#
decimal d = Convert.ToDecimal(i);
```
A decimal is represented internally with the following three components:

  - A 96-bit value *v* storing the digits
    (0 ≤ *v* ≤ 79,228,162,514,264,337,593,543,950,335).
  - A sign bit *s*, where 1 denotes a negative value.
  - A scale factor *d* to indicate where the decimal point is
    (0 ≤ *d* ≤ 28).

The value represented is then (-1)<sup>*s*</sup>*v*/10<sup>*d*</sup>.
For example, 123.456 can be represented by setting *v* to 123,456,
*s* to 0, and *d* to 3.
