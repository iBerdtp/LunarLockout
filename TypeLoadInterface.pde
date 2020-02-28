class TypeLoadInterface extends TextInterface
{
  boolean squareExists, hexExists;
  
  TypeLoadInterface(Interface parentInFa, boolean squareExists, boolean hexExists)
  {
    super
    (
      parentInFa,
      squareExists && hexExists ? "Square(1) or Hex(2)?" : squareExists ? "Square (1)" : hexExists ? "Hex (1)" : "No saves (1)"
    );
    this.squareExists = squareExists;
    this.hexExists = hexExists;
  }
  
  void performWhenDone()
  {
    int boardType;
    if(answers[0] == 1 && squareExists)
      boardType = SQUARE;
    else if(hexExists)
      boardType = HEX;
    else
    {
      inFa = new Welcome();
      return;
    }
    inFa = new DifficultyLoadInterface(this, new File(savesDir, boardType==SQUARE?"SquareGame":"HexGame"), boardType);
  }
}
