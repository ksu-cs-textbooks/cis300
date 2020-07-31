+++
title = "Unit Testing"
date = 2018-08-24T10:53:05-05:00
weight = 80
chapter = true
pre = "<b>A2.8. </b>"
+++

## Unit Testing

Some of the lab assignments in CIS 300 use a technique called *unit testing* for testing the correctness of your code. Unit testing is an automated technique for testing individual **public** methods and properties using a pre-defined set of test cases. We will be using an open-source unit-testing framework called [NUnit](http://nunit.org/). 

An NUnit test suite is a separate project contained within the same solution as the project it is to test. The GitHub repositories for lab assignments that utilize unit testing will initially contain these projects, whose names will typically end with ".Tests". You should not modify these test projects.

A test project will contain one or more classes having the attribute, **\[TestFixture\]**. These classes will contain the specific tests, each of which is a method with the attribute, **\[Test\]**. The name of the method will briefly describe the test, and a more detailed explanation will be provided in comments.

To run all of the tests, go to the
"Test" menu and select "Run All Tests". This will open the Test
Explorer showing output resembling the following:

![A picture of the Test Explorer should appear
here.](test-explorer.png)

{{% notice note %}}
To see all of the output, you will need to open all of the elements by
clicking on the small triangles to the right of each element.
{{% /notice %}}

The above output shows that there were two tests in the test suite. The names of the tests are simply the names of the methods comprising the tests. The output further shows that one of the tests, **LengthIsCorrect**, failed, whereas the other test, **FirstElementIs2**, passed.

The goal, of course, is to get all the tests to pass. When a test
fails, you will first want to refer to the comments on the test method
in order to understand what it is testing. Then by clicking on the
failed test in the Test Explorer, you can see exactly what failed in
the test - this will appear in the panel on the right. In some cases,
an unexpected result will have been produced. In such cases, the
message will show what result was expected, and what it actually
was. In other cases, an exception will have been thrown. In such
cases, the exception will be displayed. A stack trace will also be
displayed, so that you can tell what line of code threw the
exception. Finally, you can run the debugger on the test itself by
right-clicking on the test and selecting "Debug". This will allow you
to debug your code using the techniques describe in the section, "[The
Debugger"](/appendix/vs/debugger).

{{% notice tip %}}
You can dock the Team Explorer into the main Visual Studio window by
clicking on the small triangle in the far upper-right corner of the
window and selecting either "Dock" or "Dock as Tabbed Document".
{{% /notice %}}

One potential error deserves special mention. Sometimes code will
throw an exception that cannot be caught by a **try-catch** block. By
far the most common of these exceptions is the
**StackOverflowException**. When this exception is thrown during unit
testing, the test explorer will simply show some or all of the tests
in gray letters. This indicates that these tests were not
completed. To see why the tests were not completed, you can open the
"Output" window and change the drop-down menu at the top to
"Tests". This will indicate what error stopped the tests; for example,
the following indicates that a **StackOverflowException** has
occurred:

![A picture of an output window should appear here.](StackOverflowException.png)

Unfortunately, when this error occurs, it's more difficult to determine which test caused the exception. You can run the debugger on each test individually to see if it throws a **StackOverflowException**. In many cases, however, it is easier to examine each recursive call to make sure the call is made on a smaller problem instance.

When you believe you have fixed any errors in your code, you will
usually want to run all the tests again, as fixing one error can
sometimes introduce another. However, there are times, such as when
some of the tests are slow, when you don't want to run all the
tests. In such cases, you can select an appropriate alternative from
the "Run" drop-down at the top of the Test Explorer (i.e., from the
drop-down button with the single green triangle on it). A useful option from this menu is "Run Failed Tests". Alternatively, you can select one or more tests from the Test Explorer (use Ctrl-Click to select multiple tests), then right-click and select "Run".

Whenever you run fewer than all the tests, the tests that were not run
are dimmed in the Test Explorer to indicate that these results are not
up to date. Be sure you always finish by running all the tests to make sure they all pass on the same version of your code.

<!--
Though it is not required for CIS 300, you might wish to experiment with unit testing on your homework assignments. In what follows, we will briefly introduce the construction of your own unit-test suites. We make no attempt here to be comprehensive - for more information, refer to the [NUnit Documentation Wiki](https://github.com/nunit/docs/wiki).

If you are using your own machine, you will first need to make sure you have installed the two Visual Studio extensions listed at the top of this page. To create a test project within a solution, go to the Solution Explorer, right-click on the solution (i.e., the top line), and select "Add-\>New Project...". In the panel on the left, under "Visual C#", select "Test". Then in the large panel on the right, select "NUnit 3 Unit Test Project". At the bottom, select an appropriate name for the project, and click "OK". This will create a test project containing the class file, **TestClass.cs**, which you may rename if you wish. This class is initialized with a trivial test method, which you may either remove or edit.

In order to allow your test project to access the project it is to test, you will need to add to your test project a reference to the project it will test. First, however, you need to correct a problem with the way Visual Studio creates the test project. In the Solution Explorer, double-click on "Properties" within the project you wish to test. Take note of the .NET Framework version that appears under "Target framework:". Now return to the Solution Explorer, and double-click "Properties" with your test project. Under "Target framework:", change the version to match the version for the project you wish to test, and click "Yes" in the resulting dialog. Return once more to the Solution Explorer, right-click on the test project name, and select "Add-\>Reference...". In the resulting dialog, click on "Projects" on the left, click the check box next to the project you wish to test, and click "OK".

You are now ready to begin writing your tests. Each test should be a single method having the **\[Test\]** attribute and an empty parameter list. Each method will need to contain code to set up and conduct a single test for the code in your project. Once you have collected all the output from the test, you will need to check its correctness. Within NUnit 3, this is typically done with the **static** method **Assert.That**. There are several overloads for this method, but the one we will discuss takes two parameters. The first is the output that you wish to check - it may be of any type. The second is a *constraint* that specifies a condition that the first parameter must satisfy in order to be correct.

Constraints are typically generated using one of the **static** classes **Is** or **Has**. For example, the **Is** class has a method **EqualTo** that takes an **object** as its only parameter, and returns a constraint that specifies equality to the given object. Thus, we can assert that the **int** variable `n` has a value of 10 with the following statement:

```C#
Assert.That(n, Is.EqualTo(10));
```

Each constraint contains the properties **And** and **Or**, which can be used to combine constraints logically. For example, we can assert that 0 ≤ n ≤ 10 as follows:

```C#
Assert.That(n, Is.GreaterThanOrEqualTo(0).And.LessThanOrEqualTo(10));
```

There is also a property **Not**, both in the **Is** class and in the objects returned by the **And** and **Or** properties. For example:

```C#
Assert.That(n, Is.Not.InRange(0, 10).And.Not.InRange(100, 200));
```

All of the constraints available are documented at <https://github.com/nunit/docs/wiki/Constraints>. The constraints on that page are listed by their names; however, the names themselves are rarely used in writing assertions in test code. Because the names are descriptive, it is usually easy to find the one you want. Once you have found it, click on the link for documentation on how to use it. Pay attention to how it is used with **Is** or **Has**. It is usually not hard to express the assertion you need.

When writing tests, it is possible to include multiple assertions within the same method. If one of the assertions fails, none of the subsequent assertions is checked. It is usually best, however, to include only one assertion within each method.

-->
