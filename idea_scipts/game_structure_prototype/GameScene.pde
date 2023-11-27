class GameScene extends Scene { //<>//
  private NormalBackground bgSky;
  private NormalBackground bgMountain;
  private NormalBackground tracksImage;
  private TrainBackground trainImage;
  private Player player;

  private ArrayList<Clickable> clickables;
  private ArrayList<Collectable> collectables;
  
  //Movement variables
  private int centreCircleRadius = 100;
  private int screenCentrePointLeft, screenCentrePointRight;

  private boolean shouldFinishMovement = false;
  private int pXTemp;
  private int mouseXTemp;
  private int distance;
  private int accBgOffset;

  CursorType cursorType;

  public GameScene (String sceneName, NormalBackground bgSky, NormalBackground bgMountain, NormalBackground tracksImage, String trainImageFile, Player player, CursorType cursorType) {
    super(sceneName);
    this.bgSky = bgSky;
    this.bgMountain = bgMountain;
    this.tracksImage = tracksImage;
    this.trainImage = new TrainBackground(trainImageFile, 4);
    this.player = player;

    clickables = new ArrayList<Clickable>();
    collectables = new ArrayList<Collectable>();

    this.cursorType = cursorType;
    
    screenCentrePointLeft = screenWidth / 2 - centreCircleRadius;
    screenCentrePointRight = screenWidth / 2 + centreCircleRadius;
  }

  public void addClickable(Clickable object) {
    clickables.add(object);
    trainImage.addClickable(object);
  }

  public void removeClickable(Clickable object) {
    clickables.remove(object);
    trainImage.removeClickable(object);
  }

  public void addCollectable(Collectable object) {
    collectables.add(object);
    trainImage.addCollectable(object);
  }

  public void removeCollectable(Collectable object) {
    collectables.remove(object);
    trainImage.removeCollectable(object);
  }

  public void updateScene() {
    updateMovement();
  }

  @Override
    public void draw() {
    background(255);

    bgSky.draw();
    bgMountain.draw();
    tracksImage.draw();
    trainImage.draw();

    for (Clickable object : clickables) {
      object.draw();
    }
    for (Collectable object : collectables) {
      object.draw();
    }

    player.draw();
  }
  
  private void updateMovement() {
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

  public void mouseMoved() {
    int cursorIndex = 0;

    for (Clickable object : clickables) {
      if (object.mouseMoved()) {
        cursorIndex = 2;
        break;
      }
    }
    for (Collectable object : collectables) {
      if (object.mouseMoved()) {
        cursorIndex = 1;
        break;
      }
    }

    cursor(cursorType.getCursorImage(cursorIndex));
  }
  
  public void mousePressed() {
    cursor(cursorType.getCursorImage(0));
  }

  public void mouseClicked() {
    for (Clickable object : clickables) {
      if (object.mouseClicked()) {
        break;
      }
    }
    for (Collectable object : collectables) {
      if (object.mouseClicked()) {
        break;
      }
    }
  }

  public TrainBackground getTrainImage() {
    return trainImage;
  }
}
