class Player extends GameObject {

  public Player (String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
  }

  @Override
    public void draw() {
    image(gameObjectImage, x, y, owidth, oheight);
  }
}
