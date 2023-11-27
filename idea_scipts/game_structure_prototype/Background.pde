abstract class Background {
  protected int x = 0, y = 0;
  protected PImage imageFile;

  protected int moveSpeed;
  protected int moveOffset;

  protected Background (String imageFilePath, int moveSpeed) {
    imageFile = loadImage(imageFilePath);

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
