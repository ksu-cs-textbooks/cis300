+++
title = "The Remainder Operator"
weight = 130

pre = "<b>A1.13. </b>"
+++

## The Remainder Operator

The remainder operator `%` computes the remainder that results when one number is divided by another. Specifically, suppose <tt>m</tt> and <tt>n</tt> are of some numeric type, where <tt>n ≠ 0</tt>. We can then define a _quotient_ <tt>q</tt> and a _remainder_ <tt>r</tt> as the unique values such that:

*   <tt>qn + r = m</tt>;
*   <tt>q</tt> is an integer;
*   <tt>|qn| ≤ |m|</tt>; and
*   <tt>|r| < |n|</tt>.

Then <tt>m % n</tt> gives <tt>r</tt>, and we can compute <tt>q</tt> by:
```C#
(m - r) / n
```
Another way to think about <tt>m % n</tt> is through the following algorithm to compute it:

1.  Compute <tt>|m| / |n|</tt>, and remove any fractional part.
2.  If <tt>m</tt> and <tt>n</tt> have the same sign, let <tt>q</tt> be the above result; otherwise, let <tt>q</tt> be the negative of the above result.
3.  <tt>m % n</tt> is <tt>m - qn</tt>.

Examples:

*   <tt>7 % 3 = 1</tt>
*   <tt>-9 % 5 = -4</tt>
*   <tt>8 % -3 = 2</tt>
*   <tt>-10 % -4 = -2</tt>
*   <tt>6.4 % 1.3 = 1.2</tt>

