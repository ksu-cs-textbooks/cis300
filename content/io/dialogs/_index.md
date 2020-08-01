+++
title = "Dialogs"
date = 2018-08-24T10:53:05-05:00
weight = 21
chapter = true
pre = "<b>1.1. </b>"
+++


## Dialogs

Dialogs are windows displayed by a program for the purpose of exchanging
specific information with the user. There are two kinds of dialogs:

  - *Modal* dialogs block all other interaction with the program until
    the dialog is closed.
  - *Non-modal* dialogs allow the user to interact with the program in
    other ways while the dialog is open.

We will examine three classes provided by the Microsoft® .NET
Framework, each of which implements a modal dialog. The .NET Framework
provides various other classes, such as
[**FolderBrowserDialog**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.folderbrowserdialog?view=netframework-4.7.2),
[**FontDialog**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.fontdialog?view=netframework-4.7.2),
and
[**ColorDialog**](https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.colordialog?view=netframework-4.7.2),
that also implement specific kinds of dialogs. We conclude by discussing
how custom dialogs may be built using Visual Studio®.
