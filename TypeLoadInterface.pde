class TypeLoadInterface extends TextInterface
{
  TypeLoadInterface(Interface parentInFa)
  {
    super
    (
      parentInFa,
      TLI_getLine()
    );
  }
  
  void performWhenDone()
  {
    String[] options = savesDir.exists()?savesDir.list():null;
    if(options == null)
    {
      inFa = new Welcome();
      return;
    }
    inFa = new DifficultyLoadInterface(this, new File(savesDir, options[answers[0]-1]), GameType.toType(options[answers[0]-1]));
  }
}

static String TLI_getLine()
{
  String[] options;
  if(!savesDir.exists() || (options=savesDir.list()).length == 0)
    return "No saves (1)";
  StringBuilder sb = new StringBuilder();
  for(int i=0; i<options.length; i++)
    sb.append((i==0?"":" or ")+options[i]+"("+(i+1)+")");
  sb.append("?");
  return sb.toString();
}
