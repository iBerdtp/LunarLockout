class Welcome extends TextInterface
{
  Welcome()
  {
    super
    (
      "New Game (1) or Load (2)?"
    );
  }
  
  void performWhenDone()
  {
    if(answers[0] == 1)
      inFa = new NewGameInterface();
    else
      inFa = new TypeLoadInterface(new File(savesDir, "SquareGame").exists(), new File(savesDir, "HexGame").exists());
  }
} //<>//
