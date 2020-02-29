class BFS
{
  Move[] allowed;
  ArrayList<Board> frontier;
  ArrayList<int[][]> visited;
  Board solution;
  int checkTime;

  BFS(Board board, Move[] allowed)
  {
    this.allowed = allowed;
    this.frontier = new ArrayList<Board>();
    frontier.add(board);
    this.visited = new ArrayList<int[][]>();
    visited.add(board.board);
  }

  void printSolution()
  {
    if(solution == null)
      solution = solution();
    println("solution: ");
    printSolution(solution);
  }

  void printSolution(Board solution)
  {
    if (solution.parent != null)
    {
      printSolution(solution.parent);
      println("(" + solution.lastSelected.y + ", " + solution.lastSelected.x + ") " + solution.lastMove);
    }
  }

  Board solution()
  {
    this.checkTime = 0;
    while(true)
    {
      if (frontier.isEmpty())
        return null;
      Board current = frontier.remove(0);
      for (int i = 0; i < current.arrayDim; i++)
        for (int j = 0; j < current.arrayDim; j++)
          if (current.get(i, j) > 0)
            for (Move move : allowed)
            {
              Board copy = current.copy();
              copy.move(new PVector(i, j), move);
              
              int t0 = millis();
              int boardPos = Collections.binarySearch(visited, copy.board, comparator);
              checkTime += millis() - t0;
              
              if (boardPos<0)
              {
                if(copy.isWin())
                  return copy;
                frontier.add(copy);
                visited.add(-boardPos-1, copy.board);
              }
            }
    } //<>// //<>//
  }
}
