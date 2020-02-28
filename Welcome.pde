class Welcome extends TextInterface
{
  Welcome()
  {
    super
    (
      null,
      "New Game (1) or Load (2)?"
    );
  }
  
  void performWhenDone()
  {
    if(answers[0] == 1)
      inFa = new NewGameInterface(this);
    else
      inFa = new TypeLoadInterface(this, new File(savesDir, "SquareGame").exists(), new File(savesDir, "HexGame").exists());
  }
  
  String toString()
  {
    return "Welcome";
  }
} //<>//
