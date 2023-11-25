class MovementManager {
  private Player player;
  private Background bg;
  private Background trainImage;

  private int centreCircleRadius = 300;
  private int screenCentrePointLeft, screenCentrePointRight;

  private boolean shouldFinishMovement = false;
  private int pXTemp;
  private int mouseXTemp;
  private int distance;
  private int accBgOffset;


  public MovementManager (Player player, int screenWidth) {
    this.player = player;

    screenCentrePointLeft = screenWidth / 2 - centreCircleRadius;
    screenCentrePointRight = screenWidth / 2 + centreCircleRadius;
  }

  public void updateMovement() {
    if (mousePressed && mouseButton == RIGHT) {

      if (!player.shouldMoveWhenMousePressed(screenCentrePointLeft, screenCentrePointRight)) {
        trainImage.updatePos(mouseX < player.getX());
      }
    } else if (shouldFinishMovement) {

      if (mouseXTemp >= screenCentrePointLeft &&
        mouseXTemp <= screenCentrePointRight) {
        shouldFinishMovement = player.shouldFinishMovementWithinCenter(mouseXTemp, pXTemp);
      } else if (!player.shouldFinishMovementOutsideCenter(screenCentrePointLeft, screenCentrePointRight, mouseXTemp, pXTemp)) {
        shouldFinishMovement = trainImage.updatePosClicked(mouseXTemp, pXTemp, distance, accBgOffset);
        accBgOffset = shouldFinishMovement ? accBgOffset + trainImage.getMoveSpeed() : 0;
      }
    }
  }

  public void mouseReleased() {
    shouldFinishMovement = true;

    if (mouseX >= screenCentrePointLeft &&
      mouseX <= screenCentrePointRight) {
      //Player should move towards that point
      pXTemp = player.getX();
      mouseXTemp = mouseX;
    } else {
      mouseXTemp = mouseX;
      pXTemp = player.getX();

      int circleSide = mouseXTemp > screenCentrePointRight ? screenCentrePointRight
        : screenCentrePointLeft;
      //distance to move the bg
      distance = abs(mouseXTemp - circleSide);
    }
  }

  public void updateBg(Background bg) {
    this.bg = bg;
  }

  public void updateTrainImage(Background trainImage) {
    this.trainImage = trainImage;
  }
}
