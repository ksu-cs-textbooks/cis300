+++
title = "MessageBoxes"
date = 2018-08-24T10:53:05-05:00
weight = 25
chapter = true
pre = "<b>1.1.1. </b>"
+++

## **Message Box**es

The
[**MessageBox**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox?view=netframework-4.7.2)
class (found in the
[**System.Windows.Forms**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms?view=netframework-4.7.2)
namespace) provides a simple mechanism for displaying a message and
obtaining one of a few simple responses from the user. The most common
usage of a **MessageBox** is to call one of its various [**Show**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=netframework-4.7.2)
methods, each of which is
[**static**](/appendix/syntax/static-this). The
simplest
[**Show**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=netframework-4.7.2#System_Windows_Forms_MessageBox_Show_System_String_)
method takes a **string** as its only parameter. The method then
displays this **string** in a modal dialog containing an "OK" button.
Thus, for example,
```C#
MessageBox.Show("Hello world!");
```
will display the following dialog:

![A picture of a window should appear here.](simple-message-box.png)

Because the dialog is modal, it will block all other interaction with
the program until the user closes it by clicking either the "OK" button
or the "X" in the upper right. Furthermore, the **Show** method will not
return until that time.

Other **Show** methods allow greater customization of a **MessageBox**.
For example, one
[**Show**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=netframework-4.7.2#System_Windows_Forms_MessageBox_Show_System_String_System_String_)
method takes as an additional parameter a second **string** giving a
caption for the **MessageBox**. Thus, the statment,
```C#
MessageBox.Show("Hello world!", "Hello");
```
will display the following modal dialog:

![A picture of a window should appear
here.](message-box-with-caption.png)

Other **Show** methods allow the buttons to be customized. For example,
one
[**Show**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=netframework-4.7.2#System_Windows_Forms_MessageBox_Show_System_String_System_String_System_Windows_Forms_MessageBoxButtons_)
method takes, as its third parameter, an element from the
[**MessageBoxButtons**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messageboxbuttons?view=netframework-4.7.2)
[enumeration](/appendix/syntax/enumerations). This
[enumeration](/appendix/syntax/enumerations) contains
the following values:

  - **MessageBoxButtons.AbortRetryIgnore**: Buttons labeled "Abort",
    "Retry", and "Ignore" are shown.
  - **MessageBoxButtons.OK**: A single button labeled "OK" is shown.
  - **MessageBoxButtons.OKCancel**: Buttons labeled "OK" and "Cancel"
    are shown.
  - **MessageBoxButtons.RetryCancel**: Buttons labeled "Retry" and
    "Cancel" are shown.
  - **MessageBoxButtons.YesNo**: Buttons labeled "Yes" and "No" are
    shown.
  - **MessageBoxButtons.YesNoCancel**: Buttons labeled "Yes", "No", and
    "Cancel" are shown.

The values above containing the word, "Cancel", cause the "X" in the
upper-right of the dialog to be enabled. Clicking this button in these
cases is equivalent to clicking the "Cancel" button. The value,
**MessageBoxButtons.OK**, also enables this "X" button, but in this
case, clicking this button is equivalent to clicking the "OK" button.
Using a **Show** without a **MessageBoxButtons** parameter also gives
this behavior. For all other **MessageBoxButtons** values, this "X"
button is disabled.

In order to provide appropriate functionality to each of the buttons,
each **Show** method returns a value of type
[**DialogResult**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.dialogresult?view=netframework-4.7.2).
This type is another enumeration containing
the following values to indicate which button the user clicked:

  - **DialogResult.Abort**
  - **DialogResult.Cancel**
  - **DialogResult.Ignore**
  - **DialogResult.No**
  - **DialogResult.None** (this value won't be returned by any of the
    **Show** methods)
  - **DialogResult.OK**
  - **DialogResult.Retry**
  - **DialogResult.Yes**

Suppose, for example, that we are writing a document formatter or some
other application in which the user builds a document. If the user
attempts to exit the program when the document is unsaved, we would like
to give an opportunity to save the document. We can accomplish this with
the following code:
```C#
DialogResult result = MessageBox.Show("The file is not saved. Really quit?", 
    "Confirm Quit", MessageBoxButtons.YesNo);
if (result == DialogResult.Yes)
{
    Application.Exit();
}
```
The first statement displays the following dialog:

![A picture of a window should appear
here.](message-box-with-buttons.png)

Again, because the dialog is modal, the **Show** method does not return
until the user closes the dialog by clicking one of the two buttons (the
"X" in the upper right is disabled). When the user does this, the dialog
closes, and the **Show** method returns either **DialogResult.Yes** or
**DialogResult.No** to indicate which button the user clicked. If the
user clicked the "Yes" button, then the **if**-statement will cause the
program to terminate. Otherwise, the program will continue with whatever
code follows (probably nothing more, as the program will need to await
further user action).

We can also decorate a **MessageBox** with an icon that indicates what
type of message it is. This requires another
[**Show**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=netframework-4.7.2#System_Windows_Forms_MessageBox_Show_System_String_System_String_System_Windows_Forms_MessageBoxButtons_System_Windows_Forms_MessageBoxIcon_)
method having a fourth parameter of type
[**MessageBoxIcon**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messageboxicon?view=netframework-4.7.2).
**MessageBoxIcon** is another enumeration. Some of its values are:

  - **MessageBoxIcon.Error**:  
    ![A picture of an error icon should appear here.](messagebox-error.png)
  - **MessageBoxIcon.Information**:  
    ![A picture of an information icon should appear
    here.](messagebox-information.png)
  - **MessageBoxIcon.None** (no icon)
  - **MessageBoxIcon.Warning**:  
    ![A picture of a warning icon should appear here.](messagebox-exclamation.png)

This enumeration contains a few other values as well, but they currently
are simply duplicate values for the above icons or values that
Microsoft recommends against using. To add a warning icon
to the above example, we could replace the first statement with:
```C#
DialogResult result = MessageBox.Show("The file is not saved. Really quit?", 
    "Confirm Quit", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
```
This will display the following dialog:

![A picture of a window should appear here.](message-box-with-icon.png)

Notice that in the above example, the "Yes" button has the focus; i.e.,
pressing "Enter" has the same effect as clicking this button. It is
usually desirable to have the safest response as the default - in this
case, the "No" button. To achieve this, a
[**Show**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=netframework-4.7.2#System_Windows_Forms_MessageBox_Show_System_String_System_String_System_Windows_Forms_MessageBoxButtons_System_Windows_Forms_MessageBoxIcon_System_Windows_Forms_MessageBoxDefaultButton_)
method having a fifth parameter, of type
[**MessageBoxDefaultButton**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messageboxdefaultbutton?view=netframework-4.7.2),
is required. **MessageBoxDefaultButton** is another enumeration having
the following values to select an appropriate button to be the default:

  - **MessageBoxDefaultButton.Button1**
  - **MessageBoxDefaultButton.Button2**
  - **MessageBoxDefaultButton.Button3**

Thus, the following statement:
```C#
DialogResult result = MessageBox.Show("The file is not saved. Really quit?", 
    "Confirm Quit", MessageBoxButtons.YesNo, MessageBoxIcon.Warning,
    MessageBoxDefaultButton.Button2);
```
produces a dialog similar to the one above, but having the "No" button
as its default.

There are other **Show** methods that allow additional fine-tuning;
however, the ones described here cover most of the functionality. For
details on other **Show** methods, see the [documentation for the
**MessageBox**
class](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox?view=netframework-4.7.2).
