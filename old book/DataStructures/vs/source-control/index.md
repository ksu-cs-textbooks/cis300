<div class="NAVBAR">

[Next: Setting up Source
Control](/~rhowell/DataStructures/redirect/source-control-setup)      
[Previous: The Debugger](/~rhowell/DataStructures/redirect/debugger)
      [Up: Visual
Studio®](/~rhowell/DataStructures/redirect/visual-studio)      
[Top](/~rhowell/DataStructures/)

</div>

# Source Control

<div class="TOC">

## Contents

1.  [Setting up Source
    Control](/~rhowell/DataStructures/redirect/source-control-setup)
2.  [Using Source
    Control](/~rhowell/DataStructures/redirect/using-source-control)
3.  [Troubleshooting Source
    Control](/~rhowell/DataStructures/redirect/troubleshooting-source-control)

</div>

Source control systems are powerful mechanisms for teams of programmers
and other collaborators to manage multiple copies of various source
files that all may be modifying. CIS 300 does not involve teamwork, but
we will be using it as a mechanism for assignment submission - your
"collaborators" will be the graders. There are several benefits to using
the source control provided by Visual Studio:

  - It is more reliable than K-State Online.
  - It is easy to ensure that all required files have been submitted.
  - It is easy to "checkpoint" your programs - if at some point you
    discover you've gone down a wrong path and want to retrieve code
    that you have since modified, you can do this easily.
  - You can access your checked-in code from any machine with Visual
    Studio 2015 and internet access.
  - You will get an introduction to a technology that's indispensable
    for the professional programmer.

In this class, you will be using Microsoft's Team Foundation Version
Control. This source control system uses a Team Foundation Server to
store the code under source control. When you set up source control, you
will define a web address where your Team Foundation Server will manage
your code. Only you and your collaborators (i.e., the graders) will have
access to your code.

The code managed on a Team Foundation Server is organized into
*projects*. These projects are different from Visual Studio projects
(see "[Visual Studio
Projects](/~rhowell/DataStructures/redirect/new-project)"). In
particular, all of your code for this class will be placed in the same
Team Foundation Server project. This project will be *mapped* to a
*workspace*, which is simply a folder, on each of your local machines
(i.e., the server you use in lab and any of your own machines you want
to use). The workspace will mirror the files and folders in the project
mapped to it, although the workspace may also contain files and folders
that have not been uploaded to the project.

The Team Foundation Server provides much more functionality than simply
a mirror for your workspace. The main feature we will be using is that
whenever new versions of a file or folder are uploaded, they don't
replace the old version - all uploaded versions are maintained with
timestamps giving the dates and times when they were uploaded. Because
these timestamps are maintained by the remote server, they are
trustworthy evidence of when the files were uploaded.

Because the Team Foundation Server keeps all versions of a file or
folder, deleting, moving, or renaming a file or folder after it has been
uploaded is problematic. In fact, it is something that should be
avoided. If something needs to be renamed or deleted after it has been
uploaded, it is often best to make a copy of the entire folder (named
something like, "Lab 3 - redo") and make the required changes before
uploading the new folder.

The remainder of this section describes how to set up, use, and
troubleshoot source control.

<div class="NAVBAR">

[Next: Setting up Source
Control](/~rhowell/DataStructures/redirect/source-control-setup)      
[Previous: The Debugger](/~rhowell/DataStructures/redirect/debugger)
      [Up: Visual
Studio®](/~rhowell/DataStructures/redirect/visual-studio)      
[Top](/~rhowell/DataStructures/)

</div>

<span class="small">Microsoft and Visual Studio are either registered
trademarks or trademarks of Microsoft Corporation in the United States
and/or other countries.</span>

<span class="small">Last modified: Tue Jul 26 04:49:03 CDT 2016</span>

<span class="small">*© Copyright 2014, 2015, 2016, [Rod
Howell](/~rhowell/). All rights reserved.*</span>

|                                                                                            |
| :----------------------------------------------------------------------------------------: |
| [![Valid HTML 4.01\!](/~rhowell/valid-html401.gif)](http://validator.w3.org/check/referer) |
|   [![Valid CSS\!](/~howell/vcss.gif)](http://jigsaw.w3.org/css-validator/check/referer)    |
