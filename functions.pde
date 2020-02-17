void mousePressed() {
  //selected = new PVector(mouseX/100, mouseY/100);
}

void keyPressed() { 
  KEYS[keyCode] = true;
  if(keyCode == 'R')
    setup();
  redraw();
}

PVector getRandom(ArrayList<PVector> vectors)
{
  return vectors.remove((int)random(0, vectors.size()));
}

void resetKeys()
{
  KEYS = new boolean[255];
}
  
void openGame(int type, int dim, int nrOfGoals, int nrOfPawns, int min, int max)
{
  if(type == 1)
    inFa = new SquareGame(dim, nrOfGoals, nrOfPawns, min, max, file, new Move[]{Move.UP, Move.LEFT, Move.RIGHT, Move.DOWN}, new int[]{UP, LEFT, RIGHT, DOWN}, SHIFT);
  else
    inFa = new HexGame(dim, nrOfGoals, nrOfPawns, min, max, file, new Move[]{Move.UP, Move.LEFT, Move.DOWN_LEFT, Move.UP_RIGHT, Move.RIGHT, Move.DOWN}, new int[]{36, 37, 35, 33, 39, 34}, SHIFT);
}

void returnToOptions()
{
  inFa = new Welcome();
}
