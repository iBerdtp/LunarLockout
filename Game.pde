abstract class Game implements Interface
{
  SoundFile file;
  int arrayDim;
  int squareSize;
  int nrOfGoals;
  int nrOfPawns;
  int min;
  int max;
  Board initial;
  Board current;
  PVector selected;
  Move move;
  boolean won;
  Move[] allowed;
  int[] moveControls;
  int switchControl;
  HashMap<Integer, Move> map;
  
  Game(int arrayDim, int nrOfGoals, int nrOfPawns, int min, int max, SoundFile file, Move[] allowed, int[] moveControls, int switchControl)
  {
    this.arrayDim = arrayDim;
    this.squareSize = 100;
    this.nrOfGoals = nrOfGoals;
    this.nrOfPawns = nrOfPawns;
    this.min = min;
    this.max = max;
    this.file = file;
    this.allowed = allowed;
    this.moveControls = moveControls;
    this.switchControl = switchControl;
    setMap(moveControls, allowed);
    setAdditional();
    createNewPuzzle();
    loop();
  }
  
  void iterate()
  {
    noLoop();
    handleInput();
    background(75);
    showBoard();
    showSelected();
    if(!won)
      checkForWin();
  }
  
  void handleInput()
  {
    if (!won)
      if (KEYS[switchControl])
        selected = current.getNext(selected);
      else
        for(int c : moveControls)
          if(KEYS[c])
          {
            selected = current.move(selected, map.get(c));
            break;
          }
  
    if (KEYS[ENTER])
      createNewPuzzle();
  
    if (KEYS[BACKSPACE])
      reset();
      
    resetKeys();
  }
  
  void createNewPuzzle()
  {
    initial = generate(arrayDim, nrOfGoals, nrOfPawns, min, max, allowed);
    reset();
  }
  
  void reset()
  {
    current = initial.copy();
    won = false;
    move = null;
    for (int i=0; i<current.arrayDim; i++)
      for (int j=0; j<current.arrayDim; j++)
        if (current.get(i, j) == 1)
        {
          selected = new PVector(i, j);
          return;
        }
  }
  
  void checkForWin()
  {
    if (current.isWin())
    {
      println("won in " + current.depth + " moves");
      file.play();
      won = true;
    }
  }
  
  void setMap(int[] controls, Move[] allowed)
  {
    if(controls.length!=allowed.length)
      throw new IllegalArgumentException("wrong controls move thing");
    map = new HashMap<Integer, Move>();
    for(int i=0; i<allowed.length; i++)
      map.put(controls[i], allowed[i]);
  }

  Board generate(int arrayDim, int nrOfGoals, int nrOfPawns, int minimumDepth, int maximumDepth, Move[] allowed)
  {
    IntList possibleDifs = new IntList();
    while (true)
    {
      Board board = new Board(arrayDim);
      fillAccordingly(board, nrOfGoals, nrOfPawns);
      BFS bfs = new BFS(board, allowed); 
      Board solution = bfs.solution();
      if(solution != null && !possibleDifs.hasValue(solution.depth))
      {
        possibleDifs.append(solution.depth);
        possibleDifs.sort();
        println("possible difs: " + possibleDifs);
      }
      if (solution != null && solution.depth >= minimumDepth && solution.depth <= maximumDepth)
      {
        println("solvable in " + solution.depth);
        board.depth = 0;
        return board;
      }
    }
  }
  
  Board randomBoard(int dim, int nrOfGoals, int nrOfPawns)
  {
    Board b = new Board(dim);
    fillAccordingly(b, nrOfGoals, nrOfPawns);
    return b;
  }
  
  abstract void setAdditional();
  abstract void fillAccordingly(Board b, int nrOfGoals, int nrOfPawns);
  abstract void showBoard();
  abstract void showSelected();
}
