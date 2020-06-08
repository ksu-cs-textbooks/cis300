# Submitting Assignments

To use Git with a lab or homework assignment in this course, you will
need both a repository on GitHub and a local Git repository on your
machine for that assignment. Each lab and homework assignment will
contain a URL to be used to set up the repository on GitHub. Point a web
browser to this URL, and click on the "Accept this assignment" button.
This will create the repository on GitHub. A web page for interacting
with this repository will be displayed in your browser, and a link to
this page will be added to your GitHub home page. If the assignment
requires you to write a complete program, this repository will be empty,
and its web page will contain instructions on how to push a local Git
repository to it. The most important part of these instructions is the
URL provided in the "Quick setup" section - we will discuss its use
shortly. On the other hand, if the assignment provides you with start
code, this start code will be contained in the repository and shown as
links on its web page.

The way to create a local Git repository for an assignment depends on
whether the assignment provides you with any start code. If not, create
a new solution as you normally would, but in the "New Project" dialog,
check the "Create new Git repository" box. If you don't see such a box,
don't worry about it - the repository can be created after the project
is created; however, DO NOT check the "Add to source control" box, as
this would set up your project to use Team Foundation Source Control
instead of Git.

If you were unable to create a new Git repository when you created the
solution, click the "Publish" button in the lower right corner of of the
Visual Studio window, and select "Git". This will create your local Git
repository.

To create a local Git repository for an assignment that provides start
code, click on Visual Studio's Team Explorer tab (or open Team Explorer
from the View menu), and click on the icon that resembles an electrical
plug at the top of the window. Scroll down if necessary to "Local Git
Repositories", and click on "Clone" at the top of that section. In your
web browser, navigate to the GitHub repository that you created for this
assignment, and click on the "Clone or download" button. This will
display a URL - click on the button to its right to copy this URL to
your clipboard. Then go back to Visual Studio and paste this URL into
the Team Explorer in the text box labeled, "Enter the URL of a Get repo
to clone \<Required\>". In the text box below that, fill in the folder
you want to use for this program on your machine, then click the "Clone"
button. This will copy the Git repository from GitHub into the folder
you selected, and add it to the list of local Git repositories in the
Team Explorer. To open the solution contained in this repository,
right-click on its name in this list, and select "Open". This will cause
a single solution to be displayed in the Team Explorer - double-click
this solution to open it in Visual Studio.

To submit your assignment, you will need to do the following three
steps:

1.  **Commit** your changes. Do this by clicking the icon that looks
    like a pencil at the bottom of the Visual Studio window. The Team
    Explorer will now show a window titled, "Changes". In the yellow
    box, type in a message to be associated with the changes you are
    committing. Then click "Commit All".
2.  **Push** your committed changes to GitHub. Do this by clicking the
    up-arrow icon at the bottom of the Visual Studio window. This will
    cause the Team Explorer to open. If the GitHub repository is
    nonempty, you can simply click "Push" in the Team Explorer. If the
    GitHub repository is empty, however, a bit more work is required,
    because Visual Studio does not yet have the location of your GitHub
    repository. In the Team Explorer, scroll down if necessary to
    "Publish to Remote Repository", and click the "Publish Git Repo"
    button in that section. In a web browser, navigate to the GitHub
    repository for this assignment. Under "Quick setup", make sure
    "HTTPS" is selected, and click the button to the right of the text
    box to copy the URL to your clipboard. Then go back to the Visual
    Studio Team Explorer and paste the URL into the text box labeled,
    "Enter the URL of an empty Git repo \<required\>". Then click the
    "Publish" button.
3.  **Comment** the last commit. Reload the GitHub repository in your
    web browser, and click on the link to the right of "Latest commit"
    at the top right of the list of files. Then scroll down to the
    bottom of the resulting page to a box labeled, "Leave a comment." In
    this box, enter the required information for this assignment. For
    lab assignments, this will be used for your Completed or Attempted
    code, which indicates the score you should receive for the
    assignment. For homework assignments, this provides a reliable time
    stamp for the submission.

Note that it is important to do all three of these steps in this order.
In particular, if you make any changes between your last commit and the
push, these changes won't be included in the submission. You can
double-check that all changes have been pushed by looking at the numbers
next to the up-arrow and pencil icons at the bottom of the Visual Studio
window. If all changes have been pushed, both numbers should be 0.

The next two sections describe some additional ways that you might want
to use source control in this class.
