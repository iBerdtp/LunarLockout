abstract class Game extends Interface
{
  SoundFile file;
  int arrayDim;
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
  HashMap<Integer, Move> map;
  boolean newGame;
  boolean alreadySaved;
  
  private Game(Interface parentInFa, int arrayDim, SoundFile file, Move[] allowed, int[] moveControls)
  {
    this.parentInFa = parentInFa;
    this.arrayDim = arrayDim;
    this.file = file;
    this.allowed = allowed;
    this.moveControls = moveControls;
    this.alreadySaved = true;
  }
  
  Game(Interface parentInFa, int arrayDim, int nrOfGoals, int nrOfPawns, int optimal, SoundFile file, Move[] allowed, int[] moveControls)
  {
    this(parentInFa, arrayDim, file, allowed, moveControls);
    this.nrOfGoals = nrOfGoals;
    this.nrOfPawns = nrOfPawns;
    this.optimal = optimal;
    this.newGame = true;
    setMap(moveControls, allowed);
    setAdditional();
    createNewPuzzle();
  }
  
  Game(Interface parentInFa, Board board, SoundFile file, Move[] allowed, int[] moveControls)
  {
    this(parentInFa, board.arrayDim, file, allowed, moveControls);
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
      if (KEYS[SHIFT] || KEYS[TAB])
        selected = current.getNext(selected);
      else
        for(int c : moveControls)
          if(KEYS[c])
          {
            selected = current.move(selected, map.get(c));
            break;
          }
  
    if (KEYS[ENTER])
      if(newGame)
        createNewPuzzle();
      else
        inFa = parentInFa;
  
    if (KEYS[BACKSPACE])
      backToParent();
    
    if (KEYS['Z'])
      reset();
    
    if (KEYS['S'] && !alreadySaved)
    {
      u_savePuzzle(initial, this.getClass().getName());
      alreadySaved = true;
    }
  }
  
  void createNewPuzzle()
  {
    initial = generate(arrayDim, nrOfGoals, nrOfPawns, optimal, allowed);
    alreadySaved = false;
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
    int t0 = millis();
    while (true)
    {
      tried++;
      if(tried==10000)
        println((millis() - t0)/1000f);
      // square 5x5 goals 3 pawns 3: 37.061 s
      Board board = new Board(arrayDim);
      fillAccordingly(board, nrOfGoals, nrOfPawns);
      BFS bfs = new BFS(board, allowed);
      //int t0 = millis();
      Board solution = bfs.solution();
      //float totalTime = millis() - t0;
      //float visitedSize = bfs.visited.size();
      //println("totaltime: " + totalTime);
      //println("checktime: " + bfs.checkTime);
      //println("configurations visited: " + visitedSize);
      //println("total time per configuration: " + totalTime/visitedSize + "\n");
      if(solution != null && !possibleDifs.hasValue(solution.depth))
      {
        possibleDifs.append(solution.depth);
        possibleDifs.sort();
        println("possible difs: " + possibleDifs);
      }
      if (solution != null && solution.depth >= optimal)
      {
        println("solvable in: " + solution.depth);
        board.depth = 0;
        board.setDifficulty(solution.depth);
        println("tried: " + tried);
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
