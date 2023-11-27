class Collectable extends Interactable {
  boolean isGrabbed = false;

  public Collectable (String identifier, int x, int y, String gameObjectImageFile) {
    super(identifier, x, y, gameObjectImageFile);
  }

  @Override
    public void draw() {
    imageMode(CENTER);
    //delete this later
    if (mouseIsHovering && hasHoverImage) {
      image(gameObjectImageHover, x, y, owidth, oheight);
    } else {
      image(gameObjectImage, x, y, owidth, oheight);
    }
    imageMode(CORNER);
    
    
  }

  @Override
  public boolean mouseClicked() {
    if(mouseIsHovering){ //<>// //<>//
      return true;
    }else{
      return false;
    }
  }
  
  //void updatePos() {
  //  x = 50;
  //  y = 50;
  //}
  
}
