abstract class Background {
  protected int x, y;
  protected PImage imageFile;

  protected int moveSpeed;
  protected int moveOffset;

  protected Background (String imageFilePath, int moveSpeed) {
    imageFile = loadImage(imageFilePath);
    x = 0;
    y = 0;

    this.moveSpeed = moveSpeed;
    this.moveOffset = this.moveSpeed;
  }

  public void draw() {
    image(imageFile, x, y);
  }

  public int getMoveSpeed() {
    return moveSpeed;
  }

  public abstract void updatePos(boolean isPositive);
}
