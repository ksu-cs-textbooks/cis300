+++
title = "Class Libraries"
date = 2018-08-24T10:53:05-05:00
weight = 110
chapter = true
pre = "<b>A2.11. </b>"
+++

## Class Libraries

Besides Windows Forms Applications, the other type of Visual Studio project that we will be building in CIS 300 is a Class Library. A Class Library is not a stand-alone application, but rather a collection of code that can be used by various applications. The .NET Framework is a collection of class libraries. When we implement a data structure, we often want to place it in a class library so that it is available to a variety of applications.

While it is possible to create a solution containing a single project that is a class library, in CIS 300, we will also work with solutions containing both a Class Library project and a Windows Forms Application project that will use the class library. We therefore need to know how to create a new class library project within an existing solution.

Suppose, for example, that we have a solution containing the program
from the section, "[**StringBuilder**s](/strings/stringbuilders)"
(this solution may be obtained by creating Git repository using [this
URL](https://classroom.github.com/a/lQSbxCEo)). We wish to replace the
implementation of **StringBuilder** from the .NET Framework with the
class defined in "[Implementation of
**StringBuilder**s](/strings/stringbuilder-impl)". Furthermore, we
wish to place this class in a new class library. To create a new Class
Library project within this solution, right-click on the solution name
in the Solution Explorer (i.e., on the top line), and select "Add -\>
New Project...". From the resulting dialog, select "Class Library
(.NET Framework)" and name it `Ksu.Cis300.StringBuilderLibrary`. For
the location, use the folder containing the Git repository that
includes the Visual Studio solution, so that this project will be
included in the same Git repository. When the project is created, a
code window containing a template for a **public class** definition
will appear. There will be no Design window, as you are not building a
graphical application (although graphical controls can be built within
a class library). The names of the source file and the class should
now be changed to **StringBuilder** using the Solution Explorer in the
same way as for a Windows Forms Application. Code for the
**StringBuilder** class can now be copied either from the section,
["Implementation of **StringBuilder**s"](/strings/stringbuilder-impl)
or the Git repository created using [this
URL](https://classroom.github.com/a/C2R3XPjX). Although we don't need
them for this example, additional class files can be added to the
project by going to the Solution Explorer, right-clicking on the
project name (not the solution name), and selecting "Add -> Class...".

Just having this project in the same solution isn't enough to allow
the **Ksu.Cis300.StringsAndStringBuilders** project to access it. In
order to enable this access, we need to go back to the Solution
Explorer, right-click on the **Ksu.Cis300.StringsAndStringBuilders**
project, and select, "Add -> Reference...". In the resulting dialog, we open the "Project" group on the left and select "Solution" from that group, then click the box next to "Ksu.Cis300.StringBuilderLibrary" in the main panel, and click the "OK" button at the lower right. Once this is done, we can edit "UserInterface.cs" in the **Ksu.Cis300.StringsAndStringBuilders** project we just added, and change

```C#
using System.Text;
```

to

```C#
using Ksu.Cis300.StringBuilderLibrary;
```

Then wherever the class **StringBuilder** occurs in this file, the implementation in our class library will be used.
