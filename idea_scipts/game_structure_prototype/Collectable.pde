class Collectable extends Interactable {

  public Collectable (String identifier, int x, int y, String gameObjectImageFile) {
    super(identifier, x, y, gameObjectImageFile);
  }

  @Override
    public void draw() {
    imageMode(CENTER);
    if (mouseIsHovering && hasHoverImage) {
      image(gameObjectImageHover, x, y, owidth, oheight);
    } else {
      image(gameObjectImage, x, y, owidth, oheight);
    }
    imageMode(CORNER);
  }

  @Override
  public boolean mouseClicked() {
    return false;
  }
}
