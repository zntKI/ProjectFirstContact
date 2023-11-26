class GameScene extends Scene {
  private NormalBackground bgSky;
  private NormalBackground bgMountain;
  private NormalBackground tracksImage;
  private TrainBackground trainImage;
  private Player player;
  
  private ArrayList<Clickable> clickables;
  private ArrayList<Collectable> collectables;

  public GameScene (String sceneName, NormalBackground bgSky, NormalBackground bgMountain, NormalBackground tracksImage, String trainImageFile, Player player) {
    super(sceneName);
    this.bgSky = bgSky;
    this.bgMountain = bgMountain;
    this.tracksImage = tracksImage;
    this.trainImage = new TrainBackground(trainImageFile, 4);
    this.player = player;
    
    clickables = new ArrayList<Clickable>();
    collectables = new ArrayList<Collectable>();
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
  }
  
  @Override
  public void draw() {
    background(255);
    
    bgSky.draw();
    bgMountain.draw();
    tracksImage.draw();
    trainImage.draw();
    
    for(Clickable object : clickables) {
      object.draw();
    }
    for(Collectable object : collectables) {
      object.draw();
    }
    
    player.draw();
  }
  
  public void mouseMoved() {
    for(Clickable object : clickables) {
      object.mouseMoved();
    }
    for(Collectable object : collectables) {
      object.mouseMoved();
    }
  }
  
  public void mouseClicked() {
    for(Clickable object : clickables) {
      object.mouseClicked();
    }
    for(Collectable object : collectables) {
      object.mouseClicked();
    }
  }
  
  public TrainBackground getTrainImage() {
    return trainImage;
  }
}
