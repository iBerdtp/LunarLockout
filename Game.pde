abstract class Game extends Interface
{
  GameType gameType;
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
  IntList possibleDifs;
  
  private Game(Interface parentInFa, GameType gameType, int arrayDim)
  {
    this.parentInFa = parentInFa;
    this.gameType = gameType;
    this.arrayDim = arrayDim;
    this.allowed = gameType.getAllowed();
    this.moveControls = gameType.getMoveControls();
    this.alreadySaved = true;
    this.possibleDifs = new IntList();
  }
  
  Game(Interface parentInFa, GameType gameType, int arrayDim, int nrOfGoals, int nrOfPawns, int optimal)
  {
    this(parentInFa, gameType, arrayDim);
    this.nrOfGoals = nrOfGoals;
    this.nrOfPawns = nrOfPawns;
    this.optimal = optimal;
    this.newGame = true;
    setMap(moveControls, allowed);
    setAdditional();
    createNewPuzzle();
  }
  
  Game(Interface parentInFa, GameType gameType, Board board)
  {
    this(parentInFa, gameType, board.arrayDim);
    this.newGame = false;
    setMap(moveControls, allowed);
    setAdditional();
    setBoard(board);
  }
  
  void iterate()
  {
    background(textBackground);
    gameStuff();
  }
  
  void gameStuff()
  {
    u_showBoard(gameType, current, 0);
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
      u_savePuzzle(initial, gameType);
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
    println();
    int tried = 0;
    int t0 = millis();
    int checkLimit = 10000;
    while (true)
    {
      tried++;
      if(tried==checkLimit)
        println("tried "+checkLimit+" in "+(millis() - t0)/1000f+"s");
      //// square 5x5 goals 3 pawns 3: 37.061 s
      Board board = new Board(gameType, arrayDim);
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
        println("tried: " + tried);
        println("solvable in: " + solution.depth);
        board.depth = 0;
        board.setDifficulty(solution.depth);
        return board;
      }
    }
  }
  
  Board randomBoard(int dim, int nrOfGoals, int nrOfPawns)
  {
    Board b = new Board(gameType, dim);
    fillAccordingly(b, nrOfGoals, nrOfPawns);
    return b;
  }
  
  void printLooking()
  {
    textAlign(CENTER,CENTER);
    text("Looking for match...\nFound puzzles in range:\n[",width/2,height/2);
  }
  
  abstract void setAdditional();
  abstract void fillAccordingly(Board b, int nrOfGoals, int nrOfPawns);
  abstract void showSelected();
}
