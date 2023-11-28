class Objective extends Interactable {
  String identifierCheck;
  
  SoundFile interactSound;
  
  public Objective (PApplet parent, String identifier, int x, int y, String gameObjectImageFile, String identifierCheck, String interactSound) {
    super(identifier, x, y, gameObjectImageFile);
    this.identifierCheck = identifierCheck;
    this.interactSound = new SoundFile(parent, interactSound);
  }
  
  public void draw() {
    imageMode(CENTER);
    image(gameObjectImage, x, y);
    imageMode(CORNER);
  }
  
  public void playSound(){
    interactSound.play();
  }
  
  public boolean mouseClicked() {
    if((mouseX > x - owidth / 2 && mouseX < x + owidth / 2)
      && (mouseY > y - oheight / 2 && mouseY < y + oheight / 2)){
      return true;
    } else{
      return false;
    }
  }
}
