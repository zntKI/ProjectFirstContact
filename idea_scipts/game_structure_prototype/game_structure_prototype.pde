int screenWidth = 1920;
int screenHeight = 1080;

String bgSkyFilePath = "data/sky-bg-long.png";
String bgMountainsFilePath = "data/mountains_bg_long.png";
String tracksFilePath = "data/tracks-bg-long.png";
String train01FilePath = "data/Train-01.png";
NormalBackground bgSky;
NormalBackground bgMountain;
NormalBackground tracksImage;

Player player;
MovementManager movementManager;
SceneManager sceneManager;

Scene currScene;

void settings() {
  size(screenWidth, screenHeight);
}

void setup() {
  bgSky = new NormalBackground(bgSkyFilePath, 3);
  bgMountain = new NormalBackground(bgMountainsFilePath, 10);
  tracksImage = new NormalBackground(tracksFilePath, 20);
  
  player = new Player("Player", screenWidth / 2, screenHeight * 3/4, "data/player_example.png");
  movementManager = new MovementManager(player, screenWidth, bgSky, bgMountain, tracksImage);

  sceneManager = new SceneManager(movementManager);

  GameScene scene01 = new GameScene("GameIntroScreen", bgSky, bgMountain, tracksImage, train01FilePath, player);
  sceneManager.addScene(scene01);
  Clickable bartender = new Clickable("Bartender", screenWidth * 3/4, screenHeight * 3/4, "data/bartender-placeholder.png");
  scene01.addClickable(bartender);
}

void draw() {
  sceneManager.movementManager.updateMovement();

  currScene = sceneManager.getCurrentScene();

  currScene.draw();
  if (currScene instanceof GameScene) {
    ((GameScene)currScene).updateScene();
  }
}

void mouseMoved() {
  currScene = sceneManager.getCurrentScene();
  if (currScene instanceof GameScene) {
    ((GameScene)currScene).mouseMoved();
  }
}

void mouseClicked() {
  currScene = sceneManager.getCurrentScene();
  if (currScene instanceof GameScene) {
    ((GameScene)currScene).mouseClicked();
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT) {
    sceneManager.movementManager.mouseReleased();
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
