class DifficultyLoadInterface extends TextInterface
{
  File typeDir;
  int boardType;
  int[] difficulties;
  
  DifficultyLoadInterface(Interface parentInFa, File typeDir, int boardType)
  {
    super
    (
      parentInFa,
      "What difficulty (" + String.join(", ", typeDir.list()) + ")?"
    );
    this.typeDir = typeDir;
    this.boardType = boardType;
    this.difficulties = util.toIntArray(typeDir.list());
  }
  
  void performWhenDone()
  {
    int answer = answers[0];
    if(util.contains(difficulties, answer))
      inFa = new SelectPuzzleInterface(this, new File(typeDir, Integer.toString(answer)), boardType);
    else
      inFa = new DifficultyLoadInterface(this, typeDir, boardType);
  }
}
