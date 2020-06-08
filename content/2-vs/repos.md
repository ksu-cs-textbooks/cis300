# Git Repositories

In CIS 300, start code for each assignment will be distributed via a Git
repository. Git is a *source control* system integrated into Visual
Studio 2017. Source control systems are powerful mechanisms for teams of
programmers and other collaborators to manage multiple copies of various
source files and other documents that all collaborators may be
modifying. While CIS 300 does not involve teamwork, source control
provides a convenient mechanism for distribution of code and submission
of assignment solutions. In addition, as we will discuss later in this
chapter, source control provides mechanisms for accessing your code on
multiple machines and for "checkpointing" your code.

At the heart of Git is the concept of a Git repository. A Git repository
is simply a folder on your local machine. As you make changes within
this folder, Git tracks these changes. From time to time, you will
*commit* these changes. If you see that you have gone down a wrong path,
you can *revert* to an earlier commit.

Git repositories may be hosted on a server such as [GitHub](github.com).
Various users may have copies of a Git repository on their own local
machines. Git provides tools for synchronizing local repositories with
the repository hosted on the server in a consistent way.

For each lab and homework assignment in CIS 300, you will be provided a
URL that will create your own private Git repository on GitHub. The only
people who will have access to your GitHub repositories are you, the CIS
300 instructors, and the CIS 300 lab assistants. These repositories will
initially contain start code and perhaps data files for the respective
assignments. You will copy the repository to your local machine by
*cloning* it. When you are finished with the assignment, you will *push*
the repository back to GitHub and submit its URL for grading. In what
follows, we will explain how to create and clone a GitHub repository.
Later in this chapter, we will explain how to commit changes, push a
repository, and use some of the other features of Git.

Before you can access GitHub, you will need a GitHub account. If you
don't already have one, you can sign up for one at
[github.com](github.com). At some point after you have completed the
sign-up process, GitHub will send you an email asking you to verify the
email address you provided during the sign-up process. After you have
done this, you will be able to set up GitHub repositories.

For each assignment in CIS 300, you will be given an invitation URL,
such as:

  - <https://classroom.github.com/a/qSZ6_g_W>

If you click on the above link, you may be asked to sign in to GitHub.
Once you are signed in, you will be shown a page asking you to accept
the assignment. Clicking the "Accept this assignment" button will create
a GitHub repository for you. You will be given a link that will take you
to that repository. From that page you will be able to view all of the
files in the repository.

In order to be able to use this repository, you will need to clone it to
your local machine. To do this, first open Visual Studio 2017, then find
the Team Explorer panel (if you don't see it, you can open it from the
View menu). In the Team Explorer, click on the icon that resembles an
electrical plug at the top of the window. Scroll down if necessary to
"Local Git Repositories", and click on "Clone" at the top of that
section. In your web browser, navigate to the GitHub repository that you
wish to clone, and click on the "Clone or download" button. This will
display a URL - click on the button to its right to copy this URL to
your clipboard. Then go back to Visual Studio and paste this URL into
the Team Explorer in the text box labeled, "Enter the URL of a Git repo
to clone \<Required\>". In the text box below that, fill in a new folder
you want to use for this repository on your machine, then click the
"Clone" button. This will copy the Git repository from GitHub into the
folder you selected, and add it to the list of local Git repositories in
the Team Explorer. It may also open the Solution Explorer to show the
contents of the repository.

The following sections give an overview of how to use Visual Studio to
edit and debug an application, as well as how to use Git within Visual
Studio to maintain the local Git repository and syncronize it with the
GitHub repository.
