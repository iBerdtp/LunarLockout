import processing.sound.*;
SoundFile file;
Interface inFa;
boolean[] KEYS;
final Util util = new Util();
final String savesPath = "C:\\Users\\Bert\\Documents\\PROCESSING\\PROJECJES\\puzeltjeNextLevel\\saves\\";
final File savesDir = new File(savesPath);

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
