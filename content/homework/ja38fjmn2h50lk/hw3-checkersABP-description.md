# Checkers AI - NegaMax with Alpha Beta Pruning

<iframe width="560" height="560" src="https://www.youtube.com/embed/krDD1j7bb8U" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Functional Requirements

For this assignment, you will be writing a AI that can be used  to play checkers (aka English Draughts).  For this implementation, a human versus human version is provided.  Your task is to add an computer player that will play against a human.  Checkers is a simple game  played on a 8x8 checkered board (32 dark squares and 32 light squares).   There are two colors of pieces, red and black, each being played by one player.  Each player starts with 12 pieces. The black piece  player goes first.  Rules of moving, jumping (capturing), and board  layout can be found at [this link](https://www.itsyourturn.com/t_helptopic2030.html) (ignore instructions specific to the site).  The objective of the game is to capture all of the opposing pieces. 

## Finding the Best Play

At the heart of the game engine is an algorithm for trying to find  the best move. To understand this algorithm, we need to view the various board configurations as forming a tree. (Note that this tree will not be implemented as a data structure - it is just how we think about the relationships between board configurations in order to guide our algorithm development.) Any board configuration can form the root of a  tree. Its children are the board configurations that can be reached by making a single play from this configuration. Thus, a node in this tree may have numerous children.

In principle, we could determine the best move by examining this entire tree. However, this tree is so large that we have no hope of  exploring the whole thing. For this reason, we will search only a portion of the tree, and use an *evaluation function* to compute a number estimating the strength of a player's position for each node whose children we don't examine. By combining this evaluation function with a partial search of the tree, we can typically do a better job of finding the best move than if we were to use the evaluation function by itself. In what follows, we will first describe the tree search algorithm, then we will describe the evaluation function.

## The Negamax Algorithm

The algorithm we will use to search the tree is called the *negamax* algorithm, which is a more succinct presentation of the *minimax* algorithm. We will assume that the evaluation function attempts to give a higher value for a stronger position for the player whose turn it is  to move. A value of 0 indicates a perfectly balanced configuration. The result of the evaluation function acts as a heuristic for our AI player to chose the best move with the information it knows at the time.  

Checkers is a simple game, but the number of board configurations make it very difficult represent the entire tree, even when the depth is limited.  To improve our search of the tree, we will use a technique called *alpha-beta pruning*.  Alpha-beta pruning improves the efficiency of the negamax algorithm by pruning branches of the tree that will not yield an optimal play given the current state of the game.  In these algorithms we are trying to maximize our score, so alpha and beta will represent the lower and upper bounds of possible scores for a given node in the tree.  When beta becomes larger than alpha, we can stop exploring the rest of the branches of the node since we would not be able to do any better than what we currently have.  In a game like checkers, this greatly increases our search speed since the branching factor (how fast the tree spreads out) is very high.  If the best moves are searched first, alpha-beta pruning can decrease complexity from $O(b^d)$ to $O(\sqrt{b^d})$ where b is the branch factor and d is the depth.

An illustration of the negamax algorithm with alpha beta pruning can be found on the [Wikipedia page](https://en.wikipedia.org/wiki/Negamax#Negamax_with_alpha_beta_pruning). Note that the algorithm shown on the wiki page is slightly different than the one described later in the description of the `GameTree `class, specifically the need to flip the sign of the result of the evaluation function.

## Starting the Assignment

Create a GitHub repository using [**this URL**](https://classroom.github.com/a/wGt4RToR) and clone it to your local machine. This solution contains a Checkers implementation that allows for human vs human play.  The pictures used for the checker pieces are in the included **pics** folder.

## User Interface

The base interface for a functional checkers game is provided.

<img src="pics\ui.png" alt="Checkers Interface"/>

To the given interface, you will need to add a few new menu options.  Under ‘File’, add an option for creating a new game versus the AI.  Add a new menu item called ‘Edit’ that has a menu item ‘Undo’ mapped to the key **Ctrl + Z**.  There is also a new **NumericUpDown** control, anchored to the top-right.  This has an initial value of 3 and a **minimum** value of 1and **maximum** value of 12.

<img src="pics\ui-ai.png" alt="Checkers Interface with AI"/>

## Software Architecture

![Software Architecture](pics\UML.png)

The UserInterface class is primarily used for drawing/updating the UI  for when the game is created and when a piece is interacted with.  All  of the actual logic for checkers is contained inside the Checkers and GameTree class.   Each square on the checker board will be represented using  BoardSquare's.  This class is also indicates whether or not a square  contains an actual piece.  The enum `SquareColor` is used to indicate this  information.  

## Coding Requirements

Specific requirements for the above software architecture are given in what follows. Feel free to add more methods if you feel it improves the code.  There is some room for the use of helper methods to reduce code for repeated logic.

### The BoardSquare Class

This class has been completed for you.  It is used to represent each square on the checkers board.  Each square may have a piece (that might be a king), which has a color.

### **The IMove Interface**

**IMove** is a simple interface that will allow common interactions with the types of moves made in the game.  The interface has two definitions:

- `bool IsJump`
  - IsJump is a property with only a get accessor.  The property will indicate if the move represents a jump.
- `bool Undo(Checkers game)`
  - The Undo method (when implemented in a class) will reverse a move in the context of the given game.

### **The Move Class**

The **Move** class contains information about a regular move (non-jump) made during a game of checkers.  This class implements the `IMove` and `IComparable<Move>` interfaces.  For the class you will need to: 

Add the following **fields**:

- `private bool _fromKing`
    - Indicates if the square you are moving from was a king
- `_fromRow`, `_toRow`, `_fromColumn`, `_toColumn`
    - Each of these are private integers.  These represent the coordinates on the board where a piece (From) was moved (To).

Add the following **properties**:

- `public bool IsJump`
    - Indicates that this move is **not** a jump.  This property has only a getter which always returns false.
- `public SquareColor Color`
    - Indicates the color of the piece that was moved.  This property has a default getter and private setter.

Add the following **constructor**:

- `public Move(int fromRow, int fromColumn,int toRow, int toColumn, bool fromKing, SquareColor color)`
    - This constructor simply takes each of the given parameters and assigns them to the corresponding field or property.

Add the following **methods**:

- `public BoardSquare GetFromSquare(Checkers game)`
    - This method returns the square on the Board from the given game located at (`_fromRow`, `_fromColumn`)
- `public BoardSquare GetToSquare(Checkers game)`
    - This method returns the square on the Board from the given game located at (`_toRow`, `_toColumn`)
- `public bool Undo(Checkers game)`
    - This method reverses the move in the given game.  Use the GetSquare method from the Checker's class to get the "from" square and the "to" square.  Reset the Color and King properties in the "from" square back to their original values and the "to" square color to `SquareColor.None`. Note that  you should also reset the game's SelectedPiece (set to null) and the game's Turn.  Lastly, be sure to update game's piece's dictionary to reflect the undo.
- `public int CompareTo(Move other)`
    - This method is the implementation from the IComparable interface.  Return 0 if all fields and properties between this object and the other are equal.  Return -1 in all other cases.
- `public override string ToString()`
    - This method overrides the base ToString method in order to get a string representation of a Move.  Return a string in the form of "Color-(fromRow, fromColumn) to (toRow, toColumn)".  This method is used to display the last move in the user interface.  It is also extremely useful when debugging your program.

### **The CapturedPiece Struct**

This struct contains all the information regarding a piece that is captured during a move.  It is used in the `JumpMove` class to help keep information from a jump organized.  For this struct:

Add the following **properties**:_(note that each of these have default getters and default private setters)_

- `public SquareColor CapturedColor`
    - Represents the color of the captured piece.
- `public int CapturedRow`
    - Represents the row in the board of the captured piece.
- `public int CapturedCol`
    - Represents the column in the board of the captured piece.
- `public bool CapturedKing`
    - Represents whether or not the captured piece was a king.

Add the following **constructor**: 

- `public CapturedPiece(int captRow, int captCol, SquareColor captColor, bool captKing)`
    - This is a basic constructor that sets the properties of the struct to the corresponding values.

### **The JumpMove Class**

The **JumpMove** class contains information about a regular move (non-jump) made during a game of checkers.  This class implements the `IMove` and `IComparable<Move>` interfaces.  To the class you will need to: 

Add the following **fields**:

- `private CapturedPiece _captured`
  - Represents the piece that was captured in the jump

Add the following **properties**:

- `public bool IsJump`
  - A property with only a getter that always returns true to indicate this move was a jump.
- `public Move Move`
  - This property has a default getter and private setter.  It keeps track where the piece was and moved to after the jump.

Add the following **constructor**: 

- `public JumpMove(Move m, CapturedPiece c)`
  - This constructor assigns the given values to the corresponding property and field.

Add/modify the following **methods**:

- `public bool Undo(Checkers game)`
  - Similar to the `Move` class's Undo method, this method reverses the jump that was made in the given checkers game.  To do so, restore the captured piece back to where it was (be sure to update the game score and pieces dictionaries), then invoke the Undo method on the Move property to reverse the move that was made in the jump.
- `public int CompareTo(JumpMove other)`
  - Similar to the `Move` class, this method returns 0 of all the fields and properties between this jump and the other are equal.  It should return -1 otherwise.
- `public override string ToString()`
  - This ToString method should return the string representation of the jump move.  It should be in the form of: "Jump--Move(capt: (capturedRow, capturedColumn))" where Move is the Move property converted to a string.

### **The Checkers Class**

The **Game** Class holds most of the logic for checkers.  All of the code for supporting a player vs player game of checkers has been provided for you.  This class will need to be modified and added to in order to allow the AI to play: 

Add the following **fields**:

- `private Stack<IMove> _moveHistory`
  - This stack will keep track of moves that are made so that you can either undo your move (if playing human vs human) or allow the AI to backtrack as it generates its game tree.
- `int[] _weights = new int[] { 5, 10, 1, 3};`
  - This array is contains the weights to apply when evaluating a board for the game tree.  The weights, in order, are: pawn count, king count, #pieces in their own back row, pieces in the middle of the board, and pieces that are in a protect location (outside edge)

Add the following **properties**:

- `public Dictionary<(int, int), BoardSquare> RedPieces` and `public Dictionary<(int, int), BoardSquare> BlackPieces`
  - These two properties have a default getter and setter.  They contain each of the red and black pieces respectively on the board.  The Key in the dictionary is a Tuple (see this [documentation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/value-tuples)) which represents the row and column where that piece is at on the board.  A tuple is a data structure that allows you to group multiple pieces of information into one.  You can think of it as a light-weight array, except that it is a value type, not a reference type.
- `public IMove LastMove()`
  - This property only has a getter which will return the last element on the *\_moveHistory* stack (without removing it).  If there is nothing on the stack, it should return null.

Modify the default **constructor**: 

- Initialize the *\_moveHistory* stack to a new stack.

Modify the following **methods**:

- `private void CreateBoard()`
    - Update the method to initialize the red and black pieces properties to be a new dictionary.  Then, as each piece gets created, add it to the corresponding dictionary.
- `public bool Jump(BoardSquare current, BoardSquare target, SquareColor enemyColor)` 
    - This method should add a new out parameter of type JumpMove.  Making the new method signature `public bool Jump(BoardSquare current, BoardSquare target, SquareColor enemyColor, out JumpMove jumpMove)`.
    - Set the out parameter to be null initially, and if a jump is made, set the out parameter to be a new JumpMove object with the information of the move that happened and which piece was captured.  Once created, add it to the move history.  Be sure to do this before the captured piece's color is set to None.
    - You will also need to be sure to remove the captured piece from the correct pieces dictionary .
- `public bool MoveSelectedPiece(int targetRow, int targetCol)`
    - You will need to update the Jump call to include the out parameter, but you do not need to do anything with the value.
- `public void MovePiece(BoardSquare piece, BoardSquare targetSquare, SquareColor enemyColor, bool jumped)`
    - Update the method such that if a jump was not made, you add a new move to the move history using the from and to squares.
    - Depending on the color of the piece moved, be sure to update the corresponding pieces dictionary to reflect the move.

Add the following **methods**:

- `public bool Undo()`
    - This method should undo the last move if there was one by removing the last move from the history and invoking its Undo method.  This method should also set the Selected property of SelectedPiece to false if it is not null.  The method should return true if a move was undone and false otherwise.
- `private List<BoardSquare> GetMoveSquares(BoardSquare piece, int distance)`
    - This method returns a list of squares that the given square can move to.  The distance parameter should be 1 for a normal move and 2 for jumps.  Remember that kings can move on each diagonal, but a normal piece cannot.  Helper methods are very useful here to reduce repeated code.
- `public List<JumpMove> GetJumps(BoardSquare piece, SquareColor enemyColor)`
    - This method returns a list of all moves possible from the given piece.  The enemy color is the color of the piece we are trying to capture.  You will need to utilize the `GetMovesSquares` method (passing in 2 for the distance) to get all of the possible jump targets, then use the `Jump` method to try and execute the jump.  If the jump is successful, add the jump move to the list of possible moves, then call the `Undo` function in the Checkers class to reverse the jump before trying the next target.  If no jumps are found, the method should return an empty list.
- `public List<IMove> FindPossibleMoves(BoardSquare piece, SquareColor enemyColor, out bool seenJump)`
    - Given a piece's board square, this method should return a list of all possible moves for it.  If there are any jumps to be made, the list returned should *only* contain jumps since the game enforces the rule that if a jump is possible, it must be made.  If there are no jumps possible, use the `GetMoveSquares` (passing 1 for distance) to get all of the valid squares the piece can move to and add each of those  as a valid move to the list you return.
- `public List<IMove> FindPossibleMoves(out bool seenJump)`
    - This method is similar to the one previously described; however, it returns a list of possible moves for all pieces of the current player.  Similar to before, if any piece has a jump available, this method should only return moves that are jumps.
- `public int EvaluateBoard()`
    - This method evaluates the current board to create the heuristic value for the NegaMax algorithm.  For each of the red pieces and black pieces, count the number of pawns, kings, pieces on their own back row, and pieces that are protected (outside edges of the board).  Note that a piece can be counted in more than one category.  A helper method is useful for counting each piece so logic does not have to be duplicated for red and black.  Once counted, the weights should be applied  and then return the sum of the weighted counts of the current player minus the other player.

### **The GameTree Class**

The **GameTree** class contains the logic for how the AI player in the checkers game makes its move.

Add the following **fields**:

- `private Checkers _game`
    - The reference to the Checkers game that is currently being played with this AI.
- `private int _depth`
    - The depth represents the maximum number of moves (layers) the AI will look ahead in the game tree before making a move.

Add the following **constructor**: 

- `public GameTree(Checkers game, int depth)`
    - The constructor of this class only assigns the given values to the corresponding fields.

Add the following **methods**:

- `private void DoMove(IMove move)`
    - This method will execute the given move on the board.  You can check if it is jump by looking at the `IsJump` property.  If it is a jump, you can call the `Jump` method through `_game` and passing the from and to squares from the given move.  To get those, you will need to cast the move as a `JumpMove` object and accessing the `Move` property.  If it is not a jump, you will call the `MovePiece` method, but you will need to cast the move as a `Move` object.
- `public double NegaMax(double alpha, double beta, int depth, out IMove bestMove)`
    - This method will execute the negamax algorithm with alpha-beta pruning as it was described previously.  Alpha and beta are initially the min and max int value (`int.MinValue`, and `int.MaxValue`).  Depth is how deep this algorithm will recurse down the tree.  But remember, we are not storing the tree anywhere, but are generating it as we go given the current state of the game (`_game`).  The algorithm is as follows:
      1. Set bestMove to null
      2. Base case: depth is 0
         1. return the heuristic of the current game (use the `EvaluateBoard `method)
      3. Declare two variables, one of type `IMove ` (referred to as `localBest`below) and one of type `int` (this is initially `int.MinValue` and is referred to as `score`).  These will keep track of what the current best score for the tree node is and the current best move.  Remember that each "node" of the tree represents the state of a checkers game.
      4. For all moves in the current game (for the current player)
         1. if there is a jump possible, be sure to not do any other move that is not a jump
         2. store the current player's turn in a temporary variable so we can tell if the turn changes after the move is made (this is for the multi-jump scenario)
         3. Do the move
         4. Find the score of the current state of the game by recursively calling NegaMax. Be sure to store the result of the recursive call in a local variable as this will be the best score for the move that was made for the current state.  There are two  recursive cases:
            1. The move did not change whose turn it is.  Therefore pass to NegaMax alpha, beta, depth, and `localBest`.
            2. Else, the move changed the turn, therefore we are now trying to maximize the score of the board for the other player.  To do so, we will flip the alpha and beta parameters by calling NegaMax with -beta, -alpha, depth-1, and `localBest`.  Notice that alpha and beta get swapped and their signs flipped.
         5. If the value returned by step 4 is greater than or equal to `score`, then update `score` with this value and store the current move into `bestMove`.
         6. Update alpha to the maximum between alpha and `score`
         7. Undo the move that was made so we do not corrupt the state of the board with the next move.
         8. if alpha is greater than or equal to beta, there are no other moves that will produce a better score in the current state so stop evaluating any further moves.
      5. Return `score`
- `public bool MakeBestMove()`
    - This method is used by the UserInterface to make the best move for the AI when it is the AI's turn.  Simply call the NegaMax method, with `int.MinValue`, and `int.MaxValue` as alpha and beta and max depth for the game tree.  If the best move returned through the out parameter is not null, then a move is available.  Do that move and return true.  Return false otherwise to indicate to the UI that there are no more moves available for the AI to make (this is a deadlock scenario).

### The UserInterface Class

The UserInterface class is responsible for drawing and updating the checker board. This class is mostly finished for you; however, you will need to make some modifications:

- Add two private fields `private bool _aiPlayer` and `private GameTree _ai` which will indicate if the game is player vs AI and hold the AI's game tree.
- `private void RedrawBoard()`
  - Modify this method to update the **uxTurn**'s Text property to also display the last move that was made (if one was made) along with whose turn it is.  If there was a last move, the text should be updated in the form: "(Last Move: *moveGoesHere*)---Now *turnGoesHere*'s turn"
- `private void BoardSquare_Click(object sender, EventArgs e)`
  - Modify this method so that it handles both player vs player and player vs AI games.  Note that when it is the AI's turn, this will have to be in a loop until it switches to the other player in order to handle multi-jump moves.  The method should handle situations when the AI run's out of moves (deadlocks) and show a winner (if there is not, show a tie).
- `private void uxNewGame_Click(object sender, EventArgs e)`
  - Modify this method to switch the `_aiPlayer` to false and enable the undo feature in the interface.
- `private void uxNewGamePVsAI_Click(object sender, EventArgs e)`
  - This is a new method that needs to be added as the click event for the menu option for creating a game vs an AI.  The method should set the `_aiPlayer` to be true and the `_ai` (the game tree) to be null.  It should then draw the board and disable the undo feature in the interface.
- `private void undoToolStripMenuItem_Click(object sender, EventArgs e)`
    - This method will simply invoke Undo on the current game.  If Undo returns true, then the board should be redrawn.

## Testing Your Program

Be sure to test win conditions for both sides (human and AI, and each kind of move/jump. To assist in testing your program, board squares are labeled with their row and column.  Adding the last move made to the status bar where the current player is displayed can be helpful as well (the AI can make very fast moves).  Overall, testing this homework can be tricky.  Your AI should not blindly throw pieces away (especially at levels higher than 3 or 4) and be more difficult to beat as you increase the depth.  Note that the AI is not the most sophisticated in choosing moves at times (due to the evaluation function), but it should play a decent game of checkers.

## Performance

There will be a cascade effect when creating a new game, but moves will be made instantly for player vs player.  For games with the AI, moves should be made instantly up to around level 9 or 10.  At 10, you will start to see some delay in each move, but it should be around 1-2 seconds for some moves and 3-4 seconds for others.  At level 12, you will start to see longer delays (5-10 seconds).  Your AI should play a good game of checkers and be harder to beat as you increase the level.

## Submitting Your Assignment

Be sure to **refresh** your Team Explorer, **commit** all your changes, then **push** your commits to your GitHub repository. Then submit the *entire URL* of the commit that you want graded. There is no need to submit a comment, as you will not have a completion code.

**Important:** If the URL you submit does not contain the 40-hex-digit fingerprint of the commit you want graded, **you will receive a 0**,  as this fingerprint is the only way we can verify that you completed  your code prior to submitting your assignment. We will only grade the  source code that is included in the commit that you submit. Therefore,  be sure that the commit on GitHub contains all six ".cs" files, and that  they are the version you want graded. This is especially important if  you had any trouble committing or pushing your code.