class DialogueOption {
  private String text;
  
  private int x, y;
  private int owidth, oheight;
  
  public DialogueOption(String text, int x, int y, int owidth) {
    this.text = text;
    
    this.x = x;
    this.y = y;
    this.owidth = owidth;
    
    textSize(owidth);
    this.oheight = (int)textWidth(text);
  }
  
  public void draw() {
    text(text, x, y);
  }
}
