int screenWidth = 1920;
int screenHeight = 1080;

String bgSkyFilePath = "data/bgs/sky-bg-long.png";
String bgMountainsFilePath = "data/bgs/mountains_bg_long.png";
String tracksFilePath = "data/bgs/tracks-bg-long.png";
String train01FilePath = "data/bgs/Train-01.png";
NormalBackground bgSky;
NormalBackground bgMountain;
NormalBackground tracksImage;

String[] playerSpritesIdleLeft = new String[] { "data/player/idle-l1.png", "data/player/idle-l2.png", "data/player/idle-l3.png", "data/player/idle-l4.png" };
String[] playerSpritesIdleRight = new String[] { "data/player/idle-r1.png", "data/player/idle-r2.png", "data/player/idle-r3.png", "data/player/idle-r4.png" };
String[] playerSpritesWalkLeft = new String[] { "data/player/walk-l1.png", "data/player/walk-l2.png", "data/player/walk-l3.png", "data/player/walk-l4.png" };
String[] playerSpritesWalkRight = new String[] { "data/player/walk-r1.png", "data/player/walk-r2.png", "data/player/walk-r3.png", "data/player/walk-r4.png" };


Player player;
SceneManager sceneManager;

CursorType cursorType;

Inventory inventory;

Scene currScene;

void settings() {
  size(screenWidth, screenHeight);
}

void setup() {
  bgSky = new NormalBackground(bgSkyFilePath, 3);
  bgMountain = new NormalBackground(bgMountainsFilePath, 10);
  tracksImage = new NormalBackground(tracksFilePath, 20);

  player = new Player("Player", screenWidth / 2, screenHeight * 3/4, playerSpritesIdleLeft, playerSpritesIdleRight, playerSpritesWalkLeft, playerSpritesWalkRight); //<>//

  sceneManager = new SceneManager();

  cursorType = new CursorType();
  
  inventory = new Inventory();

  GameScene scene01 = new GameScene("GameIntroScreen", bgSky, bgMountain, tracksImage, train01FilePath, player, cursorType, inventory);
  sceneManager.addScene(scene01);
  Clickable bartender = new Clickable("Bartender", screenWidth * 3/4, screenHeight * 3/4, "data/clickables/bartender-placeholder.png",
                                      new String[]{ "I would like to order a donut", "You look pretty", "I'd rather talk to the officer" });
  scene01.addClickable(bartender);
  Collectable donut = new Collectable("Donut", width/4, height/2, "data/collectables/donut.png");
  Collectable gun = new Collectable("Gun", width/2, height/2, "data/collectables/gun.png");
  Collectable broom = new Collectable("Broom", width/4 * 3, height/2, "data/collectables/broom.png");
  scene01.addCollectable(donut);
  scene01.addCollectable(gun);
  scene01.addCollectable(broom);
}

void draw() {
  currScene = sceneManager.getCurrentScene();

  currScene.draw();
  if (currScene instanceof GameScene) {
    ((GameScene)currScene).updateScene();
  }
}

void mouseMoved() {
  if (currScene instanceof GameScene) {
    ((GameScene)currScene).mouseMoved();
  }
}

void mousePressed() {
  if (currScene instanceof GameScene) {
    ((GameScene)currScene).mousePressed();
  }
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    if (currScene instanceof GameScene) {
      ((GameScene)currScene).mouseClicked();
    }
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT && currScene instanceof GameScene) {
    ((GameScene)currScene).mouseReleased();
  }
}

void movieEvent(Movie m) {
  currScene = sceneManager.getCurrentScene();
  if (currScene instanceof MovieScene) {
    ((MovieScene)currScene).movieEvent(m);
  } else {
    println("Error: trying to play a movie from not a MovieScene");
  }
}
