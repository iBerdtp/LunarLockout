enum Move
{
  UP(0,-1, "U"),UP_RIGHT(1,-1,"UL"),LEFT(-1,0, "L"),RIGHT(1,0, "R"),DOWN_LEFT(-1,1,"DR"),DOWN(0,1, "D");
 
  private PVector v;
  private String string;
  
  private Move(int x, int y, String string)
  {
    this.v = new PVector(x, y);
    this.string = string;
  }
  
  PVector vector()
  {
    return v;
  }
  
  public String toString()
  {
    return this.string;
  }
}
