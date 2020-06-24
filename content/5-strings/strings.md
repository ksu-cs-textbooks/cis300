# strings

Instances of the
[**string**](http://msdn.microsoft.com/en-us/library/system.string\(v=vs.110\).aspx)
class are *immutable* sequences of characters. Because **string** is a
class, it is a [reference
type](/~rhowell/DataStructures/redirect/reference-value). Because
instances are immutable, once they are constructed, their contents
cannot change. Note that this does *not* mean that **string** variables
cannot change - we can assign a **string** variable `s` the value "abc"
and later assign it the value "xyz". These assignments simply assign to
`s` references to different instances of the **string** class. What
immutability does mean is that there is no way to change any of the
characters in either of these instances (i.e., in either "abc" or
"xyz"). As a result, it is safe to copy a **string** by simply assigning
the value of one **string** variable to another; for example, if `s` is
a **string** variable, we can write:

    string t = s;

Note that this is *not* safe when dealing with mutable reference types,
such as arrays. For example, let `a` be an **int\[ \]** with at least
one element, and consider the following code sequence:

    int[ ] b = a;
    b[0]++;

Because `a` and `b` refer to the same array, `a[0]` is incremented as
well. This danger is absent for **string**s because they are immutable.

We access individual characters in a **string** by indexing; i.e., if
`s` is a **string** variable, then `s[0]` retrieves its first character,
`s[1]` retrieves its second character, etc. For example, if `s` refers
to the string, "abc", then after executing

    char c = s[1];

`c` will contain 'b'. Note that a statement like

    s[0] = 'x';

is prohibited in order to enforce immutability.

We obtain the number of characters in a **string** using its
[**Length**](http://msdn.microsoft.com/en-us/library/system.string.length\(v=vs.110\).aspx)
property; for example:

    int len = s.Length;

A **string** may have a length of 0. This means that it is the *empty
string*, denoted by "". Note that "" is different from a **null**
reference - for example, if `s` refers to "", then

    s.Length

has a value of 0, but if `s` is **null**, then the above expression will
throw a **NullReferenceException**.

We can concatenate two **string**s using the + operator. For example, if
`s` refers to the **string** "abc" and `t` refers to the **string**
"xyz", then

    string u = s + t;

will assign the **string** "abcxyz" to `u`.

Because **string**s are immutable, building long **string**s directly
from many small pieces is very inefficient. Suppose, for example, that
we want to convert all the lower-case characters in the **string**
`text` to upper-case, and to convert all upper-case letters in `text` to
lower-case. All other characters we will leave unchanged. We can do this
with the following code:

    string result = "";
    for (int i = 0; i < text.Length; i++)
    {
        char c = text[i];
        if (Char.IsLower(c))
        {
            result += Char.ToUpper(c);
        }
        else if (Char.IsUpper(c))
        {
            result += Char.ToLower(c);
        }
        else
        {
            result += c;
        }
    }

Now suppose that `text` contains 100,000 characters. Each iteration of
the loop executes one of the three branches of the **if**-statement,
each of which concatenates one character to the **string** accumulated
so far. Because **string**s are immutable, this concatenation must be
done by copying all the characters in `result`, along with the
concatenated character, to a new **string**. As a result, if we were to
add up the total number of characters copied over the course of the
entire loop, we would come up with 50,000,050,000 character copies done.
This may take a while. In general, we say that this code runs in
*O*(*n*<sup>2</sup>) time, where *n* is the length of `text`. This means
that as *n* increases, the running time of the code is at worst
proportional to *n*<sup>2</sup>. In [the next
section](/~rhowell/DataStructures/redirect/stringbuilders), we will see
how we can do this much more efficiently using another data structure.

**string**s have many other methods to allow various kinds of
manipulation - see [the documentation for the **string**
class](http://msdn.microsoft.com/en-us/library/system.string\(v=vs.110\).aspx)
for details.
