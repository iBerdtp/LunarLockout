// abstract class want defualt methods mogen niet fsr
abstract class Interface
{
  void superIterate()
  {
    handleInput();
    iterate();
    resetKeys();
  }
  
  abstract void handleInput();
  abstract void iterate();
}
