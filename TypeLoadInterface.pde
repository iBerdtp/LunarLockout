class TypeLoadInterface extends TextInterface
{
  boolean squareExists, hexExists;
  
  TypeLoadInterface(boolean squareExists, boolean hexExists)
  {
    super
    (
      squareExists && hexExists ? "Square(1) or Hex(2)?" : squareExists ? "Square (1)" : hexExists ? "Hex (1)" : "No saves (1)"
    );
    this.squareExists = squareExists;
    this.hexExists = hexExists;
  }
  
  void performWhenDone()
  {
    String type;
    if(answers[0] == 1 && squareExists)
      type = "SquareGame";
    else if(hexExists)
      type = "HexGame";
    else
    {
      inFa = new Welcome();
      return;
    }
    inFa = new DifficultyLoadInterface(new File(savesDir, type), type);
  }
}
