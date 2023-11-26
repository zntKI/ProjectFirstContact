class Clickable extends Interactable {

  public Clickable (String identifier, int x, int y, String gameObjectImageFile) {
    super(identifier, x, y, gameObjectImageFile);

    //TODO: Delete that when art is nicely done
    owidth = owidth / 4;
    oheight = oheight / 4;
    this.y -= oheight / 2;
  }

  public void mouseClicked() {
    if ((mouseX > x - owidth / 2 && mouseX < x + owidth / 2)
      && (mouseY > y - oheight / 2 && mouseY < y + oheight / 2)) {
      println("Clicked!");
    }
  }
}
