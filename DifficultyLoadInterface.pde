class DifficultyLoadInterface extends TextInterface
{
  File typeDir;
  String type;
  int[] difficulties;
  
  DifficultyLoadInterface(File typeDir, String type)
  {
    super
    (
      "What difficulty (" + String.join(", ", typeDir.list()) + ")?"
    );
    this.typeDir = typeDir;
    this.type = type;
    this.difficulties = util.toIntArray(typeDir.list());
  }
  
  void performWhenDone()
  {
    int answer = answers[0];
    if(util.contains(difficulties, answer))
      inFa = new SelectPuzzleInterface(new File(typeDir, Integer.toString(answer)));
    else
      inFa = new DifficultyLoadInterface(typeDir, type);
  }
}
