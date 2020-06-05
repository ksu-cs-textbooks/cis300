<div class="NAVBAR">

[Next: Introduction to
Tries](/~rhowell/DataStructures/redirect/tries-intro)       [Up:
Trees](/~rhowell/DataStructures/redirect/trees)      
[Top](/~rhowell/DataStructures/)

</div>

# Tries

<div class="TOC">

## Contents

1.  [Introduction to
    Tries](/~rhowell/DataStructures/redirect/tries-intro)
2.  [Multiple Implementations of
    Children](/~rhowell/DataStructures/redirect/tries-multiple-impl)
3.  [Traversing a
    Trie](/~rhowell/DataStructures/redirect/traversing-tries)
4.  [Tries in Word Games](/~rhowell/DataStructures/redirect/word-games)

</div>

[AVL trees](/~rhowell/DataStructures/redirect/avl-trees) give us an
efficient mechanism for storage and retrieval, particularly if we need
to be able to process the elements in order of their keys. However,
there are special cases where we can achieve better performance. One of
these special cases occurs when we need to store a list of words, as we
might need in a word game, for example. For such applications, a *trie*
provides for even more efficient storage and retrieval.

In this section, we first define a trie and give a rather
straightforward implementation. We then show how to improve performance
by implementing different nodes in different ways. We then examine the
use of a preorder traversal to traverse a trie. We conclude by
discussing an example of using a trie in a word game.

<div class="NAVBAR">

[Next: Introduction to
Tries](/~rhowell/DataStructures/redirect/tries-intro)       [Up:
Trees](/~rhowell/DataStructures/redirect/trees)      
[Top](/~rhowell/DataStructures/)

</div>

<span class="small">Last modified: Fri Mar 7 14:34:03 CST 2014</span>

<span class="small">*© Copyright 2014, [Rod Howell](/~rhowell/). All
rights reserved.*</span>

|                                                                                            |
| :----------------------------------------------------------------------------------------: |
| [![Valid HTML 4.01\!](/~rhowell/valid-html401.gif)](http://validator.w3.org/check/referer) |
|   [![Valid CSS\!](/~howell/vcss.gif)](http://jigsaw.w3.org/css-validator/check/referer)    |
