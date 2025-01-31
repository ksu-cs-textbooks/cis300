+++
title = "Advanced Text File I/O"
weight = 40

pre = "<b>1.4. </b>"
+++

## Advanced Text File I/O

Though the **File.ReadAllText** and **File.WriteAllText** methods
provide simple mechanisms for reading and writing text files, they are
not always the best choices. For one reason, files can be very large ---
too large to fit into memory, or possibly even larger than the maximum
length of a **string** in C\# (2,147,483,647 characters). Even when it
is possible to store the entire contents of a file as a **string**, it
may not be desirable, as the high memory usage may degrade the overall
performance of the system.

For the purpose of handling a sequence of input or output data in more
flexible ways, .NET provides *streams*. These streams are
classes that provide uniform access to a wide variety of sequences of
input or output data, such as files, network connections, other
processes, or even blocks of memory. The
[**StreamReader**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamreader?view=net-6.0)
and
[**StreamWriter**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamwriter?view=net-6.0)
classes (in the
[**System.IO**](https://learn.microsoft.com/en-us/dotnet/api/system.io?view=net-6.0)
namespace) provide read and write, respectively, access to text streams,
including text files.

Some of the more useful **public** members of the **StreamReader** class
are:

  - A
    [constructor](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamreader.-ctor?view=net-6.0#system-io-streamreader-ctor(system-string))
    that takes a **string** giving a file name as its only parameter and
    constructs a **StreamReader** to read from that file.
  - A
    [**Read**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamreader.read?view=net-6.0#system-io-streamreader-read)
    method that takes no parameters. It reads the next character from
    the stream and returns it as an **int**. If it cannot read a
    character because it is already at the end of the stream, it returns
    -1 (it returns an **int** because -1 is outside the range of
    **char** values).
  - A
    [**ReadLine**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamreader.readline?view=net-6.0#system-io-streamreader-readline)
    method that takes no parameters. It reads the next line from the
    stream and returns it as a **string?**. If it cannot read a line
    because it is already at the end of the stream, it returns **null**.
  - An
    [**EndOfStream**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamreader.endofstream?view=net-6.0#system-io-streamreader-endofstream)
    property that gets a **bool** indicating whether the end of the
    stream has been reached.

With these members, we can read a text file either a character at a time
or a line at a time until we reach the end of the file. The
**StreamWriter** class has similar **public** members:

  - A
    [constructor](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamwriter.-ctor?view=net-6.0#system-io-streamwriter-ctor(system-string))
    that takes a **string** giving a file name as its only parameter and
    constructs a **StreamWriter** to write to this file. If the file
    already exists, it is replaced by what is written by the
    **StreamWriter**; otherwise, a new file is created.
  - A [**Write**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamwriter.write?view=net-6.0#system-io-streamwriter-write(system-char))
    method that takes a **char** as its only parameter. It writes this
    **char** to the end of the stream.
  - Another
    [**Write**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamwriter.write?view=net-6.0#system-io-streamwriter-write(system-string))
    method that takes a **string?** as its only parameter. It writes this
    **string?** to the end of the stream. If the given **string?** is **null**, nothing is written.
  - A
    [**WriteLine**](https://learn.microsoft.com/en-us/dotnet/api/system.io.textwriter.writeline?view=net-6.0#system-io-textwriter-writeline)
    method that takes no parameters. It writes a line terminator to the
    end of the stream (i.e., it ends the current line of text).
  - Another
    [**WriteLine**](https://learn.microsoft.com/en-us/dotnet/api/system.io.textwriter.writeline?view=net-6.0#system-io-textwriter-writeline(system-char))
    method that takes a **char** as its only parameter. It writes this
    **char** to the end of the stream, then terminates the current line
    of text.
  - Yet another
    [**WriteLine**](https://learn.microsoft.com/en-us/dotnet/api/system.io.streamwriter.writeline?view=net-6.0#system-io-streamwriter-writeline(system-string))
    method that takes a **string?** as its only parameter. It writes this
    **string?** to the end of the stream, then terminates the current
    line of text. If the **string?** is **null**, only the line terminator is written.

Thus, with a **StreamWriter**, we can build a text file a character at a
time, a line at a time, or an arbitrary **string** at a time. In fact, a
number of other **Write** and **WriteLine** methods exist, providing the
ability to write various other types, such as **int** or **double**. In
each case, the given value is first converted to a **string**, then
written to the stream.

Streams are different from other classes, such as **string**s or arrays,
in that they are *unmanaged* resources. When a managed resource, such as
a **string** or an array, is no longer being used by the program, the
garbage collector will reclaim the space that it occupies so that it can
be allocated to new objects that may need to be constructed. However,
after a stream is constructed, it remains under the control of the
program until the program explicitly releases it. This has several
practical ramifications. For example, the underlying file remains
*locked*, restricting how other programs may use it. In fact, if an
output stream is not properly *closed* by the program, some of the data
written to it may not actually reach the underlying file. This is
because output streams are typically *buffered* for efficiency --- when
bytes are written to the stream, they are first accumulated in an
internal array, then written as a single block when the array is full.
When the program is finished writing, it needs to make sure that this
array is *flushed* to the underlying file.

Both the **StreamReader** and **StreamWriter** classes have
[**Dispose**](https://learn.microsoft.com/en-us/dotnet/api/system.idisposable.dispose?view=net-6.0#system-idisposable-dispose)
methods to release them properly; however, because I/O typically
requires exception handling, it can be tricky to ensure that this method
is always called when the I/O is finished. Specifically, the
**try-catch** may be located in a method that does not have access to
the stream. In such a case, the **catch**-block cannot call the stream's
**Dispose** method.

<span id="using"></span> To handle this difficulty, C\# provides a
**using** statement. A **using** statement is different from a **using**
directive, such as
```C#
using System.IO;
```
A **using** statement occurs within a method definition, not at the top
of a code file. Its recommended form is as follows:
```C#
using ( /* declaration and initialization of disposable variable(s) */ )
{

    /* Code that uses the disposable variables(s) */

}
```
Thus, if we want to read and process a text file whose name is given by
the **string** variable `fileName`, we could use the following code
structure:
```C#
using (StreamReader input = new StreamReader(fileName))
{

    /* Code that reads and process the file accessed by the
     * StreamReader input */

}
```
This declares the variable `input` to be of type **StreamReader** and
initializes it to a new **StreamReader** to read the given file. This
variable is only visible with the braces; furthermore, it is read-only ---
its value cannot be changed to refer to a different **StreamReader**.
The **using** statement then ensures that whenever control exits the
code within the braces, `input`'s **Dispose** method is called.

More than one variable of the same type may be declared and initialized
within the parentheses of a **using** statement; for example:
```C#
using (StreamReader input1 = new StreamReader(fileName1),
    input2 = new StreamReader(fileName2))
{

    /* Code that reads from input1 and input2 */

}
```
The type of variable(s) declared must be a subtype of
[**IDisposable**](https://learn.microsoft.com/en-us/dotnet/api/system.idisposable?view=net-6.0).
This ensures that the variables each have a **Dispose** method.

As a complete example of the use of a **StreamReader** and a
**StreamWriter**, together with a **using** statement for each, suppose
we want to write a method that takes as its parameters two **string**s
giving the name of an input file and the name of an output file. The
method is to reproduce the input file as the output file, but with each
line prefixed by a line number and a tab. We will start numbering lines
with 1. The following method accomplishes this:
```C#
/// <summary>
/// Copies the file at inFileName to outFileName with each line
/// prefixed by its line number followed by a tab.
/// </summary>
/// <param name="inFileName">The path name of the input file.</param>
/// <param name="outFileName">The path name of the output file.</param>
private void AddLineNumbers(string inFileName, string outFileName)
{
    using (StreamReader input = new StreamReader(inFileName))
    {
        using (StreamWriter output = new StreamWriter(outFileName))
        {
            int count = 0;
            while (!input.EndOfStream)
            {
                // Because input is not at the end of the stream, its ReadLine
                // method won't return null.
                string line = input.ReadLine()!;
                count++;
                output.Write(count);
                output.Write('\t');   // The tab character
                output.WriteLine(line);
            }
        }
    }
}
```
As noted above, a **StreamReader**'s **ReadLine** method has a return type of **string?** because it will return **null** if the end of the stream has already been reached. Furthermore, the compiler is unable to determine that the loop condition will prevent the call to **ReadLine** from returning **null**. Thus, in order to suppress the compiler warning when the returned **string?** is assigned to a **string**, we include a `!` following the call to **ReadLine**, and document the reason with a comment above this line.

We can call the above method within a **try**-block to handle any
exceptions that may be thrown during the I/O. The **catch**-block will
not have access to either `input` or `output`, but it doesn't need it.
If an exception is thrown during the I/O, the two **using** statements
will ensure that the **Dispose** methods of both the **StreamReader**
and the **StreamWriter** are called.
