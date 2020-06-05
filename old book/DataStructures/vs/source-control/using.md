<div class="NAVBAR">

[Next: Troubleshooting Source
Control](/~rhowell/DataStructures/redirect/troubleshooting-source-control)
      [Previous: Setting up Source
Control](/~rhowell/DataStructures/redirect/source-control-setup)      
[Up: Source Control](/~rhowell/DataStructures/redirect/version-control)
      [Top](/~rhowell/DataStructures/)

</div>

# Using Source Control

To create a new solution under source control, proceed as you normally
would, but in the "New Project" dialog, select as the location a new
folder (named something like "Lab 2" or "Homework 3", as appropriate)
within the folder you selected when you configured your workspace (see
"[Setting up Source
Control](/~rhowell/DataStructures/redirect/source-control-setup)"), and
check the "Add to source control" box.

To add an existing solution to source control, you will first need to
make sure that it is located within your source control folder (you can
move the entire containing folder if necessary). Then open that
solution, and in the Solution Explorer, right-click on the solution
name, and select "Add Solution to Source Control..." from the resulting
popup menu.

Simply placing a solution under source control won't upload anything to
the server - it just defines this solution as one you want to manage.
When you have code that you want to upload, either to submit it for
grading or just to checkpoint it, from the Solution Explorer,
right-click on the solution name and click, "Check In...". This will
open the Team Explorer showing Pending Changes. In the "Comment"
section, you can provide a comment. This comment should be descriptive
of this version of the program so that you can find it later if you are
looking for it. Then click the "Check In" button, and click "Yes" on the
resulting Check-in Confirmation dialog. If all goes well, this will
upload this version of your solution to your Visual Studio account. As
you are editing your code, you can periodically check in versions in
this way so that you can access them later if need be (there is no limit
to the storage available to you on your Visual Studio account). Within
the Solution Explorer, a blue "Checked-in" icon will appear next to each
part of your solution that is unchanged since its last check-in, and a
red "Checked-out" icon will appear next to each part that has been
changed since its last check-in. Thus, you can readily tell if your
entire solution has been uploaded - there will be a blue "Checked-in"
icon next to each source code file (as well as various other
components), as shown in the following figure.

![A picture of the SolutionExplorer window should appear
here.](checked-in.jpg)

Each time you submit an assignment for grading, it is important to
verify that the "Checked-in" icon appears next to each source code file,
as sometimes a check-in doesn't check in the entire solution, even if
you've done it correctly - see [the next
section](/~rhowell/DataStructures/redirect/troubleshooting-source-control)
for details.

If you want to access your checked-in code from a different machine,
first open Visual Studio, then open the Team Explorer window (you can
always find it via the View menu if you don't see a tab for it). In the
Team Explorer, click on the "Manage Connections" icon at the top:

![A picture of the Team Explorer window should appear
here.](manage-connections.jpg)

Then click on the "Manage Connections" link, and select "Connect to Team
Project" from the resulting popup menu. In the resulting dialog, click
the "Servers..." button in the upper right-hand corner. In the
subsequent dialog, click the "Add..." button in the upper right-hand
corner. This will open yet another dialog, in which you can type the URL
of your Visual Studio account. Then click the "OK" button. You will then
be prompted for the user name (i.e., your email address) and password
for your Visual Studio account. Once you have signed in, you can close
the "Add/Remove Team Foundation Server" dialog. At this point, the
"Connect to Team Foundation Server" dialog will list your source control
projects - check the box next to the one you want (there will probably
only be one), and click the "Connect" button. You will then need to
configure your workspace as outlined in step 8 in "[Setting up Source
Control](/~rhowell/DataStructures/redirect/source-control-setup)". This
will download the contents of the project to your workspace.
Furthermore, if you subsequently check in a solution on one machine, you
can propagate the changes to the other as follows:

  - Open the solution on the machine you want to update.
  - In the Solution Explorer, right-click on the solution name, and
    select "Get Latest Version (Recursive)".

You can also access the latest version of any solution via the Source
Control Explorer, which you can access from the Team Explorer window (if
you don't see it, click the icon that looks like a house at the top, and
it should appear). This window allows you to browse all projects on your
Visual Studio account. You can open the latest version of any solution
by double-clicking it.

Now suppose that at some point in writing a program, you decide you want
to look at an earlier version that you checked in. There are several
ways to do this. First, you can right-click on the file you want in the
Solution Explorer and select "Source Control‑\>View History". This will
open a window listing the different versions of this file, together with
the date and time each was checked in and the comment that was supplied
for the check-in. One way of viewing a specific version is to
right-click on that entry in the list and select "Compare..." from the
popup menu. This will open a window displaying the checked-in version of
this file on the left and the current version on the right. Code that
was removed from the checked-in version is highlighted in pink, and code
in the current version that has been added is highlighted in green. Code
can be copy-pasted from the earlier version to the current version.

Sometimes you may want to revert back to an earlier version of a file.
First, it would be a good idea to check in the current version, just in
case (this also tends to avoid conflicts that you may need to resolve).
To obtain an earlier version of a file, go back to the History window
for that file, right-click on the version you want, and select "Get This
Version". That version will then be opened in Visual Studio as the
current version.

Alternatively, you may want to revert an entire solution to an earlier
version. To do this, right-click on the solution in the Solution
Explorer, and select "Source Control‑\>Get Specific Version...". If you
want to revert back to the latest version that was checked in by a
specific date and time, in the resulting dialog, set the type to "Date",
fill in the date and time you want, and click the "Get" button. Or if
you want to browse the available changesets, set the type to
"Changeset", click the "..." button, optionally narrow down your search
by a range of changeset numbers or times, and click the "Find" button.
This will list all matching changesets, together with their checkin
times and comments. Select the one you want to revert to by
double-clicking, then clicking the "Get" button.

If you check in a solution after you have reverted to an earlier
version, conflicts may be detected. To resolve these conflicts, you will
usually want to click the "Keep Local Version" button. This will cause
the current version you are working on to be checked in as the current
version on the server. (Nothing on the server will be deleted - you can
still revert back to other versions.) Once you have resolved the
conflicts, you will need to try to check it in again.

It is important to realize that once you have checked in files, they are
difficult to delete by accident. Thus, frequent check-ins might save you
from a number of problems that might occur.

There are a lot of other things you can do with source control, but most
are useful mainly for collaboration on projects. The functionality
described here is likely sufficient for your needs in CIS 300.

<div class="NAVBAR">

[Next: Troubleshooting Source
Control](/~rhowell/DataStructures/redirect/troubleshooting-source-control)
      [Previous: Setting up Source
Control](/~rhowell/DataStructures/redirect/source-control-setup)      
[Up: Source Control](/~rhowell/DataStructures/redirect/version-control)
      [Top](/~rhowell/DataStructures/)

</div>

<span class="small">Last modified: Wed Jul 27 03:51:59 CDT 2016</span>

<span class="small">*© Copyright 2014, 2015, 2016, [Rod
Howell](/~rhowell/). All rights reserved.*</span>

|                                                                                            |
| :----------------------------------------------------------------------------------------: |
| [![Valid HTML 4.01\!](/~rhowell/valid-html401.gif)](http://validator.w3.org/check/referer) |
|   [![Valid CSS\!](/~howell/vcss.gif)](http://jigsaw.w3.org/css-validator/check/referer)    |
