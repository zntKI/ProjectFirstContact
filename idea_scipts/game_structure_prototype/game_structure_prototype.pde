int screenWidth = 1920;
int screenHeight = 1080;

SceneManager sceneManager = new SceneManager();

Scene currScene;

void settings() {
  size(screenWidth, screenHeight);
}

void setup() {
  Scene scene01 = new GameScene("GameIntroScreen", "data/train_example.png");
  sceneManager.addScene(scene01);
}

void draw() {
  currScene = sceneManager.getCurrentScene();
  
  currScene.draw(screenWidth, screenHeight);
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

void movieEvent(Movie m) {
  currScene = sceneManager.getCurrentScene();
  if (currScene instanceof MovieScene) {
    ((MovieScene)currScene).movieEvent(m);
  } else {
    println("Error: trying to play a movie from not a MovieScene");
  }
}
