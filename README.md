# CONNECT FOUR
## Approach

1. Map out the game approach
2. Create the TDD tests 
3. Start solving the tests!
4. Finish???


### Small Notes
1. This is a 2 player game, not computer driven. Therefore, don't need to create computer logic
2. It's probably not too hard to construct the win conditions myself, right?
3. Remember the board is a 7x6 (CxR) construction


#### Creating Diagonals

To create diagonals, you need to cover two types:

1. Top-Left to Bottom-Right Diagonals (↘):
    * Start from the leftmost column of each row, up to the row where starting a diagonal wouldn't yield at least 4 cells (considering the height of your grid).
    * For each of these starting points, move diagonally down and to the right, collecting cells until you reach the bottom row or the rightmost column.
    * Repeat this process starting from the top row, moving down diagonally from each column, again ensuring you can get at least 4 cells in a diagonal.

2. Bottom-Left to Top-Right Diagonals (↗):
    * Similar to the previous type, but this time, start from the leftmost column of each row, beginning from the bottom row and moving up.
    * For each starting point, move diagonally up and to the right, collecting cells until you reach the top row or the rightmost column.
    * Also, start from the bottom row and move diagonally up from each column, ensuring the diagonal can contain at least 4 cells.


### Creating the Game Class

Initializing the game class will mean that we need to support the following functionality:

1. Getting and setting player symbols
2. Getting player moves and control-flowing to place them
3. Checking for game-playing conditions
4. Ending the game and updating with the winner

