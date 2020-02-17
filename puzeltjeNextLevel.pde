import processing.sound.*;
SoundFile file;
Interface inFa;
boolean[] KEYS;

void setup()
{
  noLoop();
  size(500, 500);
  resetKeys();
  file = new SoundFile(this, "zelda.mp3");
  inFa = new Welcome();
}

void draw()
{
  inFa.iterate();
}

//import processing.sound.*;
//SoundFile file;
//Interface inFa;
//boolean[] KEYS;

//void setup()
//{
//  noLoop();
//  size(500, 500);
//  ellipseMode(CORNER);
//  resetKeys();
//}

//void draw()
//{
//  //Board b = new Board(5);
//  Move[] allowed = new Move[]{Move.LEFT, Move.RIGHT, Move.UP, Move.DOWN};
//  //b.goals = new PVector[]{new PVector(2,2)};
//  //b.set(3, 3, 1);
//  //b.set(1, 2, 2);
//  //b.set(3, 1, 2);
//  //showBoard(b, 100);
//  DifsCheck dc = new DifsCheck(5, 1, 3, allowed);
//  println(dc.maxDif());
//}

//void showBoard(Board b, int squareSize)
//{
//  for (int i=0; i<b.arrayDim; i++)
//    for (int j=0; j<b.arrayDim; j++)
//    {
//      fill(0);
//      for(PVector goal : b.goals)
//        if (goal.x == i && goal.y == j)
//          fill(255, 0, 0);
//      strokeWeight(1);
//      stroke(255);
//      rect(i*squareSize, j*squareSize, squareSize, squareSize);
//      if (b.get(i, j) == 1)
//      {
//        fill(0, 0, 255);
//        ellipse(i*squareSize, j*squareSize, squareSize, squareSize);
//      } else if (b.get(i, j) > 1)
//      {
//        fill(0, 255, 0);
//        ellipse(i*squareSize, j*squareSize, squareSize, squareSize);
//      }
//    }
//}
