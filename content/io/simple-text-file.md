+++
title = "Simple Text File I/O"
weight = 25

pre = "<b>1.2. </b>"
+++

## Simple Text File I/O

Many of the I/O tools provided by .NET are found in the
[**System.IO**](https://learn.microsoft.com/en-us/dotnet/api/system.io?view=windowsdesktop-6.0)
namespace. One
class that provides several general-purpose
[**static**](/appendix/syntax/static-this) methods
related to file I/O is the
[**File**](https://learn.microsoft.com/en-us/dotnet/api/system.io.file?view=net-6.0)
class. Two of the **static** methods provided by this class are:

-   [**File.ReadAllText**](https://learn.microsoft.com/en-us/dotnet/api/system.io.file.readalltext?view=net-6.0#system-io-file-readalltext(system-string))
    and
-   [**File.WriteAllText**](https://learn.microsoft.com/en-us/dotnet/api/system.io.file.writealltext?view=net-6.0#system-io-file-writealltext(system-string-system-string))

The **File.ReadAllText** method takes a **string** as its only
parameter. This **string** should give the path to a text file. It will
then attempt to read that entire file and return its contents as a
**string**. For example, if `fileName` refers to a **string** containing
the path to a text file, then
```C#
string contents = File.ReadAllText(fileName);
```
will read that entire file and place its contents into the **string** to
which `contents` refers. We can then process the **string** `contents`
however we need to.

The **File.WriteAllText** method takes two parameters:

-   a **string** giving the path to a file; and
-   a **string?** (i.e., a [nullable](/appendix/syntax/reference-value#nullable-types) **string** - a **string** that may be **null**) giving the text to be written. 

It will then attempt to write the given text as the entire contents of
the given file. If this text is **null**, an empty file will be written. Thus, if `fileName` refers to a **string** containing
the path to a file and `contents` refers to some **string**, then
```C#
File.WriteAllText(fileName, contents);
```
will write to that file the **string** to which `contents` refers.

{{% notice warning %}}
When calling either of these methods, there are a number things that can
go wrong. For example, the file might be accessed through a network, and
access to the network might be lost before the method can complete. When
such an issue prevents the successful completion of one of these
methods, an *exception* is thrown. In [the next
section](/io/exceptions), we will discuss
how to handle such exceptions.
{{% /notice %}}

While these methods are quite easy to use, they are not always the best
ways of doing text file I/O. One drawback is that files can be quite
large - perhaps too large to fit in memory or within a single
**string**. Even when it is possible to read the entire file into a
single **string**, it may use enough memory that performance suffers. In
the section, ["Advanced Text File
I/O"](/io/advanced-text-file), we will
present other techniques for reading and writing text files.
