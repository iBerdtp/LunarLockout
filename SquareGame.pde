class SquareGame extends Game
{
  SquareGame(Interface parentInFa, int dim, int nrOfGoals, int nrOfPawns, int optimal, SoundFile file, Move[] allowed, int[] moveControls)
  {
    super(parentInFa, dim, nrOfGoals, nrOfPawns, optimal, file, allowed, moveControls);
  }
  
  SquareGame(Interface parentInFa, Board board, SoundFile file, Move[] allowed, int[] moveControls)
  {
    super(parentInFa, board, file, allowed, moveControls);
  }
  
  void showBoard()
  {
    util.showSquareBoard(current, 0);
  }

  void showSelected()
  { 
    for (int i=0; i<arrayDim; i++)
      for (int j=0; j<arrayDim; j++)
        if (selected.x == i && selected.y == j)
        {
          noFill();
          strokeWeight(3);
          stroke(255, 255, 0);
          rect(i*regSquareSize, j*regSquareSize, regSquareSize, regSquareSize);
        }
  }
  
  void fillAccordingly(Board b, int nrOfGoals, int nrOfPawns)
  {
    setGoals(b, nrOfGoals);
    setUnits(b, nrOfGoals, nrOfPawns);
  }
  
  void setGoals(Board b, int nrOfGoals)
  {
    ArrayList<PVector> possibleGoals = getPossibleSpots(b, 1);
    b.goals = new PVector[nrOfGoals];
    for(int i=0; i<nrOfGoals; i++)
      b.goals[i] = util.getRandom(possibleGoals);
  }
  
  void setUnits(Board b, int nrOfGoals, int nrOfPawns)
  {
    ArrayList<PVector> spots = getPossibleSpots(b, 0);
    for (int i=0; i<nrOfPawns; i++)
      b.set(util.getRandom(spots), 2);
    for(int i=0; i<spots.size(); i++)
      for(int j=0; j<b.goals.length; j++)
        if(spots.get(i).equals(b.goals[j]))
        {
          spots.remove(i--);
          break;
        }
    for(int i=0; i<nrOfGoals; i++)
      b.set(util.getRandom(spots), 1);
  }
  
  ArrayList<PVector> getPossibleSpots(Board b, int rimSize)
  {
    ArrayList<PVector> spots = new ArrayList<PVector>();
    for(int y=rimSize; y<b.arrayDim-rimSize; y++)
      for(int x=rimSize; x<b.arrayDim-rimSize; x++)
        spots.add(new PVector(x, y));
    return spots;
  }
  
  void setAdditional()
  {
    resize();
  }
  
  void resize()
  {
    surface.setSize(arrayDim*regSquareSize, arrayDim*regSquareSize);
  }
}
