import java.util.Arrays;
import java.util.Scanner;

final String savesPath = "C:\\Users\\Bert\\Documents\\PROCESSING\\PROJECJES\\puzeltjeNextLevel\\saves\\";
final File savesDir = new File(savesPath);

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

boolean contains(int[] a, int i)
{
  for(int e : a)
    if(i == e)
      return true;
  return false;
}

int[] toIntArray(String[] strings)
{
  int[] ints = new int[strings.length];
  for(int i=0; i<strings.length; i++)
    ints[i] = Integer.parseInt(strings[i]);
  return ints;
}

void savePuzzle(Board initial, int optimal, String type)
{
  File dir = new File(savesPath + type.substring(18) + "\\" + optimal);
  String fileName = dir.getPath() + "\\" + (dir.isDirectory() ? dir.list().length : 0) + ".puz";
  PVector[] goals = initial.getGoals();
  PrintWriter output = createWriter(fileName);
  
  output.println(initial.getDim());
  output.println(initial);
  output.println(goals.length);
  for(PVector v : goals)
    output.println((int)v.x + " " + (int)v.y);
  output.close();
  
  println("saved to: " + fileName);
}

void showSquareBoard(Board current, int borderSize)
{
  ellipseMode(CORNER);
  int arrayDim = current.getDim();
  int squareSize = (width-2*borderSize)/arrayDim;
  for (int i=0; i<arrayDim; i++)
    for (int j=0; j<arrayDim; j++)
    {
      fill(0);
      for(PVector goal : current.goals)
        if (goal.x == i && goal.y == j)
          fill(255, 0, 0);
      strokeWeight(1);
      stroke(255);
      rect(borderSize+i*squareSize, borderSize+j*squareSize, squareSize, squareSize);
      if (current.get(i, j) == 1)
        drawPionnetje(0, 0, 255, borderSize, squareSize, i, j);
      else if (current.get(i, j) > 1)
        drawPionnetje(0, 255, 0, borderSize, squareSize, i, j);
    }
}

void drawPionnetje(int r, int g, int b, int borderSize, int squareSize, int i, int j)
{
  fill(r, g, b);
  ellipse(borderSize+i*squareSize, borderSize+j*squareSize, squareSize, squareSize);
}
