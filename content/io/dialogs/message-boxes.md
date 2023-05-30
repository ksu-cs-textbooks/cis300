+++
title = "MessageBoxes"
weight = 25
pre = "<b>1.1.1. </b>"
+++

## **Message Box**es

The [**MessageBox**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox?view=windowsdesktop-6.0) class (found in the [**System.Windows.Forms**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms?view=windowsdesktop-6.0) namespace) provides a simple mechanism for displaying a message and obtaining one of a few simple responses from the user. The most common usage of a **MessageBox** is to call one of its various [**Show**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=windowsdesktop-6.0) methods, each of which is [**static**](/appendix/syntax/static-this). The simplest [**Show**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=windowsdesktop-6.0#system-windows-forms-messagebox-show(system-string)) method takes a **string** as its only parameter. The method then displays this **string** in a modal dialog containing an "OK" button. Thus, for example,

```C#
MessageBox.Show("Hello world!");
```

will display the following dialog:

<img src="simple-message-box.png" alt="A MessageBox." style="zoom:67%;" />

Because the dialog is modal, it will block all other interaction with the program until the user closes it by clicking either the "OK" button or the "X" in the upper right. Furthermore, the **Show** method will not return until that time.

Other **Show** methods allow greater customization of a **MessageBox**. For example, one [**Show**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=windowsdesktop-6.0#system-windows-forms-messagebox-show(system-string-system-string)) method takes as an additional parameter a second **string** giving a caption for the **MessageBox**. Thus, the statement,

```C#
MessageBox.Show("Hello world!", "Hello");
```

will display the following modal dialog:

<img src="message-box-with-caption.png" alt="A MessageBox with a caption." style="zoom:67%;" />

Other **Show** methods allow the buttons to be customized. For example, one [**Show**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=windowsdesktop-6.0#system-windows-forms-messagebox-show(system-string-system-string-system-windows-forms-messageboxbuttons)) method takes, as its third parameter, an element from the [**MessageBoxButtons**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messageboxbuttons?view=windowsdesktop-6.0) [enumeration](/appendix/syntax/enumerations). This [enumeration](/appendix/syntax/enumerations) contains the following values:

- **MessageBoxButtons.AbortRetryIgnore**: Buttons labeled "Abort", "Retry", and "Ignore" are shown.
- **MessageBoxButtons.CancelTryContinue**: Buttons labeled "Cancel", "Try Again", and "Continue" are shown.
- **MessageBoxButtons.OK**: A single button labeled "OK" is shown.
- **MessageBoxButtons.OKCancel**: Buttons labeled "OK" and "Cancel" are shown.
- **MessageBoxButtons.RetryCancel**: Buttons labeled "Retry" and "Cancel" are shown.
- **MessageBoxButtons.YesNo**: Buttons labeled "Yes" and "No" are shown.
- **MessageBoxButtons.YesNoCancel**: Buttons labeled "Yes", "No", and "Cancel" are shown.

The values above containing the word, "Cancel", cause the "X" in the upper-right of the dialog to be enabled. Clicking this button in these cases is equivalent to clicking the "Cancel" button. The value, **MessageBoxButtons.OK**, also enables this "X" button, but in this case, clicking this button is equivalent to clicking the "OK" button. Using a **Show** without a **MessageBoxButtons** parameter also gives this behavior. For all other **MessageBoxButtons** values, this "X" button is disabled.

In order to provide appropriate functionality to each of the buttons, each **Show** method returns a value of type [**DialogResult**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.dialogresult?view=windowsdesktop-6.0). This type is another enumeration containing the following values to indicate which button the user clicked:

- **DialogResult.Abort**
- **DialogResult.Cancel**
- **DialogResult.Continue**
- **DialogResult.Ignore**
- **DialogResult.No**
- **DialogResult.None** (this value won't be returned by any of the **Show** methods)
- **DialogResult.OK**
- **DialogResult.Retry**
- **DialogResult.TryAgain**
- **DialogResult.Yes**

Suppose, for example, that we are writing a document formatter or some other application in which the user builds a document. If the user attempts to exit the program when the document is unsaved, we would like to give an opportunity to save the document. We can accomplish this with the following code:

```C#
DialogResult result = MessageBox.Show("The file is not saved. Really quit?", "Confirm Quit", MessageBoxButtons.YesNo);
if (result == DialogResult.Yes)
{
    Application.Exit();
}
```
The first statement displays the following dialog:

<img src="message-box-with-buttons.png" alt="A MessageBox with Yes and No buttons" style="zoom:67%;" />

Again, because the dialog is modal, the **Show** method does not return until the user closes the dialog by clicking one of the two buttons (the "X" in the upper right is disabled). When the user does this, the dialog closes, and the **Show** method returns either **DialogResult.Yes** or **DialogResult.No** to indicate which button the user clicked. If the user clicked the "Yes" button, then the **if**-statement will cause the program to terminate. Otherwise, the program will continue with whatever code follows (probably nothing more, as the program will need to await further user action).

We can also decorate a **MessageBox** with an icon that indicates what type of message it is. This requires another [**Show**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=windowsdesktop-6.0#system-windows-forms-messagebox-show(system-string-system-string-system-windows-forms-messageboxbuttons-system-windows-forms-messageboxicon)) method having a fourth parameter of type [**MessageBoxIcon**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messageboxicon?view=windowsdesktop-6.0). **MessageBoxIcon** is another enumeration. Some of its values are:

- **MessageBoxIcon.Error**:   ![A picture of an error icon should appear here.](messagebox-error.png) 
- **MessageBoxIcon.Information**:   ![A picture of an information icon should appear here.](messagebox-information.png)
- **MessageBoxIcon.None** (no icon)
- **MessageBoxIcon.Warning**: ![A picture of a warning icon should appear here.](messagebox-exclamation.png)

This enumeration contains a few other values as well, but they currently are simply duplicate values for the above icons or values that Microsoft recommends against using. To add a warning icon to the above example, we could replace the first statement with:

```C#
DialogResult result = MessageBox.Show("The file is not saved. Really quit?", "Confirm Quit", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
```

This will display the following dialog:

<img src="message-box-with-icon.png" alt="A MessageBox with an icon." style="zoom:67%;" />

Notice that in the above example, the "Yes" button has the focus; i.e., pressing "Enter" has the same effect as clicking this button. It is usually desirable to have the safest response as the default - in this case, the "No" button. To achieve this, a [**Show**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox.show?view=windowsdesktop-6.0#system-windows-forms-messagebox-show(system-string-system-string-system-windows-forms-messageboxbuttons-system-windows-forms-messageboxicon-system-windows-forms-messageboxdefaultbutton)) method having a fifth parameter, of type [**MessageBoxDefaultButton**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messageboxdefaultbutton?view=windowsdesktop-6.0), is required. **MessageBoxDefaultButton** is another enumeration having the following values to select an appropriate button to be the default:

- **MessageBoxDefaultButton.Button1**
- **MessageBoxDefaultButton.Button2**
- **MessageBoxDefaultButton.Button3**
- **MessageBoxDefaultButton.Button4**

Thus, the following statement:

```C#
DialogResult result = MessageBox.Show("The file is not saved. Really quit?", 
    "Confirm Quit", MessageBoxButtons.YesNo, MessageBoxIcon.Warning,
    MessageBoxDefaultButton.Button2);
```
produces a dialog similar to the one above, but having the "No" button as its default.

There are other **Show** methods that allow additional fine-tuning; however, the ones described here cover most of the functionality. For details on other **Show** methods, see the [documentation for the **MessageBox** class](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.messagebox?view=windowsdesktop-6.0).
