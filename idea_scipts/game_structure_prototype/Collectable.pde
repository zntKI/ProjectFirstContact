class Collectable extends Interactable {

  public Collectable (String identifier, int x, int y, String gameObjectImageFile) {
    super(identifier, x, y, gameObjectImageFile);
  }

  @Override
  public boolean mouseClicked() {
    return false;
  }
}
