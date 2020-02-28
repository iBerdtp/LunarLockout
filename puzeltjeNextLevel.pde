import processing.sound.*;
import java.util.Comparator;
import java.util.Collections;

void setup()
{
  size(500, 500);
  util.resetKeys();
  file = new SoundFile(this, "zelda.mp3");
  inFa = new Welcome();
}

void draw()
{
  inFa.superIterate();
}

void keyPressed()
{
  KEYS[keyCode] = true;
  if(keyCode == 'R')
    setup();
  redraw();
}

void mousePressed()
{
  redraw();
}


SoundFile file;
Interface inFa;
boolean[] KEYS;
final Util util = new Util();
final String savesPath = "C:\\Users\\Bert\\Documents\\PROCESSING\\PROJECJES\\puzeltjeNextLevel\\saves\\";
final File savesDir = new File(savesPath);
final float ellipseFactor = 0.8;
final int regSquareSize = 100;
final int SQUARE = 0;
final int HEX = 1;

final Comparator<int[][]> comparator = new Comparator<int[][]>()
{
  // assumes same dimensions
  @Override
  public int compare(int[][] a, int[][] b)
  {
    for(int y=0; y<a.length; y++)
      for(int x=0; x<a[y].length; x++)
        if(a[x][y] == b[x][y])
          continue;
        else
          return a[x][y] - b[x][y];
    return 0;
  }
};
