class StaticScene extends Scene { //<>// //<>// //<>//
  PImage image;
  ArrayList<Button> buttons;

  String state = "";

  StaticScene (String sceneName, String imageFile, ArrayList<Button> buttons) {
    super(sceneName);
    image = loadImage(imageFile);
    this.buttons = buttons;
  }

  public String getState() {
    return state;
  }

  @Override
    public void draw() {
    background(255);
    image(image, 0, 0);
  }

  public void mouseClicked() {
    for (Button button : buttons) {
      state = button.mouseClicked();
      if (state != "")
        break;
    }
  }
}

class Button {
  int x1, x2;
  int y1, y2;

  String text;

  Button (String text, int x1, int x2, int y1, int y2) {
    this.text = text;

    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
 //<>// //<>// //<>//
  public String mouseClicked() {
    if ((mouseX > x1 && mouseX < x2) && (mouseY > y1 && mouseY < y2)) {
      return text;
    }
    return "";
  }
}
