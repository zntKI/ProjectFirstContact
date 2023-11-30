class Objective extends Interactable {
  String collectableIdentifier;
  
  SoundFile interactSound;
  
  Collectable itemToDrop = null;
  
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
  
  public String getCollectableIdentifier() {
    return collectableIdentifier;
  }
  
  public Collectable getItemToDrop() {
    return itemToDrop;
  }
  
  public void draw() {
    imageMode(CENTER);
    image(gameObjectImage, x, y);
    imageMode(CORNER);
  }
  
  //TODO: Insert the sounds
  public void playSound() {
    //interactSound.play();
  }
  
  @Override
  public boolean mouseClicked(int playerX, int clickRange) {
    if((mouseX > x - owidth / 2 && mouseX < x + owidth / 2)
      && (mouseY > y - oheight / 2 && mouseY < y + oheight / 2) && isAbleToBeClicked(playerX, clickRange)) {
      return true;
    } else {
      return false;
    }
  }
}
