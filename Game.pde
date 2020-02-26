abstract class Game extends Interface
{
  SoundFile file;
  int arrayDim;
  int squareSize;
  int nrOfGoals;
  int nrOfPawns;
  int optimal;
  Board initial;
  Board current;
  PVector selected;
  Move move;
  boolean won;
  Move[] allowed;
  int[] moveControls;
  int switchControl;
  HashMap<Integer, Move> map;
  boolean newGame;
  
  Game(int arrayDim, int nrOfGoals, int nrOfPawns, int optimal, SoundFile file, Move[] allowed, int[] moveControls, int switchControl)
  {
    this.arrayDim = arrayDim;
    this.squareSize = 100;
    this.nrOfGoals = nrOfGoals;
    this.nrOfPawns = nrOfPawns;
    this.optimal = optimal;
    this.file = file;
    this.allowed = allowed;
    this.moveControls = moveControls;
    this.switchControl = switchControl;
    this.newGame = true;
    setMap(moveControls, allowed);
    setAdditional();
    createNewPuzzle();
  }
  
  Game(Board board, SoundFile file, Move[] allowed, int[] moveControls, int switchControl)
  {
    this.arrayDim = board.arrayDim;
    this.squareSize = 100;
    this.file = file;
    this.allowed = allowed;
    this.moveControls = moveControls;
    this.switchControl = switchControl;
    this.newGame = false;
    setMap(moveControls, allowed);
    setAdditional();
    setBoard(board);
  }
  
  void iterate()
  {
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
      
    if (KEYS['S'])
      savePuzzle(initial, optimal, this.getClass().getName());
  }
  
  void createNewPuzzle()
  {
    if(!newGame)
      return;
    initial = generate(arrayDim, nrOfGoals, nrOfPawns, optimal, allowed);
    reset();
  }
  
  void setBoard(Board board)
  {
    initial = board;
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

  Board generate(int arrayDim, int nrOfGoals, int nrOfPawns, int optimal, Move[] allowed)
  {
    IntList possibleDifs = new IntList();
    int tried = 0;
    while (true)
    {
      tried++;
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
      if (solution != null && solution.depth == optimal)
      {
        println("solvable in " + solution.depth);
        board.depth = 0;
        println("tried " + tried);
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
