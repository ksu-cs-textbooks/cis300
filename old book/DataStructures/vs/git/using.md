<div class="NAVBAR">

[Next: Using Multiple
Machines](/~rhowell/DataStructures/redirect/multiple-machines)      
[Previous: Setting up Source
Control](/~rhowell/DataStructures/redirect/source-control-setup)      
[Up: Source Control](/~rhowell/DataStructures/redirect/version-control)
      [Top](/~rhowell/DataStructures/)

</div>

# Submitting Assignments

To use Git with a lab or homework assignment in this course, you will
need both a repository on GitHub and a local Git repository on your
machine for that assignment. Each lab and homework assignment will
contain a URL to be used to set up the repository on GitHub. Point a web
browser to this URL, and click on the "Accept this assignment" button.
This will create on GitHub a repository containing the start code for
this assignment. A web page for interacting with this repository will be
displayed in your browser.

To create a local Git repository, click on Visual Studio's Team Explorer
tab (or open Team Explorer from the View menu), and click on the icon
that resembles an electrical plug at the top of the window. Scroll down
if necessary to "Local Git Repositories", and click on "Clone" at the
top of that section. In your web browser, navigate to the GitHub
repository that you created for this assignment, and click on the "Clone
or download" button. This will display a URL - click on the button to
its right to copy this URL to your clipboard. Then go back to Visual
Studio and paste this URL into the Team Explorer in the text box
labeled, "Enter the URL of a Git repo to clone \<Required\>". In the
text box below that, fill in a new folder you want to use for this
repository on your machine, then click the "Clone" button. This will
copy the Git repository from GitHub into the folder you selected, and
add it to the list of local Git repositories in the Team Explorer. It
will also open the Solution Explorer to show the contents of the
repository. To open the solution contained in this repository,
double-click on its name in this list.

To submit your assignment, you will need to do the following steps:

1.  **Commit** your changes. Do this by clicking the icon that looks
    like a pencil at the bottom of the Visual Studio window. The Team
    Explorer will now show a window titled, "Changes". In the yellow
    box, type in a message to be associated with the changes you are
    committing. Then click "Commit All".
2.  **Push** your committed changes to GitHub. Do this by clicking the
    up-arrow icon at the bottom of the Visual Studio window. This will
    cause the Team Explorer to open. Click the "Push" link to push the
    repository to GitHub.
3.  Submit the URL of the commit you want graded. To do this, reload the
    GitHub repository in your web browser, and click on the link showing
    the number of commits (this is just above the thick green horizontal
    line). This will show a list of commits, beginning with the latest.
    To the right of each commit is a button labeled "\<\>". This button
    links to a web page displaying the entire contents of that commit.
    The URL of this page will end in a 40-digit hexadecimal number
    giving a digital fingerprint of the commit. Copy this URL to the
    submission form at the bottom of the assignment instructions (you
    will have needed to click the "Submit Assignment" button at the top
    of these instructions to reveal this form).
4.  For a lab assignment, enter your completed code or your attempted
    code into the Comments box in the assignment submission form. (You
    don't need to enter anything in this box for a homework assignment.)
    If you need to provide additional information with your submission,
    you can do so in this box.
5.  To complete your submission, click the "Submit Assignment" button in
    the assignment submission form. The time at which this button was
    clicked will be the official submission time for your assignment.

Note that it is important to do all three of these steps in this order.
In particular, if you make any changes between your last commit and the
push, these changes won't be included in the submission. You can
double-check that all changes have been pushed by looking at the numbers
next to the up-arrow and pencil icons at the bottom of the Visual Studio
window. If all changes have been pushed, both numbers should be 0. It is
also important to include the correct URL. In particular, the digital
fingerprint of the commit is the only reliable evidence we have that the
commit was made prior to the form submission.

The next two sections describe some additional ways that you might want
to use source control in this class.

<div class="NAVBAR">

[Next: Using Multiple
Machines](/~rhowell/DataStructures/redirect/multiple-machines)      
[Previous: Setting up Source
Control](/~rhowell/DataStructures/redirect/source-control-setup)      
[Up: Source Control](/~rhowell/DataStructures/redirect/version-control)
      [Top](/~rhowell/DataStructures/)

</div>

<span class="small">Last modified: Thu Jul 27 04:44:16 CDT 2017</span>

<span class="small">*© Copyright 2014, 2015, 2016, 2017, [Rod
Howell](/~rhowell/). All rights reserved.*</span>

|                                                                                            |
| :----------------------------------------------------------------------------------------: |
| [![Valid HTML 4.01\!](/~rhowell/valid-html401.gif)](http://validator.w3.org/check/referer) |
|   [![Valid CSS\!](/~howell/vcss.gif)](http://jigsaw.w3.org/css-validator/check/referer)    |
