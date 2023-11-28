import processing.sound.*;

int screenWidth = 1920;
int screenHeight = 1080;

String bgSkyFilePath = "data/bgs/sky-bg-long.png";
String bgMountainsFilePath = "data/bgs/mountains-bg-long.png";
String tracksFilePath = "data/bgs/tracks-bg-long.png";
String train01FilePath = "data/bgs/Train-01.png";
String train02FilePath = "data/bgs/Train-02.png";
String train03FilePath = "data/bgs/Train-03.png";
NormalBackground bgSky;
NormalBackground bgMountain;
NormalBackground tracksImage;

String[] playerSpritesIdleLeft = new String[] { "data/player/idle-l1.png", "data/player/idle-l2.png", "data/player/idle-l3.png", "data/player/idle-l4.png" };
String[] playerSpritesIdleRight = new String[] { "data/player/idle-r1.png", "data/player/idle-r2.png", "data/player/idle-r3.png", "data/player/idle-r4.png" };
String[] playerSpritesWalkLeft = new String[] { "data/player/walk-l1.png", "data/player/walk-l2.png", "data/player/walk-l3.png", "data/player/walk-l4.png" };
String[] playerSpritesWalkRight = new String[] { "data/player/walk-r1.png", "data/player/walk-r2.png", "data/player/walk-r3.png", "data/player/walk-r4.png" };


Player player;
SceneManager sceneManager;
SoundManager soundManager;

CursorType cursorType;

Inventory inventory;

Scene currScene;

void settings() {
  size(screenWidth, screenHeight);
}

void setup() {
  bgSky = new NormalBackground(bgSkyFilePath, 1);
  bgMountain = new NormalBackground(bgMountainsFilePath, 5, 150);
  tracksImage = new NormalBackground(tracksFilePath, 30);

  player = new Player("Player", screenWidth / 2, screenHeight * 3/4, playerSpritesIdleLeft, playerSpritesIdleRight, playerSpritesWalkLeft, playerSpritesWalkRight);
  inventory = new Inventory();
  soundManager = new SoundManager(this, "data/sound/dreamexpdemo.wav", "data/sound/firstcontacttrain.wav", "data/sound/firstcontactclick.wav");
  cursorType = new CursorType();

  sceneManager = new SceneManager();

  GameScene scene01 = new GameScene("Wagon01", bgSky, bgMountain, tracksImage, train02FilePath, player, cursorType, inventory, soundManager);
  Clickable horseGuy = new Clickable("HorseGuy", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/horse.png", new String[]{});
  scene01.addClickable(horseGuy);
  Objective foodTrolley = new Objective("FoodTrolley", screenWidth * 3/4, screenHeight * 3/4, "data/objectives/food-trolley.png", "WoodenPlank", this, "");
  scene01.addObjective(foodTrolley);

  GameScene scene02 = new GameScene("Wagon02", bgSky, bgMountain, tracksImage, train01FilePath, player, cursorType, inventory, soundManager);
  Clickable officer = new Clickable("Officer", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/officer-l.png", new String[]{});
  scene02.addClickable(officer);
  Collectable gun = new Collectable("Gun", screenWidth * 1/4, screenHeight * 3/4, "data/collectables/gun.png");
  //Collectable keyY = new Collectable("Key", screenWidth * 3/4, screenHeight * 3/4, "data/collectables/key.png");
  scene02.addCollectable(gun);
  //scene02.addCollectable(keyY);
  Objective cop = new Objective("Cop", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/officer-l.png", "Donut", this, "");
  scene02.addObjective(cop);

  GameScene scene03 = new GameScene("Wagon03", bgSky, bgMountain, tracksImage, train02FilePath, player, cursorType, inventory, soundManager);
  Objective bird = new Objective("Bird", screenWidth * 1/2, screenHeight * 1/2, "data/objectives/bird.png", "Gun", this, "data/sound/Pistol_Sound_short.mp3");
  scene03.addObjective(bird);
  
  GameScene scene04 = new GameScene("Wagon04", bgSky, bgMountain, tracksImage, train01FilePath, player, cursorType, inventory, soundManager);
  Clickable oldLady = new Clickable("OldLady", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/granny-l.png", new String[]{});
  Clickable lumberjack = new Clickable("Lumberjack", screenWidth * 3/4, screenHeight * 3/4, "data/clickables/lumberjack-l.png", new String[]{});
  scene04.addClickable(oldLady);
  scene04.addClickable(lumberjack);
  Collectable money = new Collectable("Money", screenWidth * 1/4 + 100, screenHeight * 3/4, "data/collectables/money.png");
  //Collectable woodenPlanks = new Collectable("WoodenPlanks", screenWidth * 3/4 - 200, screenHeight * 3/4, "data/collectables/money.png");
  scene04.addCollectable(money);
  //scene04.addCollectable(woodenPlanks);
  
  GameScene scene05 = new GameScene("Wagon05", bgSky, bgMountain, tracksImage, train03FilePath, player, cursorType, inventory, soundManager);
  Clickable kid1 = new Clickable("Kid1", 0 + 100, screenHeight * 3/4, "data/clickables/kid1-r.png", new String[]{});
  Clickable kid2 = new Clickable("Kid2", 0 + 200, screenHeight * 3/4, "data/clickables/kid2-l.png", new String[]{});
  Clickable kid3 = new Clickable("Kid3", 0 + 300, screenHeight * 3/4, "data/clickables/kid3-r.png", new String[]{});
  Clickable bartender = new Clickable("Bartender", screenWidth - 200, screenHeight * 3/4, "data/clickables/bartender-l.png",
    new String[]{ "I would like to order a donut", "You look pretty", "I'd rather talk to the officer" });
  scene05.addClickable(kid1);
  scene05.addClickable(kid2);
  scene05.addClickable(kid3);
  scene05.addClickable(bartender);
  Collectable broom = new Collectable("Broom", screenWidth * 3/4, screenHeight * 3/4, "data/collectables/broom.png");
  Collectable donut = new Collectable("Broom", screenWidth - 100, screenHeight * 3/4, "data/collectables/donut.png");
  scene05.addCollectable(broom);
  scene05.addCollectable(donut);
  Objective locker = new Objective("Locker", screenWidth * 3/4, screenHeight * 3/4, "data/objectives/locker1.png", "Key", this, "");
  //Objective glass = new Objective("Glass", screenWidth * 3/4 + 200, screenHeight * 3/4, "data/objectives/bird.png", "Broom", this, "");
  scene05.addObjective(locker);
  //scene05.addObjective(glass);
  
  sceneManager.addScene(scene01);
  sceneManager.addScene(scene02);
  sceneManager.addScene(scene03);
  sceneManager.addScene(scene04);
  sceneManager.addScene(scene05);
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
