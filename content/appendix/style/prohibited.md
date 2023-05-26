+++
title = "Prohibited Features"
weight = 50

pre = "<b>A3.5 </b>"
+++

## Prohibited Features

The following features of C\# should not be used on assignments or quizzes unless otherwise stated:

- **The goto statement:** It has been over 50 years since Dijkstra published ["Go To Statement Considered Harmful"](http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF) (*Communications of the ACM*, vol. 11 (1968), pp. 147-148). I am
  amazed that languages continue to include this statement.

- **The unsafe keyword:** The name pretty much says it all.

- **The var keyword:** There are very few contexts in which this is needed, and these contexts won't occur in this class. For all other contexts, it makes the code less readable.

- **Virtual methods:** These are useful in large-scale software development; however, they are overused. They will not be needed in the programming we will be doing. (However, virtual methods in the .NET class library may be [overridden](/strings/stringbuilder-impl/#overriding).)

- **Abbreviated constructor calls:** Beginning with C# version 9.0, constructor calls are allowed to be abbreviated when the compiler can determine from the context the type of object that is being constructed. In such a case, the type name can be omitted from the **new** operator. For example, instead of writing:

  ```c#
  StringBuilder sb = new StringBuilder();
  ```

  we can write:

  ```c#
  StringBuilder sb = new();
  ```

  If the constructor takes parameters, they can be inserted between the parentheses. Such abbreviations are permitted - even encouraged - in cases like the above example, where the type being constructed is explicitly specified elsewhere in the same statement. However, if the type name is not explicitly specified elsewhere in the same statement, such abbreviations are prohibited, as they make the code harder to read.
