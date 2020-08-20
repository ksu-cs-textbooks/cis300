+++
title = "File Dialogs"
date = 2018-08-24T10:53:05-05:00
weight = 30
chapter = true
pre = "<b>1.1.2. </b>"
+++

## File Dialogs

The [**System.Windows.Forms**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms?view=netframework-4.7.2) namespace contains two other classes that implement modal dialogs for obtaining file names from the user. These classes are [**OpenFileDialog**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.openfiledialog?view=netframework-4.7.2), which is designed to obtain the name of a file to read, and [**SaveFileDialog**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.savefiledialog?view=netframework-4.7.2), which is designed to obtain the name of a file to write. Because we often need to obtain the name of a file prior to doing file I/O, it is appropriate to consider these classes now.

Although these dialogs are visually separate from the window from which they are opened, it is possible (and usually desirable) to add instances of these classes to a form from [the Design window](/appendix/vs/design-window). Both can be found in the "Dialogs" section of the Toolbox. They can be added to the form simply by double-clicking on their names. They will not appear on the form itself, but in a separate area of the Design window. Their properties can then be modified in the same way as any other control. We will discuss some of these properties a bit later in what follows.

Each of these classes has a method called **ShowDialog** that takes no parameters. For example, if we call the [**ShowDialog**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.commondialog.showdialog?view=netframework-4.7.2#System_Windows_Forms_CommonDialog_ShowDialog) method of an **OpenFileDialog**, a dialog resembling the following will be opened:

![A picture of a file dialog should appear here.](open-file-dialog.png)

Similarly, calling the **ShowDialog** method of a **SaveFileDialog** opens a dialog resembling the following:

![A picture of a file dialog should appear here.](save-file-dialog.png)

Because these dialogs are modal, the method call will not return until the user closes the dialog. It will then return a [**DialogResult**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.dialogresult?view=netframework-4.7.2) indicating how the user closed the form - either **DialogResult.OK** or **DialogResult.Cancel** (see [the previous section](/io/dialogs/message-boxes) for more information on the **DialogResult** type). Therefore, if `uxFileDialog` is a variable referring to a file dialog, we typically use the following code template to display it:

```C#
if (uxFileDialog.ShowDialog() == DialogResult.OK)
{
    // Process the file
}
```

Thus, if the user selects a file, we process it; otherwise, we do nothing. In some cases, we might include an **else** containing code that needs to be executed if the user closes the dialog without selecting a file.

Processing a file will be discussed in the three sections that follow. However, one thing we will certainly want to do prior to processing the file is to obtain the file name that the user selected (after all, this is the reason we display a file dialog). We can obtain this file name via the dialog's [**FileName**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.filedialog.filename?view=netframework-4.7.2#System_Windows_Forms_FileDialog_FileName) [property](/appendix/syntax/properties); for example,

```C#
string fileName = uxFileDialog.FileName;
```

Note that this and other properties are accessible for initialization purposes through a file dialog's Properties window in the Designer. This is useful for an **OpenFileDialog**'s **FileName** property, as the default supplied by Visual Studio® is rather odd. Other properties that we might want to initialize here (in addition to **(Name)**, the name of the variable referring to the dialog) include:

- [**Title**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.filedialog.title?view=netframework-4.7.2#System_Windows_Forms_FileDialog_Title), the title of the dialog (by default, "Open" for an **OpenFileDialog** or "Save As" for a **SaveFileDialog**).

- [**Filter**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.filedialog.filter?view=netframework-4.7.2#System_Windows_Forms_FileDialog_Filter),     a *filter string*, which controls what file types will be displayed. An example of a filter string is: `C# files|*.cs|All files|*.*`. A filter string consists of an even number of components separated by vertical bars ("|"). Thus, the above filter string consists of four components. These components are grouped into pairs. The first component of each pair gives the string that will be displayed in the dialog to describe what files are displayed. The second component of each pair describes a pattern of file names to be displayed when the first component of that pair is shown. Use an asterisk ("\*") in a pattern to denote any sequence of characters. The "." in a pattern ending in ".\*" does not need to be matched - a file without an extension will be listed if it matches the pattern to the left of the ".". Multiple patterns, separated by semicolons (";"), may be listed in one component. Thus, the above filter string describes two filters that the user may choose from. The first filter is labeled, "C\# files", and lists all files ending in ".cs". The second filter is labeled "All files", and lists all files.

- [**FilterIndex**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.filedialog.filterindex?view=netframework-4.7.2#System_Windows_Forms_FileDialog_FilterIndex) indicates which pair in the filter string is currently being used. Note that the first pair has an index of 1, not 0.

- [**AddExtension**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.filedialog.addextension?view=netframework-4.7.2#System_Windows_Forms_FileDialog_AddExtension) and [**DefaultExt**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.filedialog.defaultext?view=netframework-4.7.2#System_Windows_Forms_FileDialog_DefaultExt) control the dialog's behavior when the user types in a file name without an extension. When this happens, if a filter with a unique extension is chosen, that extension will be appended, regardless of the values of these two properties. Otherwise, if **AddExtension** is **True**, the value of **DefaultExt** will be appended, following a ".".

Other properties allow further customization of file dialogs. For more
details, see the [**OpenFileDialog**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.openfiledialog?view=netframework-4.7.2) and [**SaveFileDialog**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.savefiledialog?view=netframework-4.7.2) documentation.
