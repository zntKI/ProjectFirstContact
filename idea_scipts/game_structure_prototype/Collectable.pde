class Collectable extends Interactable {
  private boolean isGrabbed = false;

  public Collectable (String identifier, int x, int y, String gameObjectImageFile) {
    super(identifier, x, y, gameObjectImageFile);
  }
  
  public boolean getIsGrabbed() {
    return isGrabbed;
  }
  
  public String getIdentifier() {
    return identifier;
  }
  
  public int getX() {
    return x;
  }

  @Override
    public void draw() {
    imageMode(CENTER);
    if (isGrabbed) {
      image(gameObjectImage, x, y, owidth * 1.2, oheight * 1.2);
      image(gameObjectImage, mouseX, mouseY, owidth, oheight);
    } else {
      image(gameObjectImage, x, y, owidth, oheight);
    }
    imageMode(CORNER);
  }

  @Override
    public boolean mouseClicked(int playerX, int clickRange) {
    if ((mouseX > x - owidth / 2 && mouseX < x + owidth / 2)
      && (mouseY > y - oheight / 2 && mouseY < y + oheight / 2) && isAbleToBeClicked(playerX, clickRange)) {
      return true;
    }
    return false;
  }
  
  public boolean mouseClickedInventory() {
    if ((mouseX > x - owidth / 2 && mouseX < x + owidth / 2)
      && (mouseY > y - oheight / 2 && mouseY < y + oheight / 2)) {
      return true;
    }
    return false;
  }

  public void updatePosInventory(int x, int size) {
    this.x = x;
    this.y = size / 2;
    this.owidth = size;
    this.oheight = owidth;
  }

  public void updateIsGrabbed(boolean flag) {
    isGrabbed = flag;
  }
}
