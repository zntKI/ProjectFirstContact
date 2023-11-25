class GameScene extends Scene {
  private Background bgSky;
  private Background bgMountain;
  private Background tracksImage;
  private Background trainImage;
  private Player player;
  
  private ArrayList<Clickable> clickables;
  private ArrayList<Collectable> collectables;

  private ArrayList<Clickable> recentlyAddedClickables;
  private ArrayList<Clickable> markedForDeathClickables;
  private ArrayList<Collectable> recentlyAddedCollectables;
  private ArrayList<Collectable> markedForDeathCollectables;

  public GameScene (String sceneName, Background bgSky, Background bgMountain, Background tracksImage, String trainImageFile, Player player) {
    super(sceneName);
    this.bgSky = bgSky;
    this.bgMountain = bgMountain;
    this.tracksImage = tracksImage;
    this.trainImage = new Background(trainImageFile, 4);
    this.player = player;
    
    clickables = new ArrayList<Clickable>();
    collectables = new ArrayList<Collectable>();
    
    markedForDeathClickables = new ArrayList<Clickable>();
    recentlyAddedClickables = new ArrayList<Clickable>();
    markedForDeathCollectables = new ArrayList<Collectable>();
    recentlyAddedCollectables = new ArrayList<Collectable>();
  }

  public void addClickable(Clickable object) {
    recentlyAddedClickables.add(object);
  }
  
  public void removeClickable(Clickable object) {
    markedForDeathClickables.add(object);
  }
  
  public void addCollectable(Collectable object) {
    recentlyAddedCollectables.add(object);
  }
  
  public void removeCollectable(Collectable object) {
    markedForDeathCollectables.add(object);
  }

  public void updateScene() {
    if (markedForDeathClickables.size() > 0) {
      for (Clickable object : markedForDeathClickables) {
        clickables.remove(object);
      }
      markedForDeathClickables  = new ArrayList<Clickable>();
    }
    if (recentlyAddedClickables.size() > 0) {
      for (Clickable object : recentlyAddedClickables) {
        clickables.add(object);
      }
      recentlyAddedClickables  = new ArrayList<Clickable>();
    }
    
    if (markedForDeathCollectables.size() > 0) {
      for (Collectable object : markedForDeathCollectables) {
        collectables.remove(object);
      }
      markedForDeathCollectables  = new ArrayList<Collectable>();
    }
    if (recentlyAddedCollectables.size() > 0) {
      for (Collectable object : recentlyAddedCollectables) {
        collectables.add(object);
      }
      recentlyAddedCollectables  = new ArrayList<Collectable>();
    }
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
  
  public Background getTrainImage() {
    return trainImage;
  }
}
