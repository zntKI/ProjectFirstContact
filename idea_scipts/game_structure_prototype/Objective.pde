class Objective extends Interactable { //<>//
  PImage secondImage;

  String collectableIdentifier;

  SoundFile interactSound = null;

  Collectable itemToDrop = null;

  PImage plankIfTrolley;

  public Objective (String identifier, int x, int y, String gameObjectImageFile, String collectableIdentifier) {
    super(identifier, x, y, gameObjectImageFile);
    this.collectableIdentifier = collectableIdentifier;
  }

  public Objective (String identifier, int x, int y, String gameObjectImageFile, String collectableIdentifier, PApplet parent, String interactSound) {
    super(identifier, x, y, gameObjectImageFile);
    this.collectableIdentifier = collectableIdentifier;
    this.interactSound = new SoundFile(parent, interactSound);
  }

  public Objective (String identifier, int x, int y, String gameObjectImageFile, String collectableIdentifier, PApplet parent, String interactSound
    , Collectable itemToDrop) {
    this(identifier, x, y, gameObjectImageFile, collectableIdentifier, parent, interactSound);
    this.itemToDrop = itemToDrop;
  }

  public Objective (String identifier, int x, int y, String gameObjectImageFile, String collectableIdentifier, PApplet parent, String interactSound
    , Collectable itemToDrop, String gameObjectSecondImageFile) {
    this(identifier, x, y, gameObjectImageFile, collectableIdentifier, parent, interactSound, itemToDrop);
    secondImage = loadImage(gameObjectSecondImageFile);
  }

  public String getCollectableIdentifier() {
    return collectableIdentifier;
  }

  public Collectable getItemToDrop() {
    return itemToDrop;
  }

  public void draw() {
    imageMode(CENTER);
    if (plankIfTrolley != null)
      image(plankIfTrolley, x - gameObjectImage.width / 2, y + gameObjectImage.height / 2, 30, 30);
    image(gameObjectImage, x, y);
    imageMode(CORNER);
  }

  //TODO: Insert the sounds
  public void playSound() {
    if (interactSound != null) {
      interactSound.play();
    }
  }

  @Override
    public boolean mouseClicked(int playerX, int clickRange) {
    if ((mouseX > x - owidth / 2 && mouseX < x + owidth / 2)
      && (mouseY > y - oheight / 2 && mouseY < y + oheight / 2) && isAbleToBeClicked(playerX, clickRange)) {
      if (identifier == "FoodTrolley") {
        plankIfTrolley = loadImage("data/collectables/wonky_plank.png");
      }
      return true;
    } else {
      return false;
    }
  }

  public Collectable makeChangesForLocker() {
    this.gameObjectImage = secondImage;
    itemToDrop.x = this.x + 25;
    return itemToDrop;
  }
}
