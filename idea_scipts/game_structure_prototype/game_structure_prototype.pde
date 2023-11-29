import processing.sound.*;
import java.util.LinkedHashMap;

int screenWidth = 1920;
int screenHeight = 1080;

String bgSkyFilePath = "data/bgs/sky-bg-long.png";
String bgMountainsFilePath = "data/bgs/mountains-bg-long.png";
String tracksFilePath = "data/bgs/tracks-bg-long.png";
String inventoryListFilePath = "data/bgs/inventory_bar.png";
String train01FilePath = "data/bgs/Train-01.png";
String train02FilePath = "data/bgs/Train-02.png";
String train03FilePath = "data/bgs/Train-03.png";
NormalBackground bgSky;
NormalBackground bgMountain;
NormalBackground tracksImage;
NormalBackground inventoryList;

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
  inventoryList = new NormalBackground(inventoryListFilePath, 0);

  player = new Player("Player", screenWidth / 2, screenHeight * 3/4, playerSpritesIdleLeft, playerSpritesIdleRight, playerSpritesWalkLeft, playerSpritesWalkRight);
  inventory = new Inventory();
  soundManager = new SoundManager(this, "data/sound/dreamexpdemo.wav", "data/sound/firstcontacttrain.wav", "data/sound/firstcontactclick.wav");
  cursorType = new CursorType();

  sceneManager = new SceneManager(player);

  GameScene scene01 = new GameScene("Wagon01", bgSky, bgMountain, tracksImage, inventoryList, train02FilePath, player, cursorType, inventory, soundManager);
  LinkedHashMap<String, String> horseguyHash = new LinkedHashMap<String, String>();
  horseguyHash.put("Can you convince the bird that he should not fly against the train?", "Obj: Bird");
  horseguyHash.put("Have you ever thought that you could get killed by a food trolley?", "");
  horseguyHash.put("Why are you boarding a train? You are a horse.", "");
  //horseguyHash.put("Have you seen a kid in this cabin somewhere?", "");
  Clickable horseGuy = new Clickable("HorseGuy", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/horse.png", horseguyHash, new String[]{"What makes you think I can talk to birds. Because I am a horse?? You know that's not how it works right!", "No? Are you okay man?",
  "I need to go somewhere. Just like you?"});
  scene01.addClickable(horseGuy);
  Objective foodTrolley = new Objective("FoodTrolley", screenWidth * 3/4, screenHeight * 3/4, "data/objectives/food-trolley.png", "WoodenPlank", this, "");
  scene01.addObjective(foodTrolley);

  GameScene scene02 = new GameScene("Wagon02", bgSky, bgMountain, tracksImage, inventoryList, train01FilePath, player, cursorType, inventory, soundManager);
  LinkedHashMap<String, String> officerHash = new LinkedHashMap<String, String>();
  officerHash.put("Officer, I need your help with something. I need to shoot down a dangerous bird.", "");
  officerHash.put("How much money do you make?", "");
  officerHash.put("A key has been stolen by a kid have you seen it?", "");
  Clickable officer = new Clickable("Officer", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/officer-l.png", officerHash, new String[]{ "Please stop with this non-sense. I won't borrow you a gun, no matter the reason",
  "Why would that matter to you?!::I bet you would make more money if you actually studied to be a lawyer::Do you want to get shot!?::No::Then leave"});
  scene02.addClickable(officer);
  Collectable gun = new Collectable("Gun", screenWidth * 1/4, screenHeight * 3/4, "data/collectables/gun.png");
  //Collectable keyY = new Collectable("Key", screenWidth * 3/4, screenHeight * 3/4, "data/collectables/key.png");
  scene02.addCollectable(gun);
  //scene02.addCollectable(keyY);
  Objective cop = new Objective("Cop", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/officer-l.png", "Donut", this, "");
  scene02.addObjective(cop);

  GameScene scene03 = new GameScene("Wagon03", bgSky, bgMountain, tracksImage, inventoryList, train02FilePath, player, cursorType, inventory, soundManager);
  Objective bird = new Objective("Bird", screenWidth * 1/2, screenHeight * 1/2, "data/objectives/bird.png", "Gun", this, "data/sound/Pistol_Sound_short.mp3");
  scene03.addObjective(bird);

  GameScene scene04 = new GameScene("Wagon04", bgSky, bgMountain, tracksImage, inventoryList, train01FilePath, player, cursorType, inventory, soundManager);
  LinkedHashMap<String, String> oldLadyHash = new LinkedHashMap<String, String>();
  oldLadyHash.put("Hello miss, I've lost my wallet, could you please help me with 5$? I will return them in the morning.", "");
  oldLadyHash.put("Do you enjoy riding trains?", "");
  Clickable oldLady = new Clickable("OldLady", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/granny-l.png", oldLadyHash, new String[]{ "Of course dear, here you go.",
  "Yes, I am enjoying this train ride just as much as savouring a cup of warm tea on a rainy day. The rhythmic clatter of the wheels and the gentle sway of the carriage create a soothing symphony. It reminds me of a time when life moved a bit slower, much like the landscapes passing by outside the window – a panorama of rolling hills and quaint villages." });
  LinkedHashMap<String, String> lumberjackHash = new LinkedHashMap<String, String>();
  lumberjackHash.put("Do you have a wooden plank?", "");
  lumberjackHash.put("I am willing to trade this sandwich for a wooden plank, how about it?", "Coll: Sandwich");
  lumberjackHash.put("I am willing to trade this donut for a wooden plank", "Coll: Donut");
  lumberjackHash.put("Do you know where I can find something to clean up glass.", "");
  lumberjackHash.put("Why do all lumberjacks wear the same jacket?", "");
  Clickable lumberjack = new Clickable("Lumberjack", screenWidth * 3/4, screenHeight * 3/4, "data/clickables/lumberjack-l.png", lumberjackHash, new String[]{ "I do, but I cannot hand it to you for free. I would want to trade it for some food however.", "That sandwich looks delicious, here you go.",
  "No, I don't like donuts. I like sandwiches the most.", "They probably have something in the cleaning locker near the bar.", "Because they look cool, just like me. I bet you wish you had one."});
  scene04.addClickable(oldLady);
  scene04.addClickable(lumberjack);
  Collectable money = new Collectable("Money", screenWidth * 1/4 + 100, screenHeight * 3/4, "data/collectables/money.png");
  //Collectable woodenPlanks = new Collectable("WoodenPlanks", screenWidth * 3/4 - 200, screenHeight * 3/4, "data/collectables/money.png");
  scene04.addCollectable(money);
  //scene04.addCollectable(woodenPlanks);

  GameScene scene05 = new GameScene("Wagon05", bgSky, bgMountain, tracksImage, inventoryList, train03FilePath, player, cursorType, inventory, soundManager);
  LinkedHashMap<String, String> kid1Hash = new LinkedHashMap<String, String>();
  kid1Hash.put("Hello there, have you seen a set of keys around here?", "");
  kid1Hash.put("Tell me where the key is, otherwise, I will have to shoot you!", "Coll: Gun");
  Clickable kid1 = new Clickable("Kid1", 0 + 100, screenHeight * 3/4, "data/clickables/kid2-r.png", kid1Hash, new String[]{ "Maybe I did, who knows?::If you do not tell me, I will have to send the Boogeyman after you.::Nah, I'd win",
  "Please don't shoot! It's in the fourth cabin beneath the right table" });
  LinkedHashMap<String, String> kid2Hash = new LinkedHashMap<String, String>();
  kid2Hash.put("Hello there, have you seen a set of keys around here?", "");
  kid2Hash.put("Your brother told me you stole the key.", "Obj: Kid3");
  kid2Hash.put("Tell me where the key is, otherwise, I will have to shoot you!", "Coll: Gun");
  Clickable kid2 = new Clickable("Kid2", 0 + 200, screenHeight * 3/4, "data/clickables/kid1-l.png", kid2Hash, new String[]{ "Maybe my brother knows::Which brother?::I don't know, haha!", "AH! that snitch, alright fine you got me it. It's in the fourth cabin beneath the right table.",
  "Please don't shoot! It's in the fourth cabin beneath the right table."});
  LinkedHashMap<String, String> kid3Hash = new LinkedHashMap<String, String>();
  kid3Hash.put("Hello there, have you seen a set of keys around here?", "");
  kid3Hash.put("Tell me where the key is, otherwise, I will have to shoot you!", "Coll: Gun");
  Clickable kid3 = new Clickable("Kid3", 0 + 300, screenHeight * 3/4, "data/clickables/kid3-r.png", kid3Hash, new String[]{ "You look weird, go away::If you do not tell me, I will have to send the Boogeyman after you.::The Boogeyman?::It's a horrible monster that appears at night and will try to hurt you while you sleep::Please don't! Ask my brother with the blue shirt he knows more.",
  "Please don't shoot! It's in the fourth cabin beneath the right table."});
  LinkedHashMap<String, String> bartenderHash = new LinkedHashMap<String, String>();
  bartenderHash.put("I would like to order a donut", "Coll: Money");
  bartenderHash.put("I would like to order a donut", "Obj: Glass");
  bartenderHash.put("You look very handsome", "");
  bartenderHash.put("Can I borrow the key of the cleaning locker?", "");
  bartenderHash.put("Do you not get bored just sitting here?", "");
  Clickable bartender = new Clickable("Bartender", screenWidth - 200, screenHeight * 3/4, "data/clickables/bartender-l.png",
    bartenderHash, new String[]{ "Of course, that will be 4.50$.", "Thank you very much, whenever you need a snack, I can give you one for free.",
    "Well thank you sir!", "I don't think I can help you with that::It's urgent I promise there are glass shards on the floor::Some kid stole it, I believe he had a striped shirt."});
  scene05.addClickable(kid1);
  scene05.addClickable(kid2);
  scene05.addClickable(kid3);
  scene05.addClickable(bartender);
  Collectable broom = new Collectable("Broom", screenWidth * 3/4, screenHeight * 3/4, "data/collectables/broom.png");
  Collectable donut = new Collectable("Broom", screenWidth - 100, screenHeight * 3/4, "data/collectables/donut.png");
  Collectable sandwich = new Collectable("Sandwich", screenWidth - 50, screenHeight * 3/4, "data/collectables/sandwich.png");
  scene05.addCollectable(broom);
  scene05.addCollectable(donut);
  scene05.addCollectable(sandwich);
  Objective locker = new Objective("Locker", screenWidth * 3/4, screenHeight * 3/4, "data/objectives/locker1.png", "Key", this, "");
  //Objective glass = new Objective("Glass", screenWidth * 3/4 + 200, screenHeight * 3/4, "data/objectives/bird.png", "Broom", this, "");
  scene05.addObjective(locker);
  //scene05.addObjective(glass);

  sceneManager.addScene(scene01);
  sceneManager.addScene(scene02);
  sceneManager.addScene(scene03);
  sceneManager.addScene(scene04);
  sceneManager.addScene(scene05);
  currScene = sceneManager.goToScene("Wagon03");
}

void draw() {
  currScene = sceneManager.updateState();

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
  if (currScene instanceof MovieScene) {
    ((MovieScene)currScene).movieEvent(m);
  } else {
    println("Error: trying to play a movie from not a MovieScene");
  }
}
