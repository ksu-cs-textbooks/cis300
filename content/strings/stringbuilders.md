+++
title = "StringBuilders"
date = 2018-08-24T10:53:05-05:00
weight = 20
chapter = true
pre = "<b>2.2. </b>"
+++

## **StringBuilder**s

In [the previous
section](/~rhowell/DataStructures/redirect/string-desc), we saw that
building large **string**s from small pieces by concatenating them
together is very inefficient. This inefficiency is due to the fact that
**string**s are immutable. In order to overcome the inefficiency of
concatenation, we need an alternative data structure that we can modify.
The
[**StringBuilder**](http://msdn.microsoft.com/en-us/library/system.text.stringbuilder\(v=vs.110\).aspx)
class fills this need.

Like **string**s, **StringBuilder**s implement sequences of characters,
but the contents of **StringBuilder**s can be changed. The
**StringBuilder** class has six constructors. The [simplest
**StringBuilder**
constructor](http://msdn.microsoft.com/en-us/library/dsd3ey60\(v=vs.110\).aspx)
takes no parameters and constructs an empty **StringBuilder** - i.e., a
**StringBuilder** containing no characters:

    StringBuilder sb = new StringBuilder();

We can then modify a **StringBuilder** in various ways. First, we may
append a **char** to the end using its
[**Append**](http://msdn.microsoft.com/en-us/library/yet24s7b\(v=vs.110\).aspx)
method. This method not only changes the contents of the
**StringBuilder**, but it also returns a reference to it. Thus if we
have **char** variables, `a`, `b`, and `c`, and a **StringBuilder**
variable `sb`, we can write code such as:

    sb.Append(a).Append(b).Append(c);

The first call to **Append** appends the contents of `a` to `sb`, and
returns `sb`. Thus, the second call to **Append** also applies to `sb` -
it appends the contents of `b`. Likewise, the third call appends the
contents of `c`.

Because this method changes a **StringBuilder**, rather than
constructing a new one, its implementation is very efficient - in most
cases, only the appended character needs to be copied (see
"[Implementation of
**StringBuilder**s](/~rhowell/DataStructures/redirect/stringbuilder-impl)"
for details). This class has other **Append** methods as well, including
one that [appends the contents of a given
**string**](http://msdn.microsoft.com/en-us/library/b4sc8ca8\(v=vs.110\).aspx).
This method likewise only needs to copy the appended characters.

Let us now return to the problem of converting all lower-case letters in
a **string** to upper-case, converting all upper-case letters to
lower-case, and leaving all other characters unchanged. We can use a
**StringBuilder** as an intermediate data structure to do this much more
efficiently than the code presented in [the previous
section](/~rhowell/DataStructures/redirect/string-desc):

    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < text.Length; i++)
    {
        char c = text[i];
        if (Char.IsLower(c))
        {
            sb.Append(Char.ToUpper(c));
        }
        else if (Char.IsUpper(c))
        {
            sb.Append(Char.ToLower(c));
        }
        else
        {
            sb.Append(c);
        }
    }
    string result = sb.ToString();

On most iterations, the above loop only copies one character. In
addition, the call to the **StringBuilder**'s **ToString** method copies
each character in the result. If `text` is 100,000 characters long, this
is a total of 200,000 character copies. Using the **StringBuilder**
implementation described in [the next
section](/~rhowell/DataStructures/redirect/stringbuilder-impl), there
are some iterations that copy more than one character, but even if we
account for this, it turns out that fewer than 400,000 characters are
copied, as opposed to over five billion character copies when
**string**s are used directly (see [the previous
section](/~rhowell/DataStructures/redirect/string-desc)). The
**StringBuilder** implementation in the .NET Framework performs even
better. In either case, the above code runs in *O*(*n*) time, where *n*
is the length of `text`; i.e., as *n* gets large, the running time is at
worst proportional to *n*. Thus, its performance degrades much less
rapidly than the *O*(*n*<sup>2</sup>) code that uses **string**s
directly.

A program that runs the above code and the code given in [the previous
section](/~rhowell/DataStructures/redirect/string-desc) on user-provided
text files can be obtained by creating a Git repository (see "[Git
Repositories](/~rhowell/DataStructures/redirect/version-control)") using
[this URL](https://classroom.github.com/a/lQSbxCEo). A noticeable
performance difference can be seen on text files larger than 100K - for
example, the full text of [Lewis Carroll's *Through the Looking
Glass*](http://www.gutenberg.org/cache/epub/12/pg12.txt).

**StringBuilder**s have some features in common with **string**s. For
example, we access individual characters in a **StringBuilder** by
indexing; i.e., if `sb` is a **StringBuilder** variable, then `sb[0]`
accesses its first character, `sb[1]` accesses its second character,
etc. The main difference here is that with a **StringBuilder**, we may
use indexing to change characters; e.g., we may do the following,
provided `sb` contains at least 3 characters:

    sb[2] = 'x';

A **StringBuilder** also has a
[**Length**](http://msdn.microsoft.com/en-us/library/system.text.stringbuilder.length\(v=vs.110\).aspx)
property, which gets the number of characters contained. However, we may
also set this property to any nonnegative value, provided there is
enough memory available to provide this length. For example, we may
write:

    sb.Length = 10;

If the new length is shorter than the old, characters are removed from
the end of the **StringBuilder**. If the new length is longer that the
old, **char**s containing the Unicode NULL value (0 in decimal) are
appended. (**Note:** the Unicode NULL value is different from a **null**
reference. Because **char** is a [value
type](/~rhowell/DataStructures/redirect/reference-value), a **char**
cannot store a **null** reference.)

**StringBuilder**s have many other methods to allow various kinds of
manipulation - see [the documentation for the **StringBuilder**
class](http://msdn.microsoft.com/en-us/library/system.text.stringbuilder\(v=vs.110\).aspx)
for details. There is also a [**StringBuilder**
constructor](http://msdn.microsoft.com/en-us/library/5fxz4s6t\(v=vs.110\).aspx)
that takes a **string** as its only parameter and constructs a
**StringBuilder** containing the contents of that **string**.
