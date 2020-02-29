class DifficultyLoadInterface extends TextInterface
{
  File typeDir;
  GameType gameType;
  int[] difficulties;
  
  DifficultyLoadInterface(Interface parentInFa, File typeDir, GameType gameType)
  {
    super
    (
      parentInFa,
      DLI_getLine(typeDir)
    );
    this.typeDir = typeDir;
    this.gameType = gameType;
    this.difficulties = u_toIntArray(typeDir.list());
  }
  
  void performWhenDone()
  {
    int answer = answers[0];
    if(u_contains(difficulties, answer))
      inFa = new SelectPuzzleInterface(this, new File(typeDir, Integer.toString(answer)), gameType);
    else
      inFa = new DifficultyLoadInterface(this, typeDir, gameType);
  }
  
  void resize()
  {
    surface.setSize(1000, max(4, (questions.length + 2)) * textSize);
  }
}

String DLI_getLine(File typeDir)
{
  int[] difs = u_toIntArray(typeDir.list());
  Arrays.sort(difs);
  return "[" + String.join(",", u_toStringArray(difs)) + "]?";
}
