class DialogueOption { //<>//
  private String text;
  private String[] responces;

  private int x, y;
  private int owidth, oheight;

  int countResponce = 0;

  private boolean isInResponce = false;

  public DialogueOption(String text, int x, int y, int oheight, String responce) {
    this.text = text;
    this.responces = responce.split("::", 0);

    this.x = x;
    this.y = y;
    this.oheight = oheight;

    textSize(oheight);
    this.owidth = (int)textWidth(text);
  }

  public boolean getIsInResponce() {
    return isInResponce;
  }

  public void draw() {
    text(text, x, y);
  }

  public void drawResponce() {
    if (countResponce == responces.length) {
      countResponce = 0;
      isInResponce = false;
    } else {
      textAlign(CENTER, CENTER);
      text(responces[countResponce], width / 2, height / 2);
    }
    if (frameCount % 90 == 0 && responces.length > 1) {
      countResponce++;
    }
  }

  public boolean isGoodbye() {
    if (responces[0] == "LEAVE") {
      isInResponce = false;
      return true;
    }
    return false;
  }

  public boolean mouseClicked() {
    println(mouseX > x && mouseX < x + owidth);
    if ((mouseX > x && mouseX < x + owidth)
      && (mouseY > y && mouseY < y + oheight)) {
      isInResponce = true;
      return true;
    }
    return false;
  }
}
