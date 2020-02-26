// abstract class want defualt methods mogen niet fsr
abstract class Interface
{
  void superIterate()
  {
    handleInput();
    resetKeys();
    iterate();
  }
  
  abstract void handleInput();
  abstract void iterate();
}
