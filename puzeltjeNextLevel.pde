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
