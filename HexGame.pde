class HexGame extends Game
{
  int chosenDim;
  float ellipseFactor;
  
  HexGame(int dim, int nrOfGoals, int nrOfPawns, int optimal, SoundFile file, Move[] allowed, int[] moveControls, int switchControl)
  {
    super(dim*2-1, nrOfGoals, nrOfPawns, optimal, file, allowed, moveControls, switchControl);
  }
  
  HexGame(Board board, SoundFile file, Move[] allowed, int[] moveControls, int switchControl)
  {
    super(board, file, allowed, moveControls, switchControl);
  }
  
  void setAdditional()
  {
    this.chosenDim = (arrayDim+1)/2;
    surface.setSize(arrayDim*squareSize, ceil(sqrt(3)*(chosenDim-1)*squareSize+squareSize));
    this.ellipseFactor = 0.8;
  }
  
  void showBoard()
  {
    ellipseMode(CENTER);
    for (int i=0; i<arrayDim; i++)
      for (int j=0; j<arrayDim; j++)
      {
        if(current.get(i,j) != -1)
        {
          fill(0);
          for(PVector goal : current.goals)
            if (goal.x == i && goal.y == j)
              fill(255, 0, 0);
          strokeWeight(1);
          stroke(255);
          ellipse((i+(j-chosenDim+2f)/2)*squareSize, (0.5+j*sqrt(3)/2)*squareSize, squareSize, squareSize);
          if (current.get(i, j) == 1)
          {
            fill(0, 0, 255);
            ellipse((i+(j-chosenDim+2f)/2)*squareSize, (0.5+j*sqrt(3)/2)*squareSize, ellipseFactor*squareSize, ellipseFactor*squareSize);
          } else if (current.get(i, j) > 1)
          {
            fill(0, 255, 0);
            ellipse((i+(j-chosenDim+2f)/2)*squareSize, (0.5+j*sqrt(3)/2)*squareSize, ellipseFactor*squareSize, ellipseFactor*squareSize);
          }
        }
      }
  }
  
  void showSelected()
  { 
    for (int i=0; i<arrayDim; i++)
      for (int j=0; j<arrayDim; j++)
        if (selected.x == i && selected.y == j)
        { //<>//
          noFill();
          strokeWeight(3);
          stroke(255, 255, 0);
          ellipse((i+(j-chosenDim+2f)/2)*squareSize, (0.5+j*sqrt(3)/2)*squareSize, squareSize, squareSize);
        } //<>//
  } //<>// //<>//
  
  void fillAccordingly(Board b, int nrOfGoals, int nrOfPawns)
  {
    setBoundaries(b);
    setGoals(b, nrOfGoals); //<>//
    setUnits(b, nrOfGoals, nrOfPawns); //<>//
  }
  
  void setBoundaries(Board b)
  {
    for(int y=0; y<chosenDim-1; y++)
      for(int x=0; x<chosenDim-1-y; x++)
      {
        b.board[y][x] = -1;
        b.board[b.arrayDim-1-y][b.arrayDim-1-x] = -1;
      }
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
      for(int x=max(rimSize, chosenDim-1-y+rimSize); x<min(b.arrayDim-rimSize, 3*chosenDim-2-y-rimSize); x++)
        spots.add(new PVector(x, y));
    return spots;
  }
}
