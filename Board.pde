class Board //<>//
{
  int arrayDim;
  int[][] board;
  Board parent;
  PVector lastSelected;
  Move lastMove;
  int depth;
  PVector[] goals;
  
  Board(int arrayDim)
  {
    this.arrayDim = arrayDim;
    this.board = new int[arrayDim][arrayDim];
  }
  
  Board(int arrayDim, PVector[] goals, PVector[] pawns, PVector[] blues)
  {
    this(arrayDim);
    this.goals = goals;
    for(PVector v : pawns)
      set(v, 2);
    for(PVector v : blues)
      set(v, 1);
  }

  PVector move(PVector selected, Move move)
  {
    int type = get(selected);
    if (type > 0 && move != null)
    {
      lastSelected = selected.copy();
      lastMove = move;
      PVector direction = move.vector();
      PVector v = PVector.add(selected, direction);
      
      if(boundariesRespected(v) && get(v) == 0)
      {
        v.add(direction);
        while (boundariesRespected(v))
        {
          if (get(v) > 0)
          {
            v.sub(direction);
            set(v, type);
            if (!lastSelected.equals(v))
              set(lastSelected, 0);
            depth++;
            return v;
          }
          v.add(direction);
        }
      }
    }
    return selected;
  }
  
  boolean boundariesRespected(PVector v)
  {
    return v.x >= 0 && v.x < arrayDim && v.y >= 0 && v.y < arrayDim && get(v) != -1;
  }

  int get(int x, int y)
  {
    return board[y][x];
  }

  int get(PVector v)
  {
    return get((int)v.x, (int)v.y);
  }

  PVector getNext(PVector v)
  {
    int i = (int)v.x + 1;
    for (int j = (int)v.y; j<arrayDim; j++)
    {
      for (; i<arrayDim; i++)
        if (get(i, j) > 0)
          return new PVector(i, j);
      i = 0;
    }
    return getNext(new PVector(-1, 0));
    // kan oneindig bij leeg bord
  }

  void set(int x, int y, int n)
  {
    board[y][x] = n;
  }

  void set(PVector v, int n)
  {
    set((int)v.x, (int)v.y, n);
  }

  boolean isWin()
  {
    for(PVector goal : goals)
      if(get(goal) != 1)
        return false;
    return true;
  }
  
  Board copy()
  {
    Board b = new Board(this.arrayDim);
    for (int i = 0; i < b.arrayDim; i++)
      for (int j = 0; j < b.arrayDim; j++)
        b.set(i, j, get(i, j));
    b.goals = goals;
    b.depth = depth;
    b.parent = parent;
    return b;
  }
  
  String[][] toStringArray()
  {
    String[][] strArray = new String[arrayDim][arrayDim];
    for(int y=0; y<arrayDim; y++)
      for (int x=0; x<arrayDim; x++)
        for(PVector goal : goals)
          strArray[y][x]=get(x,y)+((goal.x == x && goal.y == y)?"g":"");
    return strArray;
  }
}
