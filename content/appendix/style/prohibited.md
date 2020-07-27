+++
title = "Prohibited Features"
date = 2018-08-24T10:53:05-05:00
weight = 50
chapter = true
pre = "<b>A3.5 </b>"
+++

## Prohibited Features

The following features of C\# should not be used on assignments or exams unless otherwise stated:

- **The goto statement:** It has been over 45 years since Dijkstra published ["Go To Statement Considered Harmful"](http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF) (*Communications of the ACM*, vol. 11 (1968), pp. 147-148). I am
amazed that languages continue to include this statement.
- **The unsafe keyword:** The name pretty much says it all.
- **The var keyword:** There are very few contexts in which this is needed, and these contexts won't occur in this class. For all other contexts, it makes the code less readable.
- **Virtual methods:** These are useful in large-scale software development; however, they are overused. They will not be needed in the programming we will be doing. (However, virtual methods in the .NET class library may be [overridden](/~rhowell/DataStructures/redirect/method-overriding).)
- **Extension methods:** These methods are not defined within the class on which they operate, but elsewhere. Consequently, they tend to be much less efficient than the methods defined within the class. If the Visual Studio® auto-complete gives you a method that looks like it gives you what you want, first click on it and take a look at its popup documentation. If it is an extension method, this documentation will begin with "(extension)".
