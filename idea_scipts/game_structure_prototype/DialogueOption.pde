class DialogueOption { //<>//
  private String text;
  private String[] responces;

  private int x, y;
  private int owidth, oheight;

  private int countResponce = 0;
  private int currentTime = 0;
  private int readTime = 0;

  private boolean isInResponce = false;
  private boolean firstTimeNotInResponce = false;

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

  public String getText() {
    return text;
  }

  public void draw() {
    if (text.contains("_")) {
      text(text.substring(0, text.indexOf("_")), x, y);
    } else {
      text(text, x, y);
      ;
    }
  }

  public void drawResponce() {
    int time = millis() / 1000;
    if (currentTime == 0) {
      currentTime = time;

      int currentResponceLength = responces[countResponce].length();
      readTime = currentResponceLength < 20 ? 1 : (currentResponceLength >= 20 && currentResponceLength < 60 ? 2
        : (currentResponceLength >= 60 && currentResponceLength < 110 ? 3 : 10));
    }

    if (countResponce == responces.length) {
      countResponce = 0;
      currentTime = 0;
      isInResponce = false;
      firstTimeNotInResponce = true;
    } else {
      textAlign(CENTER, CENTER);
      text(responces[countResponce], width / 2, height / 2);
    }

    if (time - currentTime == readTime) {
      currentTime = time;
      countResponce++;

      if (countResponce != responces.length) {
        int currentResponceLength = responces[countResponce].length();
        readTime = currentResponceLength < 20 ? 1 : (currentResponceLength >= 20 && currentResponceLength < 60 ? 2
          : (currentResponceLength >= 60 && currentResponceLength < 110 ? 3 : 10));
      }
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
