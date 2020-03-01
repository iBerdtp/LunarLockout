// contains all functions that (possibly) need to be accessible from multiple classes. Can't be made static for reasons unknown to me.

PVector u_getRandom(ArrayList<PVector> vectors)
{
  return vectors.remove((int)random(0, vectors.size()));
}

void u_resetKeys()
{
  KEYS = new boolean[255];
}

boolean u_contains(int[] a, int i)
{
  for(int e : a)
    if(i == e)
      return true;
  return false;
}

int[] u_toIntArray(String[] strings)
{
  int[] ints = new int[strings.length];
  for(int i=0; i<strings.length; i++)
    ints[i] = Integer.parseInt(strings[i]);
  return ints;
}

String[] u_toStringArray(int[] ints)
{
  String[] strings = new String[ints.length];
  for(int i=0; i<ints.length; i++)
    strings[i] = Integer.toString(ints[i]);
  return strings;
}

void u_savePuzzle(Board initial, GameType gameType)
{
  File dir = new File(savesPath + gameType + "\\" + initial.difficulty);
  String fileName = dir.getPath() + "\\";
  if(dir.isDirectory() && dir.list().length > 0)
  {
    String[] list = dir.list();
    fileName += Integer.parseInt(list[list.length-1].substring(0,1))+1;
  }
  else
    fileName += 0;
  fileName += ".puz";
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

void u_showBoard(GameType gameType, Board current, int borderSize)
{
  strokeWeight(2);
  if(gameType == GameType.SQUARE || gameType == GameType.DIAGONAL)
    u_showSquareBoard(current, borderSize);
  else if(gameType == GameType.HEX)
    u_showHexBoard(current, borderSize);
}

void u_showSquareBoard(Board current, int borderSize)
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
      stroke(textBackground);
      rect(borderSize+i*squareSize, borderSize+j*squareSize, squareSize, squareSize);
      if (current.get(i, j) == 1)
        u_drawPionnetje(0, 0, 255, borderSize, squareSize, i, j);
      else if (current.get(i, j) > 1)
        u_drawPionnetje(0, 255, 0, borderSize, squareSize, i, j);
    }
}

void u_showHexBoard(Board current, int borderSize)
{
  ellipseMode(CENTER);
  int arrayDim = current.getDim();
  int chosenDim = (arrayDim+1)/2;
  int squareSize = (width-2*borderSize)/arrayDim;
  for (int i=0; i<arrayDim; i++)
    for (int j=0; j<arrayDim; j++)
    {
      if(current.get(i,j) != -1)
      {
        fill(0);
        for(PVector goal : current.goals)
          if (goal.x == i && goal.y == j)
            fill(255, 0, 0);
        stroke(textBackground);
        ellipse(borderSize+(i+(j-chosenDim+2f)/2)*squareSize, borderSize+(0.5+j*sqrt(3)/2)*squareSize, squareSize, squareSize);
        if (current.get(i, j) == 1)
        {
          noStroke();
          fill(0, 0, 255);
          ellipse(borderSize+(i+(j-chosenDim+2f)/2)*squareSize, borderSize+(0.5+j*sqrt(3)/2)*squareSize, ellipseFactor*squareSize, ellipseFactor*squareSize);
        } else if (current.get(i, j) > 1)
        {
          noStroke();
          fill(0, 255, 0);
          ellipse(borderSize+(i+(j-chosenDim+2f)/2)*squareSize, borderSize+(0.5+j*sqrt(3)/2)*squareSize, ellipseFactor*squareSize, ellipseFactor*squareSize);
        }
      }
    }
}

void u_drawPionnetje(int r, int g, int b, int borderSize, int squareSize, int i, int j)
{
  noStroke();
  fill(r, g, b);
  ellipse(borderSize+i*squareSize, borderSize+j*squareSize, squareSize, squareSize);
}
