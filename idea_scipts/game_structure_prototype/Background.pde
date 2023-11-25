class Background {
  private int x, y;
  private PImage imageFile;

  private int moveSpeed = 4;
  private int moveOffset = moveSpeed;

  public Background (String imageFilePath) {
    imageFile = loadImage(imageFilePath);
    x = 0;
    y = 0;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public PImage getImage() {
    return imageFile;
  }
  
  public int getMoveSpeed() {
    return moveSpeed;
  }

  public void updatePos(boolean isPositive) {
    moveOffset = isPositive ? moveSpeed : -moveSpeed;
    x += moveOffset;
  }

  public boolean updatePosClicked(int mouseXTemp, int pXTemp, int distance, int accBgOffset) {
    if (mouseXTemp > pXTemp) { //<>//
      if (accBgOffset + moveSpeed < distance) {
        x -= moveSpeed;
        accBgOffset += moveSpeed;
        return true;
      } else {
        x -= (accBgOffset + moveSpeed) - distance;
        return false;
      }
    } else {
      if (accBgOffset + moveSpeed < distance) {
        x += moveSpeed;
        accBgOffset += moveSpeed;
        return true;
      } else {
        x += (accBgOffset + moveSpeed) - distance;
        return false;
      }
    }
  }
}
