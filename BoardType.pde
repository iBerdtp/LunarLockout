enum BoardType
{
  SQUARE("SquareGame"), HEX("HexGame");
  
  private String string;
  
  private BoardType(String string)
  {
    this.string = string;
  }
  
  String toString()
  {
    return string;
  }
  
  static BoardType toType(String s)
  {
    for(BoardType bt : values())
      if(s.equals(bt.toString()))
        return bt;
    return null;
  }
}
