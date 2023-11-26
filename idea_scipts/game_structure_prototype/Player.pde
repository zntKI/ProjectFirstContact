class Player extends GameObject {
  private int moveSpeed = 4;
  private int moveOffset = moveSpeed;
  private PImage turnedPlayer;
  private boolean isTurned = false;

  public Player (String identifier, int x, int y, String gameObjectImageFile, String turnedObjectImageFile) {
    super(identifier, x, y, gameObjectImageFile);
    this.turnedPlayer = loadImage(turnedObjectImageFile);

    //TODO: Delete that when art is nicely done
    owidth = owidth / 4;
    oheight = oheight / 4;
    this.y -= oheight / 2;
  }

  public int getX() {
    return x;
  }

  @Override
    public void draw() {
    if(moveOffset < 0){
      isTurned = true;
    }else if(moveOffset > 0){
      isTurned = false;
    }
    
    imageMode(CENTER);
    if(isTurned){
      image(turnedPlayer, x, y, owidth, oheight);
    }else if(!isTurned){
      image(gameObjectImage, x, y, owidth, oheight);
    }
    imageMode(CORNER);
  }

  public boolean shouldMoveWhenMousePressed(int screenCentrePointLeft, int screenCentrePointRight) {
    if (mouseX >= screenCentrePointLeft &&
      mouseX <= screenCentrePointRight) {
      int distance = abs(mouseX - x);

      moveOffset = mouseX < x && x - moveSpeed > x - distance ? -moveSpeed
        : (mouseX > x && x + moveSpeed < x + distance ? moveSpeed : 0);
      x += moveOffset;

      return true;
    } else {
      //Move the player until he reaches the centre's boundrais
      moveOffset = mouseX > x && x < screenCentrePointRight ? moveSpeed
        : (mouseX < x && x > screenCentrePointLeft ? -moveSpeed : 0);

      if (moveOffset == 0) {
        return false;
      }

      x += moveOffset;
      return true;
    }
  }

  public boolean shouldFinishMovementWithinCenter(int mouseXTemp, int pXTemp) {
    int distance = abs(mouseXTemp - pXTemp);

    if (mouseXTemp < x) {
      if (x - moveSpeed >= pXTemp - distance) {
        x -= moveSpeed;
        return true;
      } else {
        x -= x - (pXTemp - distance);
        return false;
      }
    } else if (mouseXTemp > x) {
      if (x + moveSpeed <= pXTemp + distance) {
        x += moveSpeed;
        return true;
      } else {
        x += pXTemp + distance - x;
        return false;
      }
    } else {
      return false;
    }
  }
  
  public boolean shouldFinishMovementOutsideCenter(int screenCentrePointLeft, int screenCentrePointRight, int mouseXTemp, int pXTemp) {
    moveOffset = x > screenCentrePointLeft && x < screenCentrePointRight && mouseXTemp > pXTemp ? moveSpeed
                : (x > screenCentrePointLeft && x < screenCentrePointRight && mouseXTemp < pXTemp ? -moveSpeed : 0);
                
    if (moveOffset == 0) {
      return false;
    }
    
    x += moveOffset;
    return true;
  }
}
