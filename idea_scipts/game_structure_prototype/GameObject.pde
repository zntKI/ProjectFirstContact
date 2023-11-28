abstract class GameObject {
  protected int x;
  protected int y;
  protected int owidth;
  protected int oheight;
  protected String identifier;
  protected PImage gameObjectImage;

  protected GameObject(String identifier, int x, int y, String gameObjectImageFile) {
    this.identifier = identifier;
    this.x = x;
    this.y = y;
    this.gameObjectImage = loadImage(gameObjectImageFile);
    this.owidth = this.gameObjectImage.width;
    this.oheight = this.gameObjectImage.height;
  }

  protected abstract void draw();

  protected String getIdentifier() {
    return this.identifier;
  }

  @Override
    public boolean equals(Object obj) {
    if (obj == this) {
      return true;
    }
    if (obj == null || obj.getClass() != this.getClass()) {
      return false;
    }
    GameObject otherGameObject = (GameObject) obj;
    return otherGameObject.getIdentifier().equals(this.identifier);
  }

  @Override
    public int hashCode() {
    final int prime = 11;
    return prime * this.identifier.hashCode();
  }
}
