# Source Control

<div class="TOC">

## Contents

1.  [Setting up Source
    Control](/~rhowell/DataStructures/redirect/source-control-setup)
2.  [Submitting
    Assignments](/~rhowell/DataStructures/redirect/using-source-control)
3.  [Using Multiple
    Machines](/~rhowell/DataStructures/redirect/multiple-machines)
4.  [Checkpointing](/~rhowell/DataStructures/redirect/checkpointing)

</div>

Source control systems are powerful mechanisms for teams of programmers
and other collaborators to manage multiple copies of various source
files that all may be modifying. CIS 300 does not involve teamwork, but
we will be using source control as a mechanism for assignment
submission. There are several benefits to using the source control
provided by Visual Studio:

  - It is easy to ensure that all required files have been submitted.
  - It is easy to "checkpoint" your programs - if at some point you
    discover you've gone down a wrong path and want to retrieve code
    that you have since modified, you can do this easily.
  - You can access your uploaded code from any machine with Visual
    Studio 2015 and internet access.
  - You will get an introduction to a technology that's indispensable
    for the professional programmer.

In this class, you will be using Git, one of the most popular source
control systems. You will use Git to upload your code to
[GitHub](http://github.com), a widely used repository for open-source
software. GitHub also supports private repositories, where you will be
uploading your assignments - only you and the course instructor and
assistants will have access to your repositories. Model solutions and
start code for some of the assignments will also be distributed via
GitHub.

Git is a *distributed* source control system. This means that everyone
who uses a Git repository has a local copy of that repository. If you
use more than one machine, you can keep a local copy of each repository
on each machine. You will have a Git repository for each of your
assignments. As you write your code, you will from time to time *commit*
your code to your local repository. If you see that you have gone down a
wrong path, you can *revert* to an earlier commit. When you are ready to
upload your code, you will *push* it to GitHub.

The remainder of this section describes how to set up and use source
control. The sections "[Setting up Source
Control"](/~rhowell/DataStructures/redirect/source-control-setup) and
"[Submitting
Assignments](/~rhowell/DataStructures/redirect/using-source-control)"
contain all you will need for submitting your assignments. The next two
sections describe additional features of Git that can help you to
develop code on multiple machines and to checkpoint your code.
