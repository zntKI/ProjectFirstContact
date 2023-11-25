int screenWidth = 1920;
int screenHeight = 1080;

Player player;
MovementManager movementManager;
SceneManager sceneManager;

Scene currScene;

void settings() {
  size(screenWidth, screenHeight);
}

void setup() {
  player = new Player("Player", screenWidth / 2, screenHeight * 3/4, "data/player_example.png");
  movementManager = new MovementManager(player, screenWidth);

  sceneManager = new SceneManager(movementManager);

  Scene scene01 = new GameScene("GameIntroScreen", "data/sky-bg-long.png", "data/mountains_bg_long.png", "data/Train-01.png", player);
  sceneManager.addScene(scene01);
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
