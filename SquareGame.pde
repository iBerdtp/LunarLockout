class SquareGame extends Game
{
  SquareGame(int dim, int nrOfGoals, int nrOfPawns, int optimal, SoundFile file, Move[] allowed, int[] moveControls, int switchControl)
  {
    super(dim, nrOfGoals, nrOfPawns, optimal, file, allowed, moveControls, switchControl);
  }
  
  void showBoard()
  {
    for (int i=0; i<arrayDim; i++)
      for (int j=0; j<arrayDim; j++)
      {
        fill(0);
        for(PVector goal : current.goals)
          if (goal.x == i && goal.y == j)
            fill(255, 0, 0);
        strokeWeight(1);
        stroke(255);
        rect(i*squareSize, j*squareSize, squareSize, squareSize);
        if (current.get(i, j) == 1)
        {
          fill(0, 0, 255);
          ellipse(i*squareSize, j*squareSize, squareSize, squareSize);
        } else if (current.get(i, j) > 1)
        {
          fill(0, 255, 0);
          ellipse(i*squareSize, j*squareSize, squareSize, squareSize);
        }
      }
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
          rect(i*squareSize, j*squareSize, squareSize, squareSize);
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
      b.goals[i] = getRandom(possibleGoals);
  }
  
  void setUnits(Board b, int nrOfGoals, int nrOfPawns)
  {
    ArrayList<PVector> spots = getPossibleSpots(b, 0);
    for (int i=0; i<nrOfPawns; i++)
      b.set(getRandom(spots), 2);
    for(int i=0; i<spots.size(); i++)
      for(int j=0; j<b.goals.length; j++)
        if(spots.get(i).equals(b.goals[j]))
        {
          spots.remove(i--);
          break;
        }
    for(int i=0; i<nrOfGoals; i++)
      b.set(getRandom(spots), 1);
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
    ellipseMode(CORNER);
    surface.setSize(arrayDim*squareSize, arrayDim*squareSize);
  }
}
