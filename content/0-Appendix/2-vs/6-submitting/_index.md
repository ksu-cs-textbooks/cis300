---
title: "Submitting Assignments"
pre: "6. "
weight: 30
date: 2018-08-24T10:53:26-05:00
---

To submit a lab or homework assignment in CIS 300, you will need to do the following steps:

1.  **Refresh** the changes tracked by Git. Do this by going to the
    Team Explorer and clicking on the circular arrow icon (i.e., <img
    style="padding: 0px; display: inline; ! important" src="git-refresh-icon.JPG" alt="A picture of an icon should appear here."> at the top. Note that this refresh is normally done automatically; however, it occasionally is not. Doing this manual refresh helps to ensure that all of your code gets uploaded.

2.  **Commit** your changes to your local Git repository. Do this by clicking the icon that looks like a pencil at the bottom of the Visual Studio window. The Team Explorer will now show a window titled, "Changes". In the yellow box, type in a message to be associated with the changes you are committing. Then click "Commit All".

3.  **Push** your committed changes to GitHub. Do this by clicking the up-arrow icon at the bottom of the Visual Studio window. This will cause the Team Explorer to open. Click the "Push" link to push the repository to GitHub. Note that *only committed changes will be pushed*.

4.  **Submit** the URL of the commit you want graded and (for lab assignments) your completed or attempted code using the submission form provided in the assignment instructions. This requires the following steps:

    1.  To reveal the submission form, click the "Submit Assignment" button at the top of the assignment instructions. This will cause the submission form to appear at the bottom of the page.

    2.  Reload the GitHub repository for this assignment in your web browser, and click on the link showing the number of commits (this is just above the thick green horizontal line). This will show a list of commits, beginning with the latest. To the right of each commit is a button labeled "\<\>". This button links to a web page displaying the entire contents of that commit. (It's a good idea to check to see that all of your source code files are present, in case something went wrong.) The URL of this page will end in a 40-digit hexadecimal number giving a digital fingerprint of the commit. Copy this URL to the submission form.

    3.  For a lab assignment, enter your completed code (8 digits) or your attempted code (4 digits) into the Comments box in the assignment submission form. (You don't need to enter anything in this box for a homework assignment.) If you need to provide additional information with your submission, you can do so in this box.

    4.  To complete your submission, click the "Submit Assignment" button in the assignment submission form. The time at which this button was clicked will be the official submission time for your assignment.

Note that it is important to do all four of these steps in this order. In particular, if you make any changes between your last commit and the push, these changes won't be included in the submission. You can double-check that all changes have been pushed by looking at the numbers next to the up-arrow and pencil icons at the bottom of the Visual Studio window. If all changes have been pushed, both numbers should be 0. It is also important to include the correct URL. In particular, the digital fingerprint of the commit is the only reliable evidence we have that the commit was made prior to the form submission; hence, this digital fingerprint is required in order for you to receive any credit for the assignment.

Occasionally, problems can occur with the interface between Visual Studio and GitHub. These problems can prevent your code from being pushed to GitHub. While the problems can often be fixed, it is often easier to bypass Visual Studio altogether, and use GitHub's file upload mechanism. Please note that this is not the preferred assignment submission procedure because it is less automated (and hence more error-prone), and it creates a commit on GitHub that is not in your local git repository. However, it can be used if the above procedure doesn't work for you. To use this alternative submission procedure, do the following steps:

1.  If Visual Studio is running, exit this application, making sure all files are saved.

2.  In your web browser, navigate to the repository for the assignment you are submitting. You should see a list of files and folders, including a file whose name ends with ".sln".

3.  In your Windows file browser, navigate to your project folder for this assignment. You should see the same list of files and folders as is shown in your web browser. (Depending on the settings for your local machine, you may not see file name suffixes such as ".sln" and ".gitignore", and if you've added any projects that were not in the original repository, their folders may be shown in the file browser but not in the web browser.)

4.  In your web browser, click the "Upload files" button in the row of buttons above the list of files and folders.

5.  In your file browser, type Control-"A" to select all files and folders, and drag them to the web browser where it says, "Drag files here ...". The web browser should indicate a number of files being uploaded.

6.  Near the bottom of the web browser window, in the text box below "Commit changes", type a commit message, then click the "Commit changes" at the bottom. It may take a little while to process, but eventually you should see the repository again.

7.  Make sure all of your ".cs" files are present in the GitHub repository, and that they contain the code you want. (If you have removed or renamed any files, the original files may still be in the repository; however, they shouldn't be in the solution, and therefore shouldn't interfere with the program's execution.)

8.  Submit the URL of this commit by following Step 4 above.
