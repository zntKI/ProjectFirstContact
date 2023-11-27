abstract class Interactable extends GameObject {
  protected boolean hasHoverImage;
  protected PImage gameObjectImageHover;
  protected boolean mouseIsHovering;

  protected Interactable (String identifier, int x, int y, String gameObjectImageFile) {
    super(identifier, x, y, gameObjectImageFile);
    hasHoverImage = false;
    mouseIsHovering = false;
  }

  protected void setHoverImage(String gameObjectImageHoverFile) {
    this.gameObjectImageHover = loadImage(gameObjectImageHoverFile);
    hasHoverImage = true;
  }

  @Override
    protected void draw() {
    imageMode(CENTER);
    if (mouseIsHovering && hasHoverImage) {
      image(gameObjectImageHover, x, y, owidth, oheight);
    } else {
      image(gameObjectImage, x, y, owidth, oheight);
    }
    imageMode(CORNER);
  }

  public void updatePos(int speed) {
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
