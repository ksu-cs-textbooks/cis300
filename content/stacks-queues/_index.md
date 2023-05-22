+++
title = "Stacks and Queues"
weight = 30

pre = "<b>3. </b>"
+++

## Stacks and Queues

Often in solving problems, we need to access data items in a particular
order. Consider, for example, the action of an "Undo" operation in a
text editor, spreadsheet, or similar application. If we want to be able
to undo a sequence of these operations, we need to record each operation
as it is done. When we want to undo an operation, we need to retrieve
the operation to undo from the recorded sequence of operations. However,
we don't want to undo just any operation in this sequence - we need to
undo the most recent one that hasn't yet been undone. We therefore need
to access the operations in *last-in-first-out*, or *LIFO*, order. Other
applications might need to access data items in *first-in-first-out*, or
*FIFO*, order. In this chapter, we will examine data structures that
support these kinds of access.
