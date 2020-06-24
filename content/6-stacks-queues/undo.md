# Implementing Undo and Redo for a TextBox

A **TextBox** has a rather crude Undo/Redo feature. By right-clicking on
a **TextBox**, a popup menu containing an Undo entry is presented. This
Undo will undo only one action, which may include several edits. An
immediate subsequent Undo will undo the Undo - in essence, a Redo. The
same behavior can be achieved using Ctrl+Z. A more powerful Undo/Redo
feature would allow an arbitrary sequence of edits to be undone, with
the option of redoing any of these Undo operations. This section
outlines various ways of implementing such a feature.

We first observe that when we perform an Undo, we want to undo the most
recent edit that has not been undone; i.e., we need LIFO access to the
edits. Likewise, when we perform a Redo, we want to redo the most recent
Undo that has not been redone. Again, we need LIFO access to the Undo
operations. We will therefore use two stacks, one to keep the edit
history, and one to keep the Undo history (i.e., the history of Undo
operations that can be redone).

Before we can define these stacks, we need to determine what we will be
storing in them; i.e., we need to determine how we will represent an
edit. We will consider several ways of doing this, but the simplest way
is to store the entire contents of the **TextBox** after each edit.
Proceeding in this way, we really aren't representing edits at all, but
we certainly would have the information we need to undo the edits.
Likewise, the Undo history would store the entire contents of the
**TextBox** prior to each Undo. Because the contents of the **TextBox**
form a **string**, we need two **private** fields, each referring to a
stack of **string**s:

    /// <summary>
    /// The history of the contents of the TextBox.
    /// </summary>
    private Stack<string> _editingHistory = new Stack<string>();
    
    /// <summary>
    /// The history of TextBox contents that have been undone and can be redone.
    /// </summary>
    private Stack<string> _undoHistory = new Stack<string>();

Before we can proceed to implementing the Undo and Redo operations, we
need to do a bit more initialization. Note that by the way we have
defined `_editingHistory`, this stack needs to contain the initial
contents of the **TextBox**. Therefore, assuming the **TextBox** field
is named `uxDisplay`, we need to add the following line to the end of
the constructor of our user interface:

    _editingHistory.Push(uxDisplay.Text);

In order to support Undo and Redo, we need to be able to record the
content of `uxDisplay` each time it is modified. We can do this via an
event handler for the **TextChanged** event on the **TextBox**. Because
this event is the default event for a **TextBox**, we can add such an
event handler by double-clicking on the **TextBox** within the Visual
Studio® Design window. This event handler will then be called every
time the contents of the **TextBox** are changed.

We need to deal with one important issue before we can write the code
for this event handler. Whenever we perform an Undo or Redo operation,
we will change the contents of the **TextBox**. This will cause the
**TextChanged** event handler to be called. However, we don't want to
treat an Undo or a Redo in the same way as an edit by the user. For
example, if the user does an Undo, we don't want that Undo to be
considered an edit, or a subsequent Undo would just undo the Undo; i.e.,
it would perform a Redo rather than an Undo.

Fortunately, there is an easy way to distinguish between an edit made by
the user and a change made by the program code. A **TextBox** has a
[**Modified**](http://msdn.microsoft.com/en-us/library/system.windows.forms.textboxbase.modified.aspx)
property, which is set to **true** when the user modifies the
**TextBox** contents, and is set to **false** when the program modifies
the contents. Thus, we only want to record the **TextBox** contents when
this property is **true**. Assuming the **TextBox** is named
`uxDisplay`, we can then set up the event handler as follows:

    /// <summary>
    /// Handles a TextChanged event on the TextBox.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void uxDisplay_TextChanged(object sender, EventArgs e)
    {
        if (uxDisplay.Modified)
        {
            RecordEdit();
        }
    }

Now let's consider how to write the `RecordEdit` method. Suppose there
are two GUI controls (e.g., menu items or buttons) called `uxUndo` and
`uxRedo`, which invoke the Undo and Redo operations, respectively. These
controls should be enabled only when there are operations to undo or
redo. Thus, initially these controls will be disabled. Whenever the user
modifies the contents of the **TextBox**, we need to do the following:

  - Push the resulting text onto `_editingHistory`.
  - Enable `uxUndo`, as there is now an edit that can be undone.
  - Clear the contents of `_undoHistory`, as the last change to the
    **TextBox** contents was not an Undo. (A **Stack\<T\>** has a
    [**Clear**](http://msdn.microsoft.com/en-us/library/3278tedw\(v=vs.110\).aspx)
    method for this purpose.)
  - Disable `uxRedo`.

We therefore have the following method:

    /// <summary>
    /// Records an edit made by the user.
    /// </summary>
    private void RecordEdit()
    {
        _editingHistory.Push(uxDisplay.Text);
        uxUndo.Enabled = true;
        _undoHistory.Clear();
        uxRedo.Enabled = false;
    }

Now that we have a mechanism for recording the user's edits, we can
implement the Undo operation. The contents of the **TextBox** following
the last edit (i.e, the current contents of the **TextBox**) should
always be at the top of `_editingHistory`. An Undo should change the
current contents to the previous contents - i.e., to the *next*
**string** on `_editingHistory`. However, we don't want to lose the top
**string**, as this is the **string** that would need to be restored by
a subsequent Redo. Instead, we need to push this **string** onto
`_undoHistory`. We then need to enable `uxRedo`. In order to determine
whether `uxUndo` should be enabled, we need to know how many elements
remain in `_editingHistory`. We know there is at least one **string** on
this stack - the **string** that we placed in the **TextBox**. There is
an edit to undo if there is at least one more element on this stack -
i.e., if its **Count** is greater than 1. We therefore have the
following event handler for a Click event on `uxUndo`:

    /// <summary>
    /// Handles a Click event on Undo.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void uxUndo_Click(object sender, EventArgs e)
    {
        _undoHistory.Push(_editingHistory.Pop());
        uxRedo.Enabled = true;
        uxDisplay.Text = _editingHistory.Peek();
        uxUndo.Enabled = _editingHistory.Count > 1;
    }

The implementation of Redo is similar, but now we need to transfer a
**string** between the stacks in the opposite direction - we move the
top **string** from `_undoHistory` to `_editingHistory`. Then `uxRedo`
should be enabled if any more **string**s remain in `_undoHistory`. The
**string** we removed from `_undoHistory` should be placed in the
**TextBox**. Finally, `uxUndo` should be enabled. We therefore have the
following event handler for a Click event on `uxRedo`:

    /// <summary>
    /// Handles a Click event on Redo.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void uxRedo_Click(object sender, EventArgs e)
    {
        _editingHistory.Push(_undoHistory.Pop());
        uxRedo.Enabled = _undoHistory.Count > 0;
        uxDisplay.Text = _editingHistory.Peek();
        uxUndo.Enabled = true;
    }

This solution will work, except that an Undo or Redo always brings the
text caret to the beginning of the **TextBox** contents. Furthermore, if
the **TextBox** contains a long **string**, each edit causes a long
**string** to be placed onto `_editingHistory`. This can quickly eat up
a lot of memory, and may eventually fill up all available storage. In
what follows, we will outline two better approaches.

The idea for both of these approaches is that instead of recording the
entire contents of the **TextBox** for each edit, we only record a
description of each edit. A single edit will either be an insertion or a
deletion of some text. The number of characters inserted/deleted may
vary, as the edit may be a cut or a paste (if we select a block of text
and do a paste, the **TextChanged** event handler is actually called
twice - once for the deletion of the selected text, and once for the
insertion of the pasted text). We can therefore describe the edit with
the following three values:

  - A **bool** indicating whether the edit was an insertion or a
    deletion.
  - An **int** giving the index of the beginning of the edit.
  - The **string** inserted or deleted.

We can maintain this information in stacks in one of two ways. One way
is to use non-generic stacks and to push three items onto a stack for
each edit. If we do this, we need to realize that when we pop elements
from the stack, they will come out in reverse order from the way they
were pushed onto it. Alternatively, we can define a class or a
[structure](/~rhowell/DataStructures/redirect/structs) to represent an
edit using the three values above as **private** fields. We can then use
generic stacks storing instances of this type.

Whichever way we choose to represent the edits, we need to be able to
compute each of the three pieces of information describing the edit. In
order to compute this information, we need to compare the current
contents of the **TextBox** with its prior contents in order to see how
it changed. This means that, in addition to the two **private** fields
we defined for the stacks, we will also need a **private** field to
store the last **string** we saw in the **TextBox**. Rather than
initializing `_editingHistory` within the constructor, we should now
initialize this **string** in its place (because there will have been no
edits initially, both stacks should initially be empty). If we keep this
**string** field up to date, we will always have a "before" picture (the
contents of this field) and an "after" picture (the current contents of
the **TextBox**) for the edit we need to record.

To determine whether the edit was an insertion or a deletion, we can
compare the lengths of the current **TextBox** contents and its previous
contents. If the current content is longer, then the edit was an
insertion; otherwise, the edit was a deletion. We therefore have the
following method for this purpose:

    /// <summary>
    /// Returns whether text was deleted from the given string in order to obtain the contents
    /// of the given TextBox.
    /// </summary>
    /// <param name="editor">The TextBox containing the result of the edit.</param>
    /// <param name="lastContent">The string representing the text prior to the edit.</param>
    /// <returns>Whether the edit was a deletion.</returns>
    private bool IsDeletion(TextBox editor, string lastContent)
    {
        return editor.TextLength < lastContent.Length;
    }

Note that the above code uses the **TextBox**'s
[**TextLength**](http://msdn.microsoft.com/en-us/library/system.windows.forms.textboxbase.textlength\(v=vs.110\).aspx)
property. This is more efficient than finding the length of its **Text**
property because evaluating the **Text** property requires all the
characters to be copied to a new **string**.

Before getting either the location of the edit or the edit string
itself, it is useful to compute the length of the edit string. This
length is simply the absolute value of the difference in the lengths of
the **string** currently in the **TextBox** and the last **string** we
saw there. The
[**Math**](http://msdn.microsoft.com/en-us/library/system.math\(v=vs.110\).aspx)
class (in the
[**System**](http://msdn.microsoft.com/en-us/library/System\(v=vs.110\).aspx)
namespace) contains a
[**static**](/~rhowell/DataStructures/redirect/static-this) method
[**Abs**](http://msdn.microsoft.com/en-us/library/dk4666yx\(v=vs.110\).aspx),
which computes the absolute value of an **int**. We therefore have the
following method:

    /// <summary>
    /// Gets the length of the text inserted or deleted.
    /// </summary>
    /// <param name="editor">The TextBox containing the result of the edit.</param>
    /// <param name="lastContent">The string representing the text prior to the edit.</param>
    /// <returns>The length of the edit.</returns>
    private int GetEditLength(TextBox editor, string lastContent)
    {
        return Math.Abs(editor.TextLength - lastContent.Length);
    }

Now that we can determine whether an edit is a deletion or an insertion,
and we can find the length of the edit string, it isn't hard to find the
beginning of the edit. First, suppose the edit is a deletion. The point
at which the deletion occurred is the point at which the text caret now
resides. We can find this point using the **TextBox**'s
[**SelectionStart**](http://msdn.microsoft.com/en-us/library/system.windows.forms.textboxbase.selectionstart\(v=vs.110\).aspx)
property. When there is no current selection - and there never will be
immediately following an edit - this property gives the location of the
text caret in the **TextBox**. Now consider the case in which the edit
was an insertion. When text is inserted into a **TextBox**, the text
caret ends up at the *end* of the inserted text. We need to find its
beginning. We can do this by subtracting the length of the edit string
from the text caret position. We therefore have the following method:

    /// <summary>
    /// Gets the location of the beginning of the edit.
    /// </summary>
    /// <param name="editor">The TextBox containing the result of the edit.</param>
    /// <param name="isDeletion">Indicates whether the edit was a deletion.</param>
    /// <param name="len">The length of the edit string.</param>
    /// <returns>The location of the beginning of the edit.</returns>
    private int GetEditLocation(TextBox editor, bool isDeletion, int len)
    {
        if (isDeletion)
        {
            return editor.SelectionStart;
        }
        else
        {
            return editor.SelectionStart - len;
        }
    }

The last piece of information we need is the **string** that was deleted
or inserted. If the edit was a deletion, this **string** can be found in
the previous **TextBox** contents. Its beginning is the point at which
the edit occurred. We can therefore extract the deleted **string** from
the previous contents using its
[**Substring**](http://msdn.microsoft.com/en-us/library/aka44szs\(v=vs.110\).aspx)
method. We pass this method the beginning index of the substring and its
length, and it returns the substring, which is the deleted **string**.
On the other hand, if the edit was an insertion, we can find the
inserted **string** in the current **TextBox** contents by using its
**Substring** in a similar way. We therefore have the following method:

    /// <summary>
    /// Gets the edit string.
    /// </summary>
    /// <param name="content">The current content of the TextBox.</param>
    /// <param name="lastContent">The string representing the text prior to the edit.</param>
    /// <param name="isDeletion">Indicates whether the edit was a deletion.</param>
    /// <param name="editLocation">The location of the beginning of the edit.</param>
    /// <param name="len">The length of the edit.</param>
    /// <returns>The edit string.</returns>
    private string GetEditString(string content, string lastContent, bool isDeletion, int editLocation, int len)
    {
        if (isDeletion)
        {
            return lastContent.Substring(editLocation, len);
        }
        else
        {
            return content.Substring(editLocation, len);
        }
    }

Using the methods above, we can modify the **RecordEdit** method to
obtain the three values listed above to describe an edit. Once we have
placed these three values onto the stack of editing history, we also
need to update the **string** giving the previous **TextBox** contents.
This should now be the current **TextBox** contents. We can then finish
the method as shown above.

In order to implement Undo and Redo, we need to be able to insert and
delete text in the **TextBox**. A **string** has two methods we can use
to accomplish this:

  - The
    [**Remove**](http://msdn.microsoft.com/en-us/library/d8d7z2kk.aspx)
    method takes as its parameters the beginning index and length of the
    portion to remove, and returns the result.
  - The
    [**Insert**](http://msdn.microsoft.com/en-us/library/system.string.insert.aspx)
    method takes as its parameters the index at which the **string**
    should be inserted, and the **string** to insert. It returns the
    result.

Given the location of the edit along with the edit string itself, we can
easily provide the parameters to the appropriate method above.
Furthermore, it is not hard to set the location of the text caret using
the **TextBox**'s **SelectionStart** property - we just need to be sure
to add the length of the edit string if we are inserting text. The
following method therefore performs a given edit, updating the
**string** containing the last contents of the **TextBox** as well (we
assume this **string** is called `_lastText`):

    /// <summary>
    /// Performs the given edit on the contents of the given TextBox.
    /// </summary>
    /// <param name="editor">The TextBox to edit.</param>
    /// <param name="isDeletion">Indicates whether the edit is a deletion.</param>
    /// <param name="loc">The location of the beginning of the edit.</param>
    /// <param name="text">The text to insert or delete.</param>
    private void DoEdit(TextBox editor, bool isDeletion, int loc, string text)
    {
        if (isDeletion)
        {
            _lastText = editor.Text.Remove(loc, text.Length);
            editor.Text = _lastText;
            editor.SelectionStart = loc;
        }
        else
        {
            _lastText = editor.Text.Insert(loc, text);
            editor.Text = _lastText;
            editor.SelectionStart = loc + text.Length;
        }
    }

We can now implement event handlers for Undo and Redo. We can obtain the
description of the edit from the stack of editing history for an Undo,
or from the stack of undo history for a Redo. This description gives us
the type of edit (i.e., either insertion or deletion), the beginning
position of the edit, and the inserted or deleted **string**. To
implement a Redo, we simply do this edit, but to implement an Undo, we
must do the opposite.
