class SelectPuzzleInterface extends Interface
{
  File puzzlesDir;
  String puzzlesPath;
  String[] list;
  int currentIndex;
  Board currentOption;
  int borderSize;
  int boardType;
  
  SelectPuzzleInterface(Interface parentInFa, File puzzlesDir, int boardType)
  {
    this.parentInFa = parentInFa;
    this.puzzlesDir = puzzlesDir;
    this.puzzlesPath = puzzlesDir.getPath();
    this.list = puzzlesDir.list();
    this.currentIndex = 0;
    this.currentOption = loadPuzzle(list[currentIndex]);
    this.borderSize = 50;
    this.boardType = boardType;
    resize();
  }
  
  void resize()
  {
    if(boardType == SQUARE)
      surface.setSize(5 * regSquareSize, 5 * regSquareSize);
    else if(boardType == HEX)
      surface.setSize(5*regSquareSize, ceil(sqrt(3)*(3-1)*regSquareSize+regSquareSize));
  }
  
  void handleInput()
  {
    if(KEYS[RIGHT])
      currentOption = loadPuzzle(list[currentIndex = (currentIndex + 1) % list.length]);
    if(KEYS[LEFT])
      currentOption = loadPuzzle(list[currentIndex = (currentIndex>0?currentIndex-1:list.length-1)]);
    if(KEYS[ENTER])
      startPuzzle();
    if(KEYS[BACKSPACE])
      backToParent();
  }
  
  void iterate()
  {
    background(75);
    if(boardType == SQUARE)
      util.showSquareBoard(currentOption, borderSize);
    else if(boardType == HEX)
      util.showHexBoard(currentOption, borderSize);
  }
  
  Board loadPuzzle(String puz)
  {
    String[] strings = loadStrings(puzzlesPath + "\\" + puz);
    int dim = Integer.parseInt(strings[0]);
    int[][] intses = new int[dim][dim];
    for(int y=0; y<dim; y++)
    {
      int[] row = util.toIntArray(strings[1+y].split(" "));
      for(int x=0; x<dim; x++)
        intses[x][y] = row[x];
    }
    int nrOfGoals = Integer.parseInt(strings[dim+1]);
    PVector[] goals = new PVector[nrOfGoals];
    for(int i=0; i<nrOfGoals; i++)
    {
      int[] coordinates = util.toIntArray(strings[dim+2+i].split(" "));
      goals[i] = new PVector(coordinates[0], coordinates[1]);
    }
    return new Board(dim, goals, intses);
  }
  
  void startPuzzle()
  {
    if(boardType == SQUARE)
      inFa = new SquareGame(this, currentOption, file, new Move[]{Move.UP, Move.LEFT, Move.RIGHT, Move.DOWN}, new int[]{UP, LEFT, RIGHT, DOWN});
    else if(boardType == HEX)
      inFa = new HexGame(this, currentOption, file, new Move[]{Move.UP, Move.LEFT, Move.DOWN_LEFT, Move.UP_RIGHT, Move.RIGHT, Move.DOWN}, new int[]{36, 37, 35, 33, 39, 34});
  }
}
