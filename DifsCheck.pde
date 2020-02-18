// werkt niet want als iets in visited staat laat ie het nu links liggen alleen de moeilijkste komt geheid langs configuraties die al zijn geweest dus wo, lastig om dit efficient te krijgen
class DifsCheck
{
  int type, dim, nrOfGoals, nrOfPawns;
  Move[] allowed;
  HashMap<String, Integer> knownDifs;
  
  DifsCheck(int dim, int nrOfGoals, int nrOfPawns, Move[] allowed)
  {
    this.dim = dim;
    this.nrOfGoals = nrOfGoals;
    this.nrOfPawns = nrOfPawns;
    this.allowed = allowed;
    this.knownDifs = new HashMap<String, Integer>(10000);
  }
  
  int maxDif()
  {
    int maxDif = -1;
    int[] allPositions = initiatePositions(nrOfGoals+nrOfPawns);
    int[] bluePositions = initiatePositions(nrOfGoals);
    int[] goalPositions = initiatePositions(nrOfGoals);
    PVector[] possibleSpots = getPossibleSpots();
    int nrOfPosSpots = possibleSpots.length;
    //hoeft maar alleen deze 3
    PVector[] possibleGoals = new PVector[]{new PVector(2, 2), new PVector(2, 1), new PVector(1, 1)};
    int nrOfPosGoals = possibleGoals.length;
    int counter = 0;
    while(true)
    {
      counter++;
      PVector[] goals = getUnits(nrOfGoals, goalPositions, possibleGoals);
      PVector[] pawns = getUnits(nrOfPawns+nrOfGoals, allPositions, possibleSpots);
      PVector[] blues = getUnits(nrOfGoals, bluePositions, pawns);
      Board b = new Board(dim, goals, pawns, blues);
      int dif = getDif(b, maxDif);
      if(dif >= maxDif)
      {
        maxDif = dif;
        printBoard(b.toStringArray(true));
        println(maxDif);
      }
      if(!tweak(bluePositions, allPositions.length))
      {
        bluePositions = initiatePositions(nrOfGoals);
        if(!tweak(allPositions, nrOfPosSpots))
        {
          allPositions = initiatePositions(nrOfGoals+nrOfPawns);
          if(!tweak(goalPositions, nrOfPosGoals))
            break;
        }
      }
    }
    println(counter);
    return maxDif;
  }
  
  boolean tweak(int[] positions, int possible)
  {
    for(int i=positions.length-1; i>=0; i--)
      if(positions[i]<possible-positions.length+i)
      {
        positions[i]++;
        for(int j=i+1; j<positions.length; j++)
          positions[j] = positions[j-1]+1;
        return true;
      }
    return false;
  }
  
  PVector[] getUnits(int nrOfUnits, int[] unitPositions, PVector[] possibleUnits)
  {
    PVector[] units = new PVector[nrOfUnits];
    for(int i=0; i<nrOfUnits; i++)
      units[i] = possibleUnits[unitPositions[i]];
    return units;
  }
  
  // possible goals hoeft maar 3 plekken te zijn
  int[] initiatePositions(int n)
  {
    int[] positions = new int[n];
    for(int i=0; i<n; i++)
      positions[i] = i;
    return positions;
  }
  
  int getDif(Board b, int maxDif)
  {
    String str = b.toString();
    if(knownDifs.get(str)==null)
    {
      ArrayList<int[][]> visited = new ArrayList<int[][]>();
      ArrayList<Board> frontier = new ArrayList<Board>();
      visited.add(b.board);
      frontier.add(b);
      return getDif(frontier, visited, maxDif);
    }
    return -1;
  }
  
  int getDif(ArrayList<Board> frontier, ArrayList<int[][]> visited, int maxDif)
  {
    if (frontier.isEmpty())
      return -1;
    Board current = frontier.remove(0);
    for (int i = 0; i < current.arrayDim; i++)
      for (int j = 0; j < current.arrayDim; j++)
        if (current.get(i, j) > 0)
          for (Move move : allowed)
          {
            Board copy = current.copy();
            copy.move(new PVector(i, j), move);
            if(!contains(visited, copy.board))
            {
              visited.add(copy.board);
              if (copy.isWin())
                return win(copy);
              String str = copy.toString();
              if (knownDifs.get(str) == null || knownDifs.get(str) != -1 && knownDifs.get(str) + copy.depth > maxDif)
                frontier.add(copy);
            }
          }
    return getDif(frontier, visited, maxDif);
  }
  
  boolean contains(ArrayList<int[][]> list, int[][] a)
  {
    for(int[][] e : list)
      if(deepEq(a, e))
        return true;
    return false;
  }
  
  int win(Board b)
  {
    Board copy = b.copy();
    for(int dif=0; copy!=null; dif++, copy=copy.parent)
      knownDifs.put(copy.toString(), dif);
    return b.depth;
  }
  
  //boolean boardVisited(String[][] a)
  //{
  //  for(String[][] v : visited)
  //    if(deepEq(a, v))//           || deepEq(turnRight(a), v)           || deepEq(turnLeft(a), v)           || deepEq(turn180(a), v) ||
  //       deepEq(flipVert(a), v) || deepEq(turnRight(flipVert(a)), v) || deepEq(turnLeft(flipVert(a)), v) || deepEq(turn180(flipVert(a)), v))
  //      return true;
  //  return false;
  //}
  
  boolean deepEq(int[][] a, int[][] b)
  {
    return java.util.Arrays.deepEquals(a, b);
  }
  
  /*
  String[][] flipVert(String[][] a)
  {
    String[][] flipped = new String[dim][dim];
    for(int i=0; i<dim; i++)
      flipped[i] = a[dim-1-i];
    return flipped;
  }
  
  String[][] turnRight(String[][] a)
  {
    String[][] turnt = new String[dim][dim];
    for(int y=0; y<dim; y++)
      for(int x=0; x<dim; x++)
        turnt[y][x] = a[dim-1-x][y];
    return turnt;
  }
  
  String[][] turnLeft(String[][] a)
  {
    String[][] turnt = new String[dim][dim];
    for(int y=0; y<dim; y++)
      for(int x=0; x<dim; x++)
        turnt[dim-1-x][y] = a[y][x];
    return turnt;
  }
  
  String[][] turn180(String[][] a)
  {
    String[][] turnt = new String[dim][dim];
    for(int y=0; y<dim; y++)
      for(int x=0; x<dim; x++)
        turnt[y][x] = a[dim-1-y][dim-1-x];
    return turnt;
  }
  */
  
  void printBoard(String[][] a)
  {
    for(int y=0; y<dim; y++)
    {
      for(int x=0; x<dim; x++)
        print(a[y][x] + (a[y][x].length() == 1 ? " " : "") + "|");
      println();
    }
    println();
  }
  
  PVector[] getPossibleSpots()
  {
    PVector[] possibleSpots = new PVector[dim*dim];
    for(int y=0; y<dim; y++)
      for(int x=0; x<dim; x++)
        possibleSpots[y*dim+x] = new PVector(x, y);
    return possibleSpots;
  }
}
