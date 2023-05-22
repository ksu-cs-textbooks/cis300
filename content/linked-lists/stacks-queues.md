+++
title = "Implementing Stacks and Queues with Linked Lists"
weight = 20

pre = "<b>4.2. </b>"
+++

## Implementing Stacks and Queues with Linked Lists

Because linked lists store data elements in linear sequences, they can
be used to give alternative implementations of stacks and queues. One
advantage to using linked lists is that we don't have to worry about
filling up something like an array - we can just keep allocating cells
as long as we need to (unless we run out of memory).

Implementing a stack using a linked list is particularly easy because
all accesses to a stack are at the top. One end of a linked list, the
beginning, is always directly accessible. We should therefore arrange
the elements so that the top element of the stack is at the beginning of
the linked list, and the bottom element of the stack is at the end of
the linked list. We can represent an empty stack with **null**.

We therefore need a **private LinkedListCell\<T\>** field to implement a
generic stack **Stack\<T\>** using a linked list. This field will refer
to the cell containing the data item at the top of the stack. A **public
Count** property will be used to keep track of the number of elements in
the stack.

The **public** methods **Push**, **Peek**, and **Pop** are then fairly
straightforward to implement. For **Push** we need to add the given
element to a new cell at the beginning of the linked list, as shown in
[the previous
section](/linked-lists/intro), and
update the **Count**. To implement **Peek**, if the stack is nonempty,
we simply return the **Data** property of the cell at the beginning of
the linked list; otherwise, we throw an **InvalidOperationException**.
To implement **Pop**:

1.  Using **Peek**, obtain the element to be returned;
2.  Remove the first element from the linked list as shown in [the
    previous
    section](/linked-lists/intro);
3.  Update the **Count**; and
4.  Return the retrieved value.

Implementing a queue is a little more involved because we need to
operate at both ends of the linked list. For efficiency, we should keep
a reference to the last cell in the linked list, as this will allow us
to access both ends of the linked list directly. We will therefore have
the following:

![Implementing a queue with a linked list](linked-list-queue.jpg)

We now need to decide which end to make the front of the queue. As we
saw in [the previous
section](/linked-lists/intro), both
inserting and removing can be done efficiently at the beginning of a
linked list. Likewise, it is easy to insert an element at the end if we
have a reference to the last cell. Suppose, for example, that `last`
refers to the last cell in a linked list, and that `cell` refers to a
**LinkedListCell\<T\>** that we want to insert at the end. Suppose
further that the linked list is not empty (that will be a special case
that we'll need to handle). Thus, we have the following:

![A cell to insert at the end of a linked
list](linked-list-insert-end-1.jpg)

To insert this cell at the end of the linked list, we just need to copy
the reference in `cell` to the **Next** property of the cell to which
`last` refers:
```C#
last.Next = cell;
```
On the other hand, removing the last cell is problematic, even if we
have a reference to it. The problem is that in order to remove it from
the linked list, we need to change the **Next** property of the
preceding cell. Unfortunately, the only way to obtain that cell is to
start at the beginning of the list and work our way through it. If the
linked list is long, this could be quite inefficient. 

{{% notice note %}}
It doesn't help any to keep a reference to the next-to-last cell, as
we encounter the same problem when we need to update this reference
after removing the last cell --- we don't have a reference to its
preceding cell.
{{% /notice %}}

Because we need to
remove elements from the front of a queue, but not from the back, we
conclude that it will work best to make the beginning of the linked list
the front of the queue. We therefore need the following **private**
fields to implement a generic queue **Queue\<T\>**:

  - A **LinkedListCell\<T\>** giving the element at the front of the
    queue. This will be the beginning of the linked list of queue
    elements.
  - A **LinkedListCell\<T\>** giving the element at the back of the
    queue. This will be the last cell in the linked list of queue
    elements.

As we mentioned earlier, adding an element to an empty queue is a
special case that we will need to handle separately. For this reason, it
doesn't matter what values the two **LinkedListCell\<T\>** fields
contain when the queue is empty - we can always detect when the queue is
empty by checking the **Count**. The initialization of the two
**LinkedListCell\<T\>** fields is therefore unimportant. It is easiest
to just leave them **null**.

Let us now consider the implementation of the **Enqueue** method. We
need to consider two cases. We'll first consider the case in which the
queue is empty. In this case, we need to build the following linked
list:

![A queue containing a single linked list cell](one-cell-queue.jpg)

We therefore need to:

1.  Construct a new **LinkedListCell\<T\>**;
2.  Assign it to the field denoting the front of the queue;
3.  Assign it to the field denoting the back of the queue;
4.  Store the given element in its **Data** property; and
5.  Update the **Count**.

If the queue is nonempty, the only step that changes is Step 2. Because
the queue is nonempty, we don't want to make the new cell the front of
the queue; instead, we need to insert it at the end of the linked list,
as outlined above.

The implementations of the **Peek** and **Dequeue** methods are
essentially the same as the implementations of the **Peek** and **Pop**
methods, respectively, for a stack.

The implementations described in this section are simpler than the
implementations using arrays, mainly due to the fact that we don't need
to rebuild the structure when we fill up the space available. While
these implementations are also pretty efficient, it turns out that the
array-based implementations tend to out-perform the linked-list-based
implementations. This might be counterintuitive at first because
rebuilding the structures when the array is filled is expensive.
However, due to the fact that we double the size of the array each time
we need a new one, this rebuilding is done so rarely in practice that it
ends up having minimal impact on performance. Due to hardware and
low-level software issues, the overhead involved in using arrays usually
ends up being less.
