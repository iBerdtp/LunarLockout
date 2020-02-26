class SelectPuzzleInterface extends Interface
{
  File puzzlesDir;
  String puzzlesPath;
  String[] list;
  int currentIndex;
  Board currentOption;
  int squareSize;
  int borderSize;
  
  SelectPuzzleInterface(File puzzlesDir)
  {
    this.puzzlesDir = puzzlesDir;
    this.puzzlesPath = puzzlesDir.getPath();
    this.list = puzzlesDir.list();
    this.currentIndex = 0;
    this.currentOption = loadPuzzle(list[currentIndex]);
    this.squareSize = 60;
    this.borderSize = 100;
  }
  
  void handleInput()
  {
    if(KEYS[RIGHT])
      currentOption = loadPuzzle(list[currentIndex = (currentIndex + 1) % list.length]);
    if(KEYS[LEFT])
      currentOption = loadPuzzle(list[currentIndex = (currentIndex>0?currentIndex-1:list.length-1)]);
    if(KEYS[ENTER])
      startPuzzle();
  }
  
  void iterate()
  {
    background(75);
    int screenDim = 2*borderSize + currentOption.arrayDim*squareSize;
    surface.setSize(screenDim, screenDim);
    util.showSquareBoard(currentOption, borderSize);
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
    inFa = new SquareGame(currentOption, file, new Move[]{Move.UP, Move.LEFT, Move.RIGHT, Move.DOWN}, new int[]{UP, LEFT, RIGHT, DOWN}, SHIFT);
  }
}
