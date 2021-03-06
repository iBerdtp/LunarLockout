abstract class TextInterface extends Interface
{
  int textSize;
  String[] questions;
  int[] answers;
  String text;
  int index;
  
  TextInterface(Interface parentInFa, String... questions)
  {
    this.parentInFa = parentInFa;
    this.textSize = 32;
    textSize(textSize);
    this.questions = questions;
    resize();
    this.answers = new int[questions.length];
    this.text = "";
    this.index = 0;
  }
  
  void resize()
  {
    surface.setSize(600, max(4, (questions.length + 2)) * textSize);
  }
  
  void handleInput()
  {
    if(KEYS[ENTER] && text.length()>0)
    {
      answers[index++] = Integer.parseInt(text);
      text = "";
    } 
    else
    {
      for(int i=48; i<58; i++)
        if(KEYS[i])
          text += i-48;
      if(KEYS[BACKSPACE])
      {
        if(!text.equals(""))
          text = "";
        else if(index>0)
          index--;
        else if(parentInFa != null)
          backToParent();
      }
    }
  }
  
  void iterate()
  {
    if(index == questions.length)
    {
      performWhenDone();
      index--;
    }
    else
    {
      fill(255);
      background(textBackground);
      if(focused)
      {
        printAnswered();
        printCurrent();
      }
      else
        printClick();
    }
  }
  
  abstract void performWhenDone();
  
  void printAnswered()
  {
    textAlign(LEFT, TOP);
    for(int i=0; i<index; i++)
      text(questions[i] + " " + answers[i], 0, i*textSize);
  }
  
  void printCurrent()
  {
    textAlign(CENTER);
    text(questions[index] + " " + text, width/2, height - textSize/2);
  }
  
  void printClick()
  {
    textAlign(CENTER);
    text("CLICK IN SCREEN", width/2, height/2);
  }
}
