class NormalBackground extends Background {

  public NormalBackground (String imageFilePath, int moveSpeed) {
    super(imageFilePath, moveSpeed);
  }
  
  public NormalBackground (String imageFilePath, int moveSpeed, int y) {
    super(imageFilePath, moveSpeed);
    this.y -= y;
  }

  @Override
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
}
