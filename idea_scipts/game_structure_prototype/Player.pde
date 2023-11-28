class Player extends GameObject { //<>//

  private int moveSpeed = 4;
  private int moveOffset = moveSpeed;
  private int tempMoveOffsetIfZero = moveOffset;

  private boolean isMoving = false;

  private boolean isLookingLeft = false;

  int spriteArraysLength = 4;
  PImage[] playerIdleLeftSprites = new PImage[spriteArraysLength];
  PImage[] playerIdleRightSprites = new PImage[spriteArraysLength];
  PImage[] playerWalkLeftSprites = new PImage[spriteArraysLength];
  PImage[] playerWalkRightSprites = new PImage[spriteArraysLength];
  int countFrame = 0;

  public Player (String identifier, int x, int y, String[] playerIdleLeftSprites, String[] playerIdleRightSprites, String[] playerWalkLeftSprites,
    String[] playerWalkRightSprites) {
    super(identifier, x, y, playerIdleRightSprites[0]);
    this.y -= oheight / 4;

    for (int i = 0; i < playerIdleLeftSprites.length; i++) {
      this.playerIdleLeftSprites[i] = loadImage(playerIdleLeftSprites[i]);
      this.playerIdleRightSprites[i] = loadImage(playerIdleRightSprites[i]);
      this.playerWalkLeftSprites[i] = loadImage(playerWalkLeftSprites[i]);
      this.playerWalkRightSprites[i] = loadImage(playerWalkRightSprites[i]);
    }
  }

  public int getX() {
    return x;
  }

  @Override
    public void draw() {
    imageMode(CENTER);
    if (isMoving) {
      isLookingLeft = moveOffset < 0 ? true : false;

      if (isLookingLeft) {
        image(playerWalkLeftSprites[countFrame], x, y, owidth, oheight);
      } else {
        image(playerWalkRightSprites[countFrame], x, y, owidth, oheight);
      }
    } else {
      if (isLookingLeft) {
        image(playerIdleLeftSprites[countFrame], x, y, owidth, oheight);
      } else {
        image(playerIdleRightSprites[countFrame], x, y, owidth, oheight);
      }
    }
    imageMode(CORNER);

    if (frameCount % 15 == 0) {
      countFrame = countFrame + 1 > spriteArraysLength - 1 ? 0 : countFrame + 1;
    }
  }
  
  public void updatePosEndOfScreen(boolean left) {
    x = left ? 0 + 200 : width - 200;
  }

  //Movement code down:
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
      tempMoveOffsetIfZero = moveOffset;
      moveOffset = mouseX > x && x < screenCentrePointRight ? moveSpeed
        : (mouseX < x && x > screenCentrePointLeft ? -moveSpeed : 0);

      if (moveOffset == 0) {
        moveOffset = tempMoveOffsetIfZero;
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
    tempMoveOffsetIfZero = moveOffset;
    moveOffset = x > screenCentrePointLeft && x < screenCentrePointRight && mouseXTemp > pXTemp ? moveSpeed
      : (x > screenCentrePointLeft && x < screenCentrePointRight && mouseXTemp < pXTemp ? -moveSpeed : 0);

    if (moveOffset == 0) {
      moveOffset = tempMoveOffsetIfZero;
      return false;
    }

    x += moveOffset;
    return true;
  }

  public boolean shouldFinishMovementWhenTrainEdge(int mouseXTemp) {
    boolean flag;
    if (mouseXTemp < x) {
      if (x - moveSpeed >= mouseXTemp) {
        x -= moveSpeed;
        flag = true;
      } else {
        x = mouseXTemp;
        flag = false;
      }
      moveOffset = -moveSpeed;
      return flag;
    } else if (mouseXTemp > x) {
      if (x + moveSpeed <= mouseXTemp) {
        x += moveSpeed;
        moveOffset = moveSpeed;
        flag = true;
      } else {
        x = mouseXTemp;
        moveOffset = moveSpeed;
        flag = false;
      }
      moveOffset = moveSpeed;
      return flag;
    } else {
      return false;
    }
  }

  public void moveToMouseWhenTrainEdge() {
    moveOffset = mouseX < x ? -moveSpeed : moveSpeed;
    x += moveOffset;
  }

  public void updateIsMoving(boolean flag) {
    if (isMoving != flag) {
      countFrame = 0;
    }
    isMoving = flag;
  }
}
