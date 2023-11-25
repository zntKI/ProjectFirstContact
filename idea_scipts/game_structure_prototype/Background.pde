class Background {
  private int x, y;
  private PImage imageFile;

  private int moveSpeed;
  private int moveOffset;

  public Background (String imageFilePath, int moveSpeed) {
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

  public void updatePos(boolean isPositive) {
    moveOffset = isPositive ? moveSpeed : -moveSpeed;
    
    if (x != 0 && x % width == 0) {
      x = 0;
    }
    
    if (x + moveOffset < -width) {
      x += -(width + x);
    } else {
      x += moveOffset;
    }
  }

  public boolean updatePosClicked(int mouseXTemp, int pXTemp, int distance, int accBgOffset) {
    if (mouseXTemp > pXTemp) {
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
