+++
title = "Other File I/O"
weight = 50

pre = "<b>1.5. </b>"
+++

## Other File I/O

Not all files are plain text files --- often we need to read and/or write
binary data. .NET provides the
[**FileStream**](https://learn.microsoft.com/en-us/dotnet/api/system.io.filestream?view=net-6.0)
class for this purpose.

The **FileStream** class provides constructors for creating a
**FileStream** for reading, writing, or both. These constructors can be
used to specify how the file is to be opened or created, the type of
access to be allowed (i.e., reading/writing), and how the file is to be
locked. In most cases, however, a simpler way to construct an
appropriate **FileStream** is to use one of the following **static**
methods provided by the the
[**File**](https://learn.microsoft.com/en-us/dotnet/api/system.io.file?view=net-6.0)
class:

  - [**File.OpenRead(string
    fn)**](https://learn.microsoft.com/en-us/dotnet/api/system.io.file.openread?view=net-6.0#system-io-file-openread(system-string)):
    returns a **FileStream** for reading the file with the given path
    name. A **FileNotFoundException** is thrown if the file does not
    exist.
  - [**File.OpenWrite(string
    fn)**](https://learn.microsoft.com/en-us/dotnet/api/system.io.file.openwrite?view=net-6.0#system-io-file-openwrite(system-string)):
    returns a **FileStream** for writing to the file with the given path
    name. If the file exists, it will be replaced; otherwise, it will be
    created.

Two of the most commonly-used methods of a **FileStream** are
[**ReadByte**](https://learn.microsoft.com/en-us/dotnet/api/system.io.filestream.writebyte?view=net-6.0#system-io-filestream-writebyte(system-byte))
and
[**WriteByte**](https://learn.microsoft.com/en-us/dotnet/api/system.io.filestream.writebyte?view=net-6.0#system-io-filestream-writebyte(system-byte)).
The **ReadByte** method takes no parameters and returns an **int**. If
there is at least one byte available to read, the next one is read and
its value (a nonnegative integer less than 256) is returned; otherwise,
the value returned is -1 (this is the only way to detect when the end of
the stream has been reached). The **WriteByte** method takes a **byte**
as its only parameter and writes it to the file. It returns nothing.

Because a **FileStream** has no **EndOfStream** property, we must code a
loop to read to the end of the stream somewhat differently from what we
have seen before. We can take advantage of the fact that in C#, an
assignment statement can be used within an expression. When this is
done, the value of the assignment statement is the value that it
assigns. Thus, if `input` is a **FileStream** opened for input, we can
set up a loop to read a byte at a time to the end of the stream as
follows:

```c#
int k;
while ((k = input.ReadByte()) != -1)
{
    byte b = (byte)k;
    . . .
}
```

In the above code, the **ReadByte** method reads a byte from the file as
long as there is one to read, and assigns it to the **int** variable
`k`. If there is no byte to read, it assigns -1 to `k`. In either case,
the value of the assignment statement is the value assigned to `k`.
Thus, if the **ReadByte** method is at the end of the stream, it returns
-1, which is assigned to `k`, and the loop terminates. Otherwise, the
loop iterates, assigning `k` to `b` as a **byte**. The remainder of the
iteration can then use the **byte** read, which is in `b`.
