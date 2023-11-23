abstract class Interactable extends GameObject {
  protected boolean hasHoverImage;
  protected PImage gameObjectImageHover;
  protected boolean mouseIsHovering;

  protected Interactable (String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    hasHoverImage = false;
    mouseIsHovering = false;
  }

  protected void setHoverImage(String gameObjectImageHoverFile) {
    this.gameObjectImageHover = loadImage(gameObjectImageHoverFile);
    hasHoverImage = true;
  }

  @Override
    protected void draw() {
    if (mouseIsHovering && hasHoverImage) {
      image(gameObjectImageHover, x, y, owidth, oheight);
    } else {
      image(gameObjectImage, x, y, owidth, oheight);
    }
  }

  protected void mouseMoved() {
    mouseIsHovering = false;
    if (mouseX >= x && mouseX <= x + owidth &&
      mouseY >= y && mouseY <= y + oheight) {
      mouseIsHovering = true;
    }
  }

  protected abstract void mouseClicked();
}
