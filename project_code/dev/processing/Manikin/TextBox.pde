class TextBox
{
  private int maxLines;
  private int fontSize;
  private ArrayList lines = new ArrayList();

  public TextBox(int maxLines, int fontSize) {
    this.maxLines = maxLines;
    this.fontSize = fontSize;
  }

  public void clear() { 
    lines.clear();
  }

  public void add(String line) { 
    String s="";
    if (lines.size()>0)
      s=(String)lines.get(lines.size()-1);

    if (!s.equals(line))
      lines.add(line);

    if (lines.size()>maxLines)
      lines.remove(0);
  }

  public void draw(int x, int y) {
    for (int i=0;i<lines.size();i++) {
      textSize(fontSize);
      text((String)lines.get(i), x, y+i*(fontSize*1.2));
    }
  }
};

