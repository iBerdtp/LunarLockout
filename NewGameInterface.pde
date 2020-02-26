class NewGameInterface extends TextInterface
{
  NewGameInterface()
  {
    super
    (
      "Square(1) or Hex(2)?",
      "Size?",
      "Number of goals?",
      "Number of pawns?",
      "Difficulty?"
    );
  }
  
  void performWhenDone()
  {
    openGame(answers[0], answers[1], answers[2], answers[3], answers[4]); 
  }
  
  void openGame(int type, int dim, int nrOfGoals, int nrOfPawns, int optimal)
  {
    if(type == 1)
      inFa = new SquareGame(dim, nrOfGoals, nrOfPawns, optimal, file, new Move[]{Move.UP, Move.LEFT, Move.RIGHT, Move.DOWN}, new int[]{UP, LEFT, RIGHT, DOWN}, SHIFT);
    else
      inFa = new HexGame(dim, nrOfGoals, nrOfPawns, optimal, file, new Move[]{Move.UP, Move.LEFT, Move.DOWN_LEFT, Move.UP_RIGHT, Move.RIGHT, Move.DOWN}, new int[]{36, 37, 35, 33, 39, 34}, SHIFT);
  }
}
