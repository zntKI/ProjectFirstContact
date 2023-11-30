class GameScene extends Scene {
  private NormalBackground bgSky;
  private NormalBackground bgMountain;
  private NormalBackground tracksImage;
  private TrainBackground trainImage;
  private Player player;
  private PImage inventoryList;
  private PImage dialogue;

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

  int startFrames = 0;
  int endFrames = startFrames + 60;
  int countFrames = 0;

  int clickRange = 200;

  CursorType cursorType;

  private int dialogueTextSize = 20;
  private PFont textFont;

  Inventory inventory;

  SoundManager soundManager;
  
  PImage image;
  int imageX, imageY;
  int imageWidth, imageHeight;

  public GameScene (String sceneName, NormalBackground bgSky, NormalBackground bgMountain, NormalBackground tracksImage, String inventoryListFilePath,
    String dialogueFilePath, String trainImageFile, Player player, CursorType cursorType, String textFontFilePath, Inventory inventory, SoundManager soundManager) {
    super(sceneName);
    this.bgSky = bgSky;
    this.bgMountain = bgMountain;
    this.tracksImage = tracksImage;
    this.inventoryList = loadImage(inventoryListFilePath);
    this.dialogue = loadImage(dialogueFilePath);
    this.trainImage = new TrainBackground(trainImageFile, 8);
    this.player = player;

    clickables = new ArrayList<Clickable>();
    collectables = new ArrayList<Collectable>();
    objectives = new ArrayList<Objective>();

    this.cursorType = cursorType;
    this.textFont = createFont(textFontFilePath, dialogueTextSize);

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

  public void addObjective(Objective object) {
    objectives.add(object);
    trainImage.addObjective(object);
  }

  public void removeObjective(Objective object) {
    objectives.remove(object);
    trainImage.removeObjective(object);
  }

  public void updateScene() {
    for (Clickable object : clickables) {
      Collectable droppedItem = object.getDroppedItem();
      if (droppedItem != null) {
        droppedItem.updatePosInventory(inventory.getXPosForNext(), inventory.getItemsY(), inventory.getItemsSize());
        inventory.addToInventory(object.droppedItem);
        object.removeFromItemsToDrop();
      }
      String itemIdToRemoveFromId = object.getItemToDeleteFromInvId();
      if (!itemIdToRemoveFromId.equals("")) {
        inventory.removeFromInventory(itemIdToRemoveFromId);
        object.updateItemToDeleteFromInv();
      }
    }
    updateMovement();
  }

  public void updateTrainCoordinates(boolean left) {
    trainImage.updatePosEndScreen(left);
  }

  @Override
    public void draw() {
    background(255);

    bgSky.draw();
    bgMountain.draw();
    image(inventoryList, 0, 0);
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

    for (Objective object : objectives) {
      object.draw();
    }

    if (clickableInDialogue != null) {
      fill(0, 128);
      rect(0, 0, width, height);
      clickableInDialogue.draw();
    }
    player.draw();
    if (clickableInDialogue != null) {
      clickableInDialogue.draw(dialogue, textFont);
      if (clickableInDialogue.getIsInResponce()) {
        clickableInDialogue.drawResponce();
      }
    }
    if (collectableGrabbed != null) {
      collectableGrabbed.draw();
    }
    if (image != null) {
      imageMode(CENTER);
      image(image, imageX, imageY, imageWidth, imageHeight);
      imageMode(CORNER);
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

    //TODO: Try to fix the movement!!!

    if (shouldTakeMoveInput && !player.shouldDisableMovementWhenChangingScenes) {
      if (trainImage.hasReachedTrainBoundaries()) {
        int playerX = player.getX();
        int trainX = trainImage.getX();
        int trainWidth = trainImage.getWidth();
        if (shouldFinishMovement) {
          shouldFinishMovement = mouseXTemp < playerX ? player.shouldFinishMovementWhenTrainEdge(mouseXTemp + accBgOffset)
            : player.shouldFinishMovementWhenTrainEdge(mouseXTemp - accBgOffset);
        } else if (mousePressed && mouseButton == RIGHT) {
          player.updateIsMoving(true);

          player.moveToMouseWhenTrainEdge();
          if (trainX == 0 && mouseX > playerX && playerX >= screenCentrePointRight) {
            trainImage.updatePos(false);
          } else if (trainX == 0 - (trainWidth - width) && mouseX < playerX && playerX <= screenCentrePointLeft) {
            trainImage.updatePos(true);
          }
        } else if (shouldFinishMovementEnd) {
          player.updateIsMoving(true);

          if ((trainX == 0 && mouseXTemp <= screenCentrePointRight) || (trainX == 0 - (trainWidth - width) && mouseXTemp >= screenCentrePointLeft)) {
            shouldFinishMovementEnd = player.shouldFinishMovementWhenTrainEdge(mouseXTemp);
          } else {
            shouldFinishMovementEnd = trainX == 0 && mouseXTemp > screenCentrePointRight ? player.shouldFinishMovementWhenTrainEdge(screenCentrePointRight)
              : player.shouldFinishMovementWhenTrainEdge(screenCentrePointLeft);
            if (!shouldFinishMovementEnd) {
              trainImage.updatePos(trainX != 0);
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
      int circleSide = mouseXTemp > screenCentrePointRight ? screenCentrePointRight
        : screenCentrePointLeft;
      distance = abs(mouseXTemp - circleSide);

      accBgOffset = 0;
    } else {
      shouldFinishMovement = true;

      if (mouseX >= screenCentrePointLeft &&
        mouseX <= screenCentrePointRight) {
        pXTemp = player.getX();
        mouseXTemp = mouseX;
      } else {
        mouseXTemp = mouseX;
        pXTemp = player.getX();

        int circleSide = mouseXTemp > screenCentrePointRight ? screenCentrePointRight
          : screenCentrePointLeft;
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
    if (inventory.mouseMoved()) {
      cursorIndex = 1;
    }

    cursor(cursorType.getCursorImage(cursorIndex));
  }

  public void mousePressed() {
    if (player.shouldDisableMovementWhenChangingScenes) {
      player.shouldDisableMovementWhenChangingScenes = false;
      player.updateIsMoving(true);
    }

    cursor(cursorType.getCursorImage(0));
  }

  public void mouseClicked() {
    //TODO: make it impossible for the player to "interact" with more than one Interactable at a time

    int playerX = player.getX();
    for (Clickable object : clickables) {
      if (object.mouseClicked(playerX, clickRange)) {
        shouldTakeMoveInput = false;
        player.updateIsMoving(false);
        object.updateOptionsPos(inventory.getItemsIdentifiers());
        break;
      } else if (object.getIsInDialogue()) {
        object.mouseClickedOptions();
      }
      if (object.firstTimeNotInResponce) {
        shouldTakeMoveInput = true;
        object.firstTimeNotInResponce = false;
      }
    }

    for (int i = 0; i < collectables.size(); i++) {
      Collectable object = collectables.get(i);
      if (object.getIdentifier() == "Plank") {
        continue;
      }
      if (object.mouseClicked(playerX, clickRange) && inventory.canPickUpItem()) {
        removeCollectable(object);
        object.updatePosInventory(inventory.getXPosForNext(), inventory.getItemsY(), inventory.getItemsSize());
        inventory.addToInventory(object);
        soundManager.playPickup();
        break;
      }
    }

    inventory.mouseClicked();

    for (int i = 0; i < objectives.size(); i++) {
      Objective object = objectives.get(i);
      Collectable itemToCheck = inventory.getCurrentItemGrabbed();
      if (itemToCheck == null)
        break;
      if (object.mouseClicked(playerX, clickRange) && itemToCheck.getIdentifier() == object.getCollectableIdentifier()) {
        object.playSound(); //<>//
        //removeCollectable(itemToCheck);
        if (!itemToCheck.getIdentifier().equals("Key") && !itemToCheck.getIdentifier().equals("Gun")) {
          inventory.removeFromInventory(itemToCheck);
          removeObjective(object);
        } else if (itemToCheck.getIdentifier().equals("Key")) {
          //Change sprite

          //Show broom
          addCollectable(object.getItemToDrop());
        } else if (itemToCheck.getIdentifier().equals("Gun")) {
          removeObjective(object);
        }
      }
    }
  }
}
