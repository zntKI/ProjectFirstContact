class MovementManager { //<>//
  private Player player;
  private NormalBackground bgSky;
  private NormalBackground bgMountain;
  private NormalBackground tracksImage;
  private TrainBackground trainImage;

  private int centreCircleRadius = 300;
  private int screenCentrePointLeft, screenCentrePointRight;

  private boolean shouldFinishMovement = false;
  private int pXTemp;
  private int mouseXTemp;
  private int distance;
  private int accBgOffset;


  public MovementManager (Player player, int screenWidth, NormalBackground bgSky, NormalBackground bgMountain, NormalBackground tracksImage) {
    this.player = player;
    this.bgSky = bgSky;
    this.bgMountain = bgMountain;
    this.tracksImage = tracksImage;

    screenCentrePointLeft = screenWidth / 2 - centreCircleRadius;
    screenCentrePointRight = screenWidth / 2 + centreCircleRadius;
  }

  public void updateMovement() {
    //TODO: make the player turn when changing directions(more art!, also tell the artist to make the backgrounds of width 2 * 1920, not 3 * 1920, and make the images the actual width and height of the subject in them(fix the train))
    //      make the trainBg move until you have reached the end of the scene
    //
    //      make the player be able to move if you only click outside of him?

    bgSky.updatePos(false);
    bgMountain.updatePos(false);
    tracksImage.updatePos(false);

    if (mousePressed && mouseButton == RIGHT) {

      if (!player.shouldMoveWhenMousePressed(screenCentrePointLeft, screenCentrePointRight)) {
        trainImage.updatePos(mouseX < player.getX());
      }
    } else if (shouldFinishMovement) {

      if (mouseXTemp >= screenCentrePointLeft && mouseXTemp <= screenCentrePointRight) {

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

      accBgOffset = 0;
    }
  }

  public void updateTrainImage(TrainBackground trainImage) {
    this.trainImage = trainImage;
  }
}
