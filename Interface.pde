// abstract class want defualt methods mogen niet fsr
abstract class Interface
{
  Interface parentInFa;
  
  void backToParent()
  {
    inFa = parentInFa;
    inFa.resize();
  }
  
  void superIterate()
  {
    handleInput();
    util.resetKeys();
    iterate();
  }
  
  abstract void handleInput();
  abstract void iterate();
  abstract void resize();
}
