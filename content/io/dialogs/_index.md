+++
title = "Dialogs"
weight = 21

pre = "<b>1.1. </b>"
+++


## Dialogs

Dialogs are windows displayed by a program for the purpose of exchanging specific information with the user. There are two kinds of dialogs:

- *Modal* dialogs block all other interaction with the program until the dialog is closed.
- *Non-modal* dialogs allow the user to interact with the program in other ways while the dialog is open.

We will examine three classes provided by Microsoft® .NET 6, each of which implements a modal dialog. .NET provides various other classes, such as [**FolderBrowserDialog**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.folderbrowserdialog?view=windowsdesktop-6.0), [**FontDialog**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.fontdialog?view=windowsdesktop-6.0), and [**ColorDialog**](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.colordialog?view=windowsdesktop-6.0), that also implement specific kinds of dialogs. We conclude by discussing how custom dialogs may be built using Visual Studio®.
