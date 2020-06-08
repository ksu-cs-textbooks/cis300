# Simple Text File I/O

Many of the I/O tools provided by the .NET Framework are found in the
[System.IO](http://msdn.microsoft.com/en-us/library/system.io.aspx)
namespace. Note, however, that Visual StudioÃ‚Â® does not automatically
provide a **using** directive for this namespace; hence, if you want to
avoid the need to add the prefix "System.IO." to each type that you use
from this namespace, you should add a **using** directive for it. One
class that provides several general-purpose
[**static**](/~rhowell/DataStructures/redirect/static-this) methods
related to file I/O is the
[**File**](http://msdn.microsoft.com/en-us/library/system.io.file\(v=vs.110\).aspx)
class. Two of the **static** methods provided by this class are:

  - [**File.ReadAllText**](http://msdn.microsoft.com/en-us/library/ms143368\(v=vs.110\).aspx)
    and
  - [**File.WriteAllText**](http://msdn.microsoft.com/en-us/library/ms143375\(v=vs.110\).aspx)

The **File.ReadAllText** method takes a **string** as its only
parameter. This **string** should give the path to a text file. It will
then attempt to read that entire file and return its contents as a
**string**. For example, if `fileName` refers to a **string** containing
the path to a text file, then

    string contents = File.ReadAllText(fileName);

will read that entire file and place its contents into the **string** to
which `contents` refers. We can then process the **string** `contents`
however we need to.

The **File.WriteAllText** method takes two parameters:

  - a **string** giving the path to a file; and
  - a **string** giving the text to be written.

It will then attempt to write the given text as the entire contents of
the given file. Thus, if `fileName` refers to a **string** containing
the path to a file and `contents` refers to some **string**, then

    File.WriteAllText(fileName, contents);

will write to that file the **string** to which `contents` refers.

When calling either of these methods, there are a number things that can
go wrong. For example, the file might be accessed through a network, and
access to the network might be lost before the method can complete. When
such an issue prevents the successful completion of one of these
methods, an *exception* is thrown. In [the next
section](/~rhowell/DataStructures/redirect/exceptions), we will discuss
how to handle such exception.

While these methods are quite easy to use, they are not always the best
ways of doing text file I/O. One drawback is that files can be quite
large - perhaps too large to fit in memory or within a single
**string**. Even when it is possible to read the entire file into a
single **string**, it may use enough memory that performance suffers. In
the section, "[Advanced Text File
I/O](/~rhowell/DataStructures/redirect/advanced-text-file-io)", we will
present other techniques for reading and writing text files.
