abstract class Interactable extends GameObject {
  protected boolean mouseIsHovering;

  protected Interactable (String identifier, int x, int y, String gameObjectImageFile) {
    super(identifier, x, y, gameObjectImageFile);
    mouseIsHovering = false;
  }

  protected abstract void draw();
  
  protected void updatePos(int speed) {
    x += speed;
  }

  protected boolean mouseMoved() {
    mouseIsHovering = false;
    if ((mouseX > x - owidth / 2 && mouseX < x + owidth / 2)
      && (mouseY > y - oheight / 2 && mouseY < y + oheight / 2)) {
      mouseIsHovering = true;
    }

    return mouseIsHovering;
  }

  protected abstract boolean mouseClicked();
}
