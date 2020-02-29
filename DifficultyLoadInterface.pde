class DifficultyLoadInterface extends TextInterface
{
  File typeDir;
  BoardType boardType;
  int[] difficulties;
  
  DifficultyLoadInterface(Interface parentInFa, File typeDir, BoardType boardType)
  {
    super
    (
      parentInFa,
      DLI_getLine(typeDir)
    );
    this.typeDir = typeDir;
    this.boardType = boardType;
    this.difficulties = u_toIntArray(typeDir.list());
  }
  
  void performWhenDone()
  {
    int answer = answers[0];
    if(u_contains(difficulties, answer))
      inFa = new SelectPuzzleInterface(this, new File(typeDir, Integer.toString(answer)), boardType);
    else
      inFa = new DifficultyLoadInterface(this, typeDir, boardType);
  }
}

String DLI_getLine(File typeDir)
{
  int[] difs = u_toIntArray(typeDir.list());
  Arrays.sort(difs);
  return "[" + String.join(",", u_toStringArray(difs)) + "]?";
}
