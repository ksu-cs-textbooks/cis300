<div class="NAVBAR">

[Previous: Using Source
Control](/~rhowell/DataStructures/redirect/using-source-control)      
[Up: Source Control](/~rhowell/DataStructures/redirect/version-control)
      [Top](/~rhowell/DataStructures/)

</div>

# Troubleshooting Source Control

One of the advantages of source control is that it provides a reliable
repository of all the work you have checked in. Once you have
successfully checked in a version of a solution, it will remain
available on the Team Foundation Server. However, for a variety of
reasons, it occasionally becomes difficult to check in what you need to.
This section gives some tips on troubleshooting check-in difficulties.

Often the easiest way to troubleshoot a check-in problem is to copy the
folder containing your solution (e.g., the folder named "Homework 2") to
a new folder (e.g., "Homework 2 Redo") within your workspace. Then open
the new copy of the solution, add it to source control, and try checking
it in. If this check-in is successful, the checked in code will appear
in the new folder (e.g., "Homework 2 Redo") on the server, and any
previously checked-in code will appear in the old folder (e.g.,
"Homework 2"). Don't worry about trying either to delete the old folder
or to give the new folder the proper name.

Sometimes Visual Studio will fail to check in a solution because it is
trying to check in one or more files that it can't find. Usually, these
are files that you don't even want to check in, often because you have
deleted them. To tell Visual Studio to ignore these files, look in the
Pending Changes window of the Team Explorer (i.e., the window that
appears when you try to check in a solution), and find the section,
"Included Changes". For any file(s) that should not be checked in,
right-click on the file, and select "Exclude" from the resulting popup
menu. This will remove that file from the "Included Changes" list, and
place it in the "Excluded Changes" list below, so that Visual Studio
will not try to check it in.

Similarly, if a file you want to check in does not get checked in with
the rest of the solution, it might be because it is in the "Excluded
Changes" list. To move it back to the "Included Changes" list,
right-click on its entry in the "Excluded Changes" list, and select
"Include" from the resulting popup menu.

Sometimes you may find that Visual Studio is trying to use Git, rather
than TFS. As a result, you may be unable to check in your code. When
this happens, the Team Explorer Home window looks like this:

![A picture of the Team Explorer should appear
here](team-explorer-git.jpg)

If you have not yet added your solution to source control, you may be
able to fix this by doing the following:

1.  In the Team Explorer, click on the "Manage Connections"icon shown
    below:
    
    ![A picture of the Team Explorer should appear
    here](manage-connections.jpg)

2.  Find your TFS project and double-click it.

If you have already added it to source control, the process is a bit
more involved:

1.  In your Windows File Explorer, navigate to your workspace and make a
    copy of the folder containing the solution you are trying to check
    in. Paste the copy in your workspace.
2.  Navigate to the folder (within the copy you just made) that contains
    the solution file.
3.  Set your File Explorer to reveal hidden files. To do this in Windows
    10, click on the View tab and make sure the box next to "Hidden
    items" is checked.
4.  Delete the folders ".git" and ".vs".
5.  Open the solution file in this folder with Visual Studio.
6.  In the Team Explorer, click on "Manage Connections" icon (see
    above).
7.  Find your TFS project and double-click it. Sign in if you are so
    prompted.

You should now be able to add your solution to source control and check
it in.

<div class="NAVBAR">

[Previous: Using Source
Control](/~rhowell/DataStructures/redirect/using-source-control)      
[Up: Source Control](/~rhowell/DataStructures/redirect/version-control)
      [Top](/~rhowell/DataStructures/)

</div>

<span class="small">Last modified: Sat Oct 8 15:32:10 CDT 2016</span>

<span class="small">*© Copyright 2016, [Rod Howell](/~rhowell/). All
rights reserved.*</span>

|                                                                                            |
| :----------------------------------------------------------------------------------------: |
| [![Valid HTML 4.01\!](/~rhowell/valid-html401.gif)](http://validator.w3.org/check/referer) |
|   [![Valid CSS\!](/~howell/vcss.gif)](http://jigsaw.w3.org/css-validator/check/referer)    |
