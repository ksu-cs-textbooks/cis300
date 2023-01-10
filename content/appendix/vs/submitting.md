+++
title = "Submitting Assignments"
date = 2018-08-24T10:53:05-05:00
weight = 70
chapter = true
pre = "<b>A2.7. </b>"
+++

## Submitting Assignments

To submit a lab or homework assignment in CIS 300, you will need to do the following steps:

1.  **Commit** your changes to your local Git repository. You will do this through the "Git Changes" tab in Visual Studio (if you don't see this tab, click the icon that looks like a pencil at the bottom of the
    Visual Studio window). In the "Git Changes" tab, in the box that says "Enter a message \<Required\>", type in a message to be
    associated with the changes you are committing. Then click "Commit
    All". A message at the top of the "Git Changes" tab will indicate whether the commit was successful.
    
3.  **Push** your committed changes to GitHub. Do this by clicking the
    up-arrow icon at the top of the "Git Changes" tab. Note that *only committed changes will be pushed*. A message at the top of the "Git Changes" tab will indicate whether the push was successful.
    
4.  **Submit** the URL of the commit you want graded using the submission
    form provided in the assignment instructions. This requires the
    following steps: 
    -   Reload the GitHub repository for this assignment in your web
        browser, and click on the link showing the number of commits
        (this is in the top right corner of the list of files and
        folders in the repository). This
        will show a list of commits, beginning with the latest. To the
        right of each commit is a button labeled "\<\>". This button
        links to a web page displaying the entire contents of that
        commit. (It's a good idea to check to see that all of your
        source code files are present, in case something went wrong.)
        The URL of this page will end in a 40-digit hexadecimal number
        giving a digital fingerprint of the commit. Copy this *entire URL* to
        the submission form at the bottom of the assignment. 
    -   To complete your submission, click the "Submit Assignment"
        button in  the assignment submission form. The time at which
        this button was clicked will be the official submission time
        for your assignment. 

{{% notice warning %}}
It is important to do all three of these steps in this order. In
particular, if you make any changes between your last commit and the
push, these changes won't be included in the submission. It is also important to include the correct URL. 
{{% /notice %}}

{{% notice tip %}}
You can double-check that all changes have been pushed by looking at
the numbers next to the up-down-arrows and pencil icons at the bottom of the
Visual Studio window. If all changes have been pushed, all numbers
should be 0.
{{% /notice %}}

Occasionally, problems can occur with the interface between Visual
Studio and GitHub. These problems can prevent your code from being
pushed to GitHub. While the problems can often be fixed, it is often
easier to bypass Visual Studio altogether, and use GitHub's file
upload mechanism. 

{{% notice warning %}}
This is not the preferred assignment submission procedure because it
is less automated (and hence more error-prone), and it creates a
commit on GitHub that is not in your local git repository. However, it
can be used if the above procedure doesn't work for you. 
{{% /notice %}}

To use this alternative submission procedure, do the following steps:

1.  If Visual Studio is running, exit this application, making sure all files are saved.

2.  In your web browser, navigate to the repository for the assignment you are submitting. You should see a list of files and folders, including a file whose name ends with ".sln".

3.  In your Windows file browser, navigate to your project folder for this assignment. You should see the same list of files and folders as is shown in your web browser. (Depending on the settings for your local machine, you may not see file name suffixes such as ".sln" and ".gitignore", and if you've added any projects that were not in the original repository, their folders may be shown in the file browser but not in the web browser.)

4.  In your web browser, click the "Add file" button in the row of
    buttons above the list of files and folders, and select 
    "Upload files" from the drop-down menu.

5.  In your file browser, type Control-"A" to select all files and folders, and drag them to the web browser where it says, "Drag files here ...". The web browser should indicate a number of files being uploaded.

6.  Near the bottom of the web browser window, in the text box below "Commit changes", type a commit message, then click the "Commit changes" at the bottom. It may take a little while to process, but eventually you should see the repository again.

7.  Make sure all of your ".cs" files are present in the GitHub repository, and that they contain the code you want. (If you have removed or renamed any files, the original files may still be in the repository; however, they shouldn't be in the solution, and therefore shouldn't interfere with the program's execution.)

8.  Submit the URL of this commit by following Step 3 of the assignment submission process given above.