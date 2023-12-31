class TrainBackground extends Background {
  private ArrayList<Clickable> clickables;
  private ArrayList<Collectable> collectables;
  private ArrayList<Objective> objectives;
  
  //TODO: make arrows that show that you can switch wagons

  public TrainBackground (String imageFilePath, int moveSpeed) {
    super(imageFilePath, moveSpeed);
    x = x - (imageFile.width - width) / 2;
    y = height - imageFile.height - 50;

    clickables = new ArrayList<Clickable>();
    collectables = new ArrayList<Collectable>();
    objectives = new ArrayList<Objective>();
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
  
  public void addObjective(Objective object){
    objectives.add(object);
  }
  
  public void removeObjective(Objective object){
    objectives.remove(object);
  }

  @Override
    public void updatePos(boolean isPositive) {
    moveOffset = isPositive ? moveSpeed : -moveSpeed;
    x += moveOffset;

    updateObjectsPos(moveOffset);
  }
  
  public void updatePosEndScreen(boolean left) {
    int xTemp = x;
    x = left ? 0 : 0 - (imageFile.width - width);
    updateObjectsPosEndScreen(x - xTemp);
  }
  
  private void updateObjectsPosEndScreen(int offset) {
    for (Clickable clickable : clickables) {
      clickable.updatePos(offset);
    }
    for (Collectable collectable : collectables) {
      collectable.updatePos(offset);
    }
    for (Objective objective : objectives) {
      objective.updatePos(offset);
    }
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
    for (Objective objective : objectives) {
      objective.updatePos(speed);
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
