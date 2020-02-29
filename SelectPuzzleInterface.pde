class SelectPuzzleInterface extends Interface
{
  File puzzlesDir;
  String puzzlesPath;
  String[] list;
  int currentIndex;
  Board currentOption;
  int borderSize;
  GameType gameType;
  
  SelectPuzzleInterface(Interface parentInFa, File puzzlesDir, GameType gameType)
  {
    this.parentInFa = parentInFa;
    this.puzzlesDir = puzzlesDir;
    this.puzzlesPath = puzzlesDir.getPath();
    this.list = puzzlesDir.list();
    this.currentIndex = 0;
    this.currentOption = loadPuzzle(list[currentIndex]);
    this.borderSize = 50;
    this.gameType = gameType;
    resize();
  }
  
  void resize()
  {
    if(gameType == GameType.SQUARE || gameType == GameType.DIAGONAL)
      surface.setSize(5 * regSquareSize, 5 * regSquareSize);
    else if(gameType == GameType.HEX)
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
    background(textBackground);
    u_showBoard(gameType, currentOption, borderSize);
  }
  
  Board loadPuzzle(String puz)
  {
    String[] strings = loadStrings(puzzlesPath + "\\" + puz);
    int dim = Integer.parseInt(strings[0]);
    int[][] intses = new int[dim][dim];
    for(int y=0; y<dim; y++)
    {
      int[] row = u_toIntArray(strings[1+y].split(" "));
      for(int x=0; x<dim; x++)
        intses[x][y] = row[x];
    }
    int nrOfGoals = Integer.parseInt(strings[dim+1]);
    PVector[] goals = new PVector[nrOfGoals];
    for(int i=0; i<nrOfGoals; i++)
    {
      int[] coordinates = u_toIntArray(strings[dim+2+i].split(" "));
      goals[i] = new PVector(coordinates[0], coordinates[1]);
    }
    return new Board(gameType, dim, goals, intses);
  }
  
  void startPuzzle()
  {
    if(gameType == GameType.SQUARE)
      inFa = new SquareGame(this, GameType.SQUARE, currentOption);
    else if(gameType == GameType.HEX)
      inFa = new HexGame(this, currentOption);
    else if(gameType == GameType.DIAGONAL)
      inFa = new SquareGame(this, GameType.DIAGONAL, currentOption);
  }
}
