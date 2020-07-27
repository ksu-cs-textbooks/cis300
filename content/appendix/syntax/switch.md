+++
title = "The switch Statement"
date = 2018-08-24T10:53:05-05:00
weight = 120
chapter = true
pre = "<b>A1.12. </b>"
+++

## The **switch** Statement

The **switch** statement provides an alternative to the **if** statement for certain contexts. It is used when different cases must be handled based on the value of an expression that can have only a few possible results.

For example, suppose we want to display a [**MessageBox**](/~rhowell/DataStructures/redirect/message-boxes) containing "Abort", "Retry", and "Ignore" buttons. The user can respond in only three ways, and we need different code in each case. Assuming `message` and `caption` are **string**s, we can use the following code:

```c#
switch (MessageBox.Show(message, caption, MessageBoxButtons.AbortRetryIgnore))
{
    case DialogResult.Abort:
        // Code for the "Abort" button
        break;
    case DialogResult.Retry:
        // Code for the "Retry" button
        break;
    case DialogResult.Ignore:
        // Code for the "Ignore" button
        break;
}
```

The expression to determine the case (in this example, the call to **MessageBox.Show**) is placed within the parentheses following the keyword **switch**. Because the value returned by this method is of the [enumeration](/~rhowell/DataStructures/redirect/enumerations) type [**DialogResult**](http://msdn.microsoft.com/en-us/library/system.windows.forms.dialogresult.aspx), it will be one of a small set of values; in fact, given the buttons placed on the **MessageBox**, this value must be one of three possibilities. These three possible results are listed in three *case labels*. Each of these case labels must begin with the keyword **case**, followed by a constant expression (i.e., one that can be fully evaluated by the compiler, as explained in the section, "[Constant Fields](/~rhowell/DataStructures/redirect/const)"), followed by a colon (':'). When the expression in the **switch** statement is evaluated, control jumps to the code following the case label containing the resulting value. For example, if the result of the call to **MessageBox.Show** is **DialogResult.Retry**, control jumps to the code following the second case label. If there is no case label containing the value of the expression, control jumps to the code following the **switch** statement. The code following each case label must be terminated by a statement like **break** or **return**, which causes control to jump elsewhere. (This arcane syntax is a holdover from C, except that C allows control to continue into the next case.) A **break** statement within a **switch** statement causes control to jump to the code following the **switch** statement.

The last case in a **switch** statement may optionally have the case label:

```c#
    default:
```

This case label is analogous to an **else** on an **if** statement in that if the value of the **switch** expression is not found, control will jump to the code following the **default** case label. While this case is not required in a **switch** statement, there are many instances when it is useful to include one, even if you can explicitly enumerate all of the cases you expect. For example, if each case ends by returning a value, but no **default** case is included, the compiler will detect that not all paths return a value, as any case that is not enumerated will cause control to jump past the entire **switch** statement. There are various ways of avoid this problem:

- Make the last case you are handling the **default** case.
- Add a **default** case that explicitly throws an exception to handle any cases that you don't expect.
- Add either a **return** or a **throw** following the **switch** statement (the first two options are preferable to this one).

It is legal to have more than one case label on the same code block. For example, if `i` is an **int** variable, we can use the following code:

```c#
switch (i)
{
    case 1:
        // Code for i = 1
        break;
    case 2:
    case 3:
    case 5:
    case 7:
        // Code for i = 2, 3, 5, or 7
        break;
    case 4:
    case 6:
    case 8:
        // Code for i = 4, 6, or 8
        break;
    default:
        // Code for all other values of i
        break;
}
```

If the value of the **switch** expression matches any one of the case labels on a block, control jumps to that block. The same case label may not appear more than once.
