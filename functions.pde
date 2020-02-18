import java.util.Arrays;

void keyPressed()
{
  KEYS[keyCode] = true;
  if(keyCode == 'R')
    setup();
  redraw();
}

void mousePressed()
{
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
  
void openGame(int type, int dim, int nrOfGoals, int nrOfPawns, int optimal)
{
  if(type == 1)
    inFa = new SquareGame(dim, nrOfGoals, nrOfPawns, optimal, file, new Move[]{Move.UP, Move.LEFT, Move.RIGHT, Move.DOWN}, new int[]{UP, LEFT, RIGHT, DOWN}, SHIFT);
  else
    inFa = new HexGame(dim, nrOfGoals, nrOfPawns, optimal, file, new Move[]{Move.UP, Move.LEFT, Move.DOWN_LEFT, Move.UP_RIGHT, Move.RIGHT, Move.DOWN}, new int[]{36, 37, 35, 33, 39, 34}, SHIFT);
}

void savePuzzle(Board initial, int optimal, String type)
{
  String[][] board = initial.toStringArray(true);
  String fileName = "saves/" + type.substring(18) + "/" + optimal + "/" + board.hashCode() + ".txt";
  PrintWriter output = createWriter(fileName);
  for(String[] a : board)
    output.println(Arrays.toString(a));
  output.close();
  println("saved to: " + fileName);
}
