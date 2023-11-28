class GameScene extends Scene { //<>//
  private NormalBackground bgSky;
  private NormalBackground bgMountain;
  private NormalBackground tracksImage;
  private TrainBackground trainImage;
  private Player player;

  private ArrayList<Clickable> clickables;
  private ArrayList<Collectable> collectables;
  private ArrayList<Objective> objectives;

  //Movement variables
  private int centreCircleRadius = 100;
  private int screenCentrePointLeft, screenCentrePointRight;

  private boolean shouldFinishMovement = false;
  private boolean shouldFinishMovementEnd = false;
  private int pXTemp;
  private int mouseXTemp;
  private int distance;
  private int accBgOffset;

  private boolean shouldTakeMoveInput = true;

  CursorType cursorType;

  Inventory inventory;
  
  SoundManager soundManager;

  public GameScene (String sceneName, NormalBackground bgSky, NormalBackground bgMountain, NormalBackground tracksImage, String trainImageFile, Player player, CursorType cursorType, Inventory inventory, SoundManager soundManager) {
    super(sceneName);
    this.bgSky = bgSky;
    this.bgMountain = bgMountain;
    this.tracksImage = tracksImage;
    this.trainImage = new TrainBackground(trainImageFile, 4);
    this.player = player;

    clickables = new ArrayList<Clickable>();
    collectables = new ArrayList<Collectable>();
    objectives = new ArrayList<Objective>();

    this.cursorType = cursorType;

    this.inventory = inventory;
    
    this.soundManager = soundManager;

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
  
  public void addObjective(Objective object){
    objectives.add(object);
    trainImage.addObjective(object);
  }
  
  public void removeObjective(Objective object){
    objectives.remove(object);
    trainImage.removeObjective(object);
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

    Collectable collectableGrabbed = inventory.draw();

    Clickable clickableInDialogue = null;
    for (Clickable object : clickables) {
      if (object.getIsInDialogue()) {
        clickableInDialogue = object;
        continue;
      }
      object.draw();
    }
    for (Collectable object : collectables) {
      object.draw();
    }
    
    for(Objective object : objectives){
      object.draw();
    }

    if (clickableInDialogue != null) {
      clickableInDialogue.draw();
    }
    player.draw();
    if (collectableGrabbed != null) {
      collectableGrabbed.draw();
    }
  }


  private void updateMovement() {
    //TODO: make the player turn when changing directions(more art!, also tell the artist to make the backgrounds of width 2 * 1920, not 3 * 1920, and make the images the actual width and height of the subject in them(fix the train))
    //      make the trainBg move until you have reached the end of the scene
    //
    //      make the player be able to move if you only click outside of him?

    bgSky.updatePos(false);
    bgMountain.updatePos(false);
    tracksImage.updatePos(false);

    if (shouldTakeMoveInput) {
      if (trainImage.hasReachedTrainBoundaries()) {
        if (shouldFinishMovement) {
          shouldFinishMovement = mouseXTemp < player.getX() ? player.finishPreviousMovementMouseClicked(mouseXTemp + accBgOffset)
            : player.finishPreviousMovementMouseClicked(mouseXTemp - accBgOffset);
        } else if (mousePressed && mouseButton == RIGHT) {
          player.updateIsMoving(true);

          player.finishPreviousMovementMouseDown();
          if (trainImage.getX() == 0 && mouseX > player.getX() && player.getX() >= screenCentrePointRight) {
            trainImage.updatePos(false);
          } else if (trainImage.getX() == 0 - (trainImage.getWidth() - width) && mouseX < player.getX() && player.getX() <= screenCentrePointLeft) {
            trainImage.updatePos(true);
          }
        } else if (shouldFinishMovementEnd) {
          player.updateIsMoving(true);

          if ((trainImage.getX() == 0 && mouseX < screenCentrePointRight) || (trainImage.getX() == 0 - (trainImage.getWidth() - width) && mouseX > screenCentrePointLeft)) {
            shouldFinishMovementEnd = player.finishPreviousMovementMouseClicked(mouseXTemp);
          } else {
            shouldFinishMovementEnd = trainImage.getX() == 0 && mouseX > screenCentrePointRight ? player.finishPreviousMovementMouseClicked(screenCentrePointRight)
              : player.finishPreviousMovementMouseClicked(screenCentrePointLeft);
            if (!shouldFinishMovementEnd) {
              trainImage.updatePos(trainImage.getX() != 0);
              shouldFinishMovement = true;
            }
          }
        } else {
          player.updateIsMoving(false);
        }
      } else if (mousePressed && mouseButton == RIGHT) {
        player.updateIsMoving(true);

        if (!player.shouldMoveWhenMousePressed(screenCentrePointLeft, screenCentrePointRight)) {

          trainImage.updatePos(mouseX < player.getX());
        }
      } else if (shouldFinishMovement) {
        player.updateIsMoving(true);

        if (mouseXTemp >= screenCentrePointLeft && mouseXTemp <= screenCentrePointRight) {

          shouldFinishMovement = player.shouldFinishMovementWithinCenter(mouseXTemp, pXTemp);
        } else if (!player.shouldFinishMovementOutsideCenter(screenCentrePointLeft, screenCentrePointRight, mouseXTemp, pXTemp)) {
          shouldFinishMovement = trainImage.updatePosClicked(mouseXTemp, pXTemp, distance, accBgOffset);
          accBgOffset = shouldFinishMovement ? accBgOffset + trainImage.getMoveSpeed() : 0;
        }
      } else {
        player.updateIsMoving(false);
      }
    }
  }

  public void mouseReleased() {
    if (trainImage.hasReachedTrainBoundaries()) {
      shouldFinishMovementEnd = true;

      pXTemp = player.getX();
      mouseXTemp = mouseX;
    } else {
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
        shouldTakeMoveInput = false;
        break;
      }
    }
    
    for (int i = 0; i < collectables.size(); i++) {
      Collectable object = collectables.get(i);
      if (object.mouseClicked()) {
        removeCollectable(object);
        object.updatePosInventory(inventory.getXPosForNext(), inventory.getItemsSize());
        inventory.addToInventory(object);
        soundManager.playPickup();
        break;
      }
    }
    
    inventory.mouseClicked();
    
    for (int i = 0; i < objectives.size(); i++){
      Objective object = objectives.get(i);
      if(object.mouseClicked() && inventory.currentItemGrabbed == object.identifierCheck){
        object.playSound();
        removeCollectable(inventory.lastGrabbedItem);
        inventory.removeFromInventory(inventory.lastGrabbedItem);
        removeObjective(object);
      }
    }
  }
}
