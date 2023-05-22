+++
title = "Input/Output"
weight = 10

pre = "<b>1. </b>"
+++

## Input/Output

Input and output are central concepts to computing - in order to be able
to accomplish a computational task, a program must typically process
some input and produce some output. Input and output may be presented in
a variety of ways. For example, many programs communicate with users
through a graphical user interface, or GUI. In the simplest case, the
user performs some action, such as clicking the mouse on a button, thus
signaling an *event*. A method in the program then responds to that
event by reading information that the user has typed into various
controls on the GUI, and processes that information. It may then provide
output to the user by writing results to various controls on the GUI.

Such a simple presentation of input/output (or I/O) is far too limiting,
however. For example, other mechanisms such as *dialogs* - secondary
windows designed for exchanging specific information - may be used to
avoid cluttering the main window. In other cases, the amount of data
that needs to be exchanged is too large to be transferred through a GUI.
In such cases, the program may need to read and/or write a file. This
chapter addresses these more advanced I/O mechanisms.
