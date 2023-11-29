class DialogueOption {
  private String text;
  private String[] responces;

  private int x, y;
  private int owidth, oheight;

  int countResponce = 0;
  int currentTime = 0;

  private boolean isInResponce = false;

  public DialogueOption(String text, int x, int y, int oheight, String responce) {
    this.text = text;
    this.responces = responce.split("::", 0);

    this.x = x;
    this.y = y;
    this.oheight = oheight;

    this.owidth = width - x * 2;
  }

  public boolean getIsInResponce() {
    return isInResponce;
  }

  public void draw() {
    text(text, x, y);
  }

  public void drawResponce() {
    int time = millis() / 1000;
    if (currentTime == 0) {
      currentTime = time;
    }

    if (countResponce == responces.length) {
      countResponce = 0; //<>// //<>//
      currentTime = 0;
      isInResponce = false;
    } else {
      textAlign(CENTER, CENTER);
      text(responces[countResponce], width / 2, height / 2);
    }

    if (time - currentTime == 2) {
      currentTime = time;
      countResponce++;
    }
  }

  public boolean isGoodbye() {
    if (responces[0] == "LEAVE") {
      return true;
    }
    return false;
  }

  public boolean mouseClicked() {
    if ((mouseX > x && mouseX < x + owidth)
      && (mouseY > y && mouseY < y + oheight)) {
      isInResponce = true;
      return true;
    }
    return false;
  }
}
