+++
title = "Chapter 4.1 Dialogs"
date = 2018-08-24T10:53:05-05:00
weight = 21
chapter = true
pre = "<b>4.1 </b>"
+++


# Dialogs

Dialogs are windows displayed by a program for the purpose of exchanging
specific information with the user. There are two kinds of dialogs:

  - *Modal* dialogs block all other interaction with the program until
    the dialog is closed.
  - *Non-modal* dialogs allow the user to interact with the program in
    other ways while the dialog is open.

We will examine three classes provided by the MicrosoftÃ‚Â® .NET
Framework, each of which implements a modal dialog. The .NET Framework
provides various other classes, such as
[**FolderBrowserDialog**](http://msdn.microsoft.com/en-us/library/system.windows.forms.folderbrowserdialog\(v=vs.110\).aspx),
[**FontDialog**](http://msdn.microsoft.com/en-us/library/system.windows.forms.fontdialog\(v=vs.110\).aspx),
and
[**ColorDialog**](http://msdn.microsoft.com/en-us/library/system.windows.forms.colordialog\(v=vs.110\).aspx),
that also implement specific kinds of dialogs. We conclude by discussing
how custom dialogs may be built using Visual StudioÃ‚Â®.
