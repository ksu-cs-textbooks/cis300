---
title: "Checkpointing"
pre: "4. "
weight: 20
date: 2018-08-24T10:53:26-05:00
---

Sometimes when writing code, we see that we have gone down a wrong path and would like to undo some major changes we have made. Source control can help us with this if we _checkpoint_ by committing our changes from time to time, using commit messages that clearly describe the changes made in that commit.  (Note that it is not necessary to push these commits to GitHub until you are ready to submit the assignment.)  Git's _revert_ feature allows us to undo any of these commits.

To access Git's revert feature, open the Visual Studio Team Explorer, click on the icon that looks like a house at the top, and click on "Changes".  Within the  resulting "Changes" window, click on "Actions", and select "View History..." from the resulting drop-down list.  This will reveal a list of all the commits for this local Git repository, with the most recent commit listed at the top.  To undo all of the changes in any commit, right-click on that commit, and select "Revert" from the popup menu.  The result is automatically committed. 

Note that reverting a commit only undoes changes made within that commit.  If code changed in that commit was changed again later, this may result in a conflict that will need to be resolved as described in [the previous section](/~rhowell/DataStructures/redirect/multiple-machines). 

Sometimes what you really want to do is to roll your code back to a previous state.  If you have any uncommitted changes, you will first want to discard them by going to the "Changes" window as described above, right-clicking on the top folder in the "Changes" section, and selecting "Undo Changes..." from the resulting popup menu.  You will then be given a confirmation dialog.  Once you have discarded these changes, you can revert commits starting with the most recent, and working back to the point you want.  Note that because each revert is also a commit, you can later revert a reverted commit if necessary.

It is also possible to undo changes to a specific file, rather than in the entire solution.  You can obtain a history of the commits on a specific file by going to the Solution Explorer, right-clicking on that file, and selecting "View History..." from the resulting popup menu.  You can then revert any of these commits as above.  You can also discard uncommitted changes to a single file by right-clicking on that file in the "Changes" list and selecting "Undo Changes..." from the resulting popup menu.  Be careful, however, about undoing or discarding changes on a ".Designer.cs" file, as usually when you make changes in the designer, changes are also made to the file, Resources.resx.
