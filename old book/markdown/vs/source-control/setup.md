# Setting up Source Control

Setting up source control with Visual StudioÃ‚Â® requires a few steps:

1.  **Get a MicrosoftÃ‚Â® account.** If you already have a Microsoft
    account, you can go on to Step 2. Otherwise, go to [the Microsoft
    Account web page](http://www.microsoft.com/en-us/account) and click
    the "Create account" button. In the form on that page, the user name
    is any email address you want to use to sign in (you can get a new
    email address from Microsoft by clicking the "Get a new email
    address" link).
2.  **Sign in with Visual Studio.** Click on the "Sign in" button near
    the upper right corner of the Visual Studio window, and sign in on
    the resulting dialog with your account name (i.e., email address)
    and password.
3.  **Create a Visual Studio account.** If you already have a Visual
    Studio account, go on to Step 4. Otherwise, when you have signed in
    with Visual Studio for the first time, you will be presented a
    dialog to create a Visual Studio account. (If you are not given this
    dialog, but you don't already have a Visual Studio account, you can
    go to
    [www.visualstudio.com/en-us/connect-vs.aspx](http://www.visualstudio.com/en-us/connect-vs.aspx),
    click on the "Get started for free" button, and sign in with your
    Microsoft account. **Important:** Do **not** click the "Sign in with
    your work or school account" link.) Supply the required information
    (you don't need to provide a phone number). Fill in the box under
    "Create a Visual Studio Team Services site (optional)" by inserting
    into the blank space the completion of the web address you want to
    use for your Team Foundation Server. You can fill in anything you
    want for this part of the URL, but it will be disallowed if it is
    already taken. **You will need to remember this URL**. After you
    have filled in the required fields, click the "Continue" button.
4.  **Create a source control project.** As described in the section,
    "[Source
    Control](/~rhowell/DataStructures/redirect/version-control)", this
    project will contain all of your assignments for CIS 300 this
    semester. In order to create it, you'll need to get to the "Create
    new team project" dialog. If you created a Visual Studio account in
    step 3, this dialog will be presented to you once this account is
    created. If you skipped step 3, you will need to open the URL for
    your Visual Studio account in a web browser, and sign in if you are
    so prompted. Then click on the "New" link under "Recent projects &
    teams" to open the "Create new team project" dialog. Once you have
    the "Create new team project" dialog, fill it in as follows. At the
    beginning of the semester, you will be given the project name to
    use. Set the process template to "Agile", and select the "Team
    Foundation Version Control" radio button. (**Note:** You *must* use
    Team Foundation Version Control for this class.) Then click the
    "Create project" button.
5.  **Sign in with your web browser.** If your project is a new project
    for a pre-existing Visual Studio account, go on to Step 6.
    Otherwise, after your project has been created, you will be sent an
    email informing you that your account is ready. In that message,
    click on the link to your account URL. This will take you to your
    Visual Studio account in your web browser. (**Note:** If you don't
    get this email right away, try opening the URL you created above for
    your Visual Studio account - you will probably be able to access
    it.)
6.  **Add members to your project.** In order for the graders and
    instructor to be able to access your work, they will need to be
    added to your project. To do this, if you have created a new Visual
    Studio account, click the "Browse" link under "Recent projects &
    teams", select the project you created above, and click the
    "Navigate" button; otherwise, simply click the "Navigate to project"
    button on the dialog presented to you when you created your project.
    If you then get a "Congratulations" popup - just close it. On the
    resulting page, find the "Team Members" section, and click on the
    "Invite a friend" button. In the resulting popup, click the "Add..."
    button and fill in the email addresses of the graders (you will be
    given these in lab), then click the "Save changes" button (don't
    worry if it indicates "no identities found"). If you enetered the
    email address correctly, each of the graders' names should appear
    under "Display Name"; however, if a name does not show, you will
    need to click the "Remove" link to the right and try again.
    (**Note:** You should *not* add any users other than those
    associated with CIS 300 grading and instruction.) Once you have
    successfully added all the graders, click the "Close" button.
7.  **Connect with Visual Studio.** To connect to your project with
    Visual Studio, within your project page in your web browser, click
    on the link, "Open in Visual Studio". Depending on your browser, you
    may get a dialog asking you to confirm that you want to run a
    program - confirm this. This will open another instance of Visual
    Studio with the "Team Explorer" window open (you might as well close
    the first instance of Visual Studio at this point).
8.  **Configure your workspace.** In the Visual Studio Team Explorer on
    the right, you will see two boxes under "Configure Workspace". To
    the right of the *second* of these boxes, click the "..." button and
    navigate to a folder where you want to keep all your assignments for
    the semester (the default location is fine, but in any case, if you
    are using a lab machine, it should be a sub-folder within the folder
    `C:\Users`, and within the sub-folder having your login name). Then
    click the "Map & Get" button. You should see a message near the top
    of the Team Explorer window: "The workspace was mapped
    successfully."

At this point, source control is set up and ready to use. Whenever you
open Visual Studio on this machine, you should have access to all of
your managed solutions, as described in the next section.
