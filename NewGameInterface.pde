class NewGameInterface extends TextInterface
{
  NewGameInterface(Interface parentInFa)
  {
    super
    (
      parentInFa,
      "Square(1), Hex(2) or Diagonal(3)?",
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
      inFa = new SquareGame(this, GameType.SQUARE, dim, nrOfGoals, nrOfPawns, optimal);
    else if(type == 2)
      inFa = new HexGame(this, dim, nrOfGoals, nrOfPawns, optimal);
    else
      inFa = new SquareGame(this, GameType.DIAGONAL, dim, nrOfGoals, nrOfPawns, optimal);
  }
}
