class TrainBackground extends Background {
  private ArrayList<Clickable> clickables;
  private ArrayList<Collectable> collectables;

  public TrainBackground (String imageFilePath, int moveSpeed) {
    super(imageFilePath, moveSpeed);
    x = x - (imageFile.width - width) / 2;
    y = height - imageFile.height - 50;

    clickables = new ArrayList<Clickable>();
    collectables = new ArrayList<Collectable>();
  }
  
  public int getX() {
    return x;
  }
  
  public int getWidth() {
    return imageFile.width;
  }

  public void addClickable(Clickable object) {
    clickables.add(object);
  }

  public void removeClickable(Clickable object) {
    clickables.remove(object);
  }

  public void addCollectable(Collectable object) {
    collectables.add(object);
  }

  public void removeCollectable(Collectable object) {
    collectables.remove(object);
  }

  @Override
    public void updatePos(boolean isPositive) {
    moveOffset = isPositive ? moveSpeed : -moveSpeed;
    x += moveOffset;

    updateObjectsPos(moveOffset);
  }

  public boolean updatePosClicked(int mouseXTemp, int pXTemp, int distance, int accBgOffset) {
    if (mouseXTemp > pXTemp) {
      if (accBgOffset + moveSpeed < distance) {
        x -= moveSpeed;
        updateObjectsPos(-moveSpeed);
        
        accBgOffset += moveSpeed;
        return true;
      } else {
        x -= (accBgOffset + moveSpeed) - distance;
        updateObjectsPos(-((accBgOffset + moveSpeed) - distance));
        
        return false;
      }
    } else {
      if (accBgOffset + moveSpeed < distance) {
        x += moveSpeed;
        updateObjectsPos(moveSpeed);
        
        accBgOffset += moveSpeed;
        return true;
      } else {
        x += (accBgOffset + moveSpeed) - distance;
        updateObjectsPos((accBgOffset + moveSpeed) - distance);
        
        return false;
      }
    }
  }

  private void updateObjectsPos(int speed) {
    for (Clickable clickable : clickables) {
      clickable.updatePos(speed);
    }
    for (Collectable collectable : collectables) {
      collectable.updatePos(speed);
    }
  }
  
  public boolean hasReachedTrainBoundaries() {
    if (x >= 0) {
      x = 0;
      return true;
    } else if (x <= 0 - (imageFile.width - width)) {
      x = 0 - (imageFile.width - width);
      return true;
    }
    return false;
  }
}
