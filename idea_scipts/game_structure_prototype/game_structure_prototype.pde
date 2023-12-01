import processing.sound.*; //<>//
import processing.video.*;
import java.util.LinkedHashMap;
//https://forum.processing.org/two/discussion/20474/could-not-run-the-sketch-target-vm-failed-to-initialize-empty-sketch#latest
int screenWidth = 1920;
int screenHeight = 1080;

String bgSkyFilePath = "data/bgs/sky-bg-long.png";
String bgMountainsFilePath = "data/bgs/mountains-bg-long.png";
String tracksFilePath = "data/bgs/tracks-bg-long.png";
String inventoryListFilePath = "data/bgs/inventory_bar.png";
String dialogueFilePath = "data/bgs/dialogue_box.png";
String train01FilePath = "data/bgs/Train-01.png";
String train02FilePath = "data/bgs/Train-02.png";
String train03FilePath = "data/bgs/Train-03.png";
NormalBackground bgSky;
NormalBackground bgMountain;
NormalBackground tracksImage;

String textFontFilePath = "data/fonts/pixelmix.ttf";
String titleFontFilePath = "data/fonts/Fipps-Regular.otf";

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
  ArrayList<Button> buttonsStartMenu = new ArrayList<Button>();
  Button buttonStart = new Button("Start", 1180, 1775, 480, 595);
  Button buttonQuit = new Button("Quit", 1180, 1775, 705, 820);
  buttonsStartMenu.add(buttonStart);
  buttonsStartMenu.add(buttonQuit);
  StaticScene startMenuScene = new StaticScene("StartMenu", "data/bgs/start_screen.png", buttonsStartMenu);

  MovieScene movieStartScene = new MovieScene("Movie01", "start_cutscene.mp4", this);

  player = new Player("Player", screenWidth / 2, screenHeight * 3/4, playerSpritesIdleLeft, playerSpritesIdleRight, playerSpritesWalkLeft, playerSpritesWalkRight);
  sceneManager = new SceneManager(player);

  sceneManager.addScene(startMenuScene);
  sceneManager.addScene(movieStartScene);
  currScene = sceneManager.goToScene("StartMenu");
}

void loadGameScenes() {
  bgSky = new NormalBackground(bgSkyFilePath, 1);
  bgMountain = new NormalBackground(bgMountainsFilePath, 5, 150);
  tracksImage = new NormalBackground(tracksFilePath, 30);

  inventory = new Inventory();
  soundManager = new SoundManager(this, "data/sound/dreamexpdemo.wav", "data/sound/firstcontacttrain.wav", "data/sound/firstcontactclick.wav");
  cursorType = new CursorType();


  GameScene scene01 = new GameScene("Wagon02", bgSky, bgMountain, tracksImage, inventoryListFilePath, dialogueFilePath, train01FilePath, player, cursorType, textFontFilePath, titleFontFilePath, inventory, soundManager);
  Objective bird = new Objective("Bird", screenWidth * 1/2 + 950, screenHeight * 1/2 + 100, "data/objectives/bird.png", "Gun", this, "data/sound/Pistol_Sound_short.mp3");
  scene01.addObjective(bird);

  GameScene scene02 = new GameScene("Wagon02", bgSky, bgMountain, tracksImage, inventoryListFilePath, dialogueFilePath, train02FilePath, player, cursorType, textFontFilePath, titleFontFilePath, inventory, soundManager);
  LinkedHashMap<String, String> horseguyHash = new LinkedHashMap<String, String>();
  horseguyHash.put("-> Have you ever thought that you could get killed by a food trolley?", "");
  horseguyHash.put("-> Why are you boarding a train? You are a horse.", "");
  horseguyHash.put("-> Hey, can I borrow some money?", "");
  horseguyHash.put("-> How would you stop a food trolley from rolling on its own?", "");
  horseguyHash.put("-> Goodbye", "");
  Clickable horseGuy = new Clickable("HorseGuy", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/horse.png", horseguyHash, new String[]{"No?\nAre you okay man?",
    "I need to go somewhere.\nJust like you?", "No, not from me.\nYou could try asking the old lady?", "Probably by placing a wooden plank infront of it.", "LEAVE"});
  scene02.addClickable(horseGuy);
  Objective foodTrolley = new Objective("FoodTrolley", screenWidth * 3/4 - 300, screenHeight * 3/4, "data/objectives/food-trolley.png", "Plank");
  LinkedHashMap<String, String> officerHash = new LinkedHashMap<String, String>();
  officerHash.put("-> Officer, I need your help with something. I need to shoot down a dangerous bird.", "");
  officerHash.put("-> How much money do you make?", "");
  officerHash.put("-> Do you know where I can find something to clean up the glass?", "");
  officerHash.put("-> Is there a chance you would want a donut?_Gun", "Coll: Donut");
  officerHash.put("-> How is it going?", "Coll: Gun");
  officerHash.put("-> Goodbye", "");
  ArrayList<Collectable> officerItemsToDrop = new ArrayList<Collectable>();
  officerItemsToDrop.add(new Collectable("Gun", screenWidth * 1/4, screenHeight * 3/4, "data/collectables/gun.png"));
  Clickable officer = new Clickable("Officer", screenWidth * 3/4, screenHeight * 3/4, "data/clickables/officer-l.png", officerHash, new String[]{ "Please stop with this non-sense.\nI won't borrow you a gun,\nno matter the reason",
    "Enough to buy food.\nYou know I could really eat a donut right now.", "Yea, they have a broom in the cleaning locker.", "Yes!\nGimme, gimme\n*Turns around, eating the donut\nand you steal his gun*",
    "I've lost my gun,\ndo you perhaps know where it is?::No, sorry", "LEAVE"}, officerItemsToDrop);
  scene02.addClickable(officer);
  scene02.addObjective(foodTrolley);


  GameScene scene03 = new GameScene("Wagon03", bgSky, bgMountain, tracksImage, inventoryListFilePath, dialogueFilePath, train01FilePath, player, cursorType, textFontFilePath, titleFontFilePath, inventory, soundManager);
  LinkedHashMap<String, String> oldLadyHash = new LinkedHashMap<String, String>();
  oldLadyHash.put("-> Hello miss, I've lost my wallet, could you please help me with 5$? I will return them in the morning._Money", "");
  oldLadyHash.put("-> Do you enjoy riding trains?", "");
  oldLadyHash.put("-> Have you seen a food trolley around?", "");
  oldLadyHash.put("-> Can you give me more money?", "Coll: Money");
  oldLadyHash.put("-> Goodbye", "");
  ArrayList<Collectable> oldladyItemsToDrop = new ArrayList<Collectable>();
  oldladyItemsToDrop.add(new Collectable("Money", screenWidth * 1/4 + 100, screenHeight * 3/4, "data/collectables/money.png"));
  Clickable oldLady = new Clickable("OldLady", screenWidth * 1/4, screenHeight * 3/4, "data/clickables/granny-l.png", oldLadyHash, new String[]{ "Of course dear, here you go.",
    "Yes, I am enjoying this train ride\njust as much as savouring a cup of warm tea on a rainy day.\nThe rhythmic clatter of the wheels and\nthe gentle sway of the carriage create a soothing symphony.\nIt reminds me of a time when life moved a bit slower,\nmuch like the landscapes passing by outside the\nwindow – a panorama of rolling hills and quaint villages.",
    "Yes, it was quite dangerous.::-What do you mean?::It had no brakes.\nMaybe you can ask the lumberjack for some wood to place in front of it?", "No dear, I can't give it all away", "LEAVE"},
    oldladyItemsToDrop);
  LinkedHashMap<String, String> lumberjackHash = new LinkedHashMap<String, String>();
  lumberjackHash.put("-> Can I have a wooden plank?", "");
  lumberjackHash.put("-> I am willing to trade this sandwich for a wooden plank, how about it?_Plank", "Coll: Sandwich");
  lumberjackHash.put("-> I can trade this donut for a wooden plank", "Coll: Donut");
  lumberjackHash.put("-> Do you know where I can find something to clean up glass.", "");
  lumberjackHash.put("-> Why do all lumberjacks wear the same jacket?", "");
  lumberjackHash.put("-> Goodbye", "");
  ArrayList<Collectable> lumbItemsToDrop = new ArrayList<Collectable>();
  lumbItemsToDrop.add(new Collectable("Plank", 0, 0, "data/collectables/wonky_plank.png"));
  Clickable lumberjack = new Clickable("Lumberjack", screenWidth * 3/4, screenHeight * 3/4, "data/clickables/lumberjack-l.png", lumberjackHash, new String[]{ "I do have one, but I cannot hand it to you for free.\nI would want to trade it for some food however.", "That sandwich looks delicious,\nhere you go.",
    "No, I don't like donuts.\nI like sandwiches the most.", "They probably have something in the cleaning locker near the bar.", "Because they look cool, just like me.\nI bet you wish you had one.", "LEAVE"}, lumbItemsToDrop);
  scene03.addClickable(oldLady);
  scene03.addClickable(lumberjack);

  GameScene scene04 = new GameScene("Wagon04", bgSky, bgMountain, tracksImage, inventoryListFilePath, dialogueFilePath, train03FilePath, player, cursorType, textFontFilePath, titleFontFilePath, inventory, soundManager);
  LinkedHashMap<String, String> kid1Hash = new LinkedHashMap<String, String>();
  kid1Hash.put("-> Hello there, have you seen a set of keys around here?", "");
  kid1Hash.put("-> Tell me where the key is, otherwise, I will have to shoot you!", "Coll: Gun");
  kid1Hash.put("-> Goodbye", "");
  Clickable kid1 = new Clickable("Kid1", 0 + 100, screenHeight * 3/4, "data/clickables/kid2-r.png", kid1Hash, new String[]{ "Maybe I did, who knows?::If you do not tell me,\nI will have to send the Boogeyman after you.::Okay, okay,\nmy brother stole them.",
    "Please don't shoot!\nMy brother with the blue shirt stole it", "LEAVE" });
  LinkedHashMap<String, String> kid2Hash = new LinkedHashMap<String, String>();
  kid2Hash.put("-> Hello, can you give me the keys.", "");
  kid2Hash.put("-> Tell me where the key is, otherwise, I will have to shoot you!_Key_N", "Coll: Gun");
  kid2Hash.put("-> Goodbye", "");
  ArrayList<Collectable> kid2ItemsToDrop = new ArrayList<Collectable>();
  kid2ItemsToDrop.add(new Collectable("Key", screenWidth - 100, screenHeight * 3/4, "data/collectables/key.png"));
  Clickable kid2 = new Clickable("Kid2", 0 + 200, screenHeight * 3/4, "data/clickables/kid1-l.png", kid2Hash, new String[]{ "No!\nWhy would I give them to someone like you.\nYour not scary at all.",
    "Please don't shoot!\nHere you go:", "LEAVE"}, kid2ItemsToDrop);
  LinkedHashMap<String, String> kid3Hash = new LinkedHashMap<String, String>();
  kid3Hash.put("-> Hello there, can you give me the keys?", "");
  kid3Hash.put("-> Where are your parents?", "");
  kid3Hash.put("-> Tell me where the key is, otherwise, I will have to shoot you!", "Coll: Gun");
  kid3Hash.put("-> Goodbye", "");
  Clickable kid3 = new Clickable("Kid3", 0 + 300, screenHeight * 3/4, "data/clickables/kid3-r.png", kid3Hash, new String[]{ "I don't have them and you are weird,\ngo away!",
    "Who cares!\nWe can do what we want!", "Please don't shoot!\nMy brother with the blue shirt stole it.", "LEAVE"});
  LinkedHashMap<String, String> bartenderHash = new LinkedHashMap<String, String>();
  bartenderHash.put("-> I would like to order a donut_Donut", "Coll: Money");
  bartenderHash.put("-> I came to return the keys._Sandwich", "Coll: Key");
  bartenderHash.put("-> You look very handsome", "");
  bartenderHash.put("-> Can I borrow the key of the cleaning locker?", "");
  bartenderHash.put("-> Do you not get bored just sitting here?", "");
  bartenderHash.put("-> Goodbye", "");
  ArrayList<Collectable> bartenderItemsToDrop = new ArrayList<Collectable>();
  bartenderItemsToDrop.add(new Collectable("Donut", screenWidth - 100, screenHeight * 3/4, "data/collectables/donut.png"));
  bartenderItemsToDrop.add(new Collectable("Sandwich", screenWidth - 50, screenHeight * 3/4, "data/collectables/sandwich.png"));
  Clickable bartender = new Clickable("Bartender", screenWidth - 200, screenHeight * 3/4, "data/clickables/bartender-l.png",
    bartenderHash, new String[]{ "Of course, that will be 4.50$.", "Thank you very much,\nwhenever you need a snack, I can give you one for free.",
    "Well thank you sir!", "I don't think I can help you with that::It's urgent I promise\nthere are glass shards on the floor::Some kid stole it.\nIf bring it back, I will give you a sandwich as a thanks.",
    "I am doing my job\nand I am actually being paid good money for it.::I wish I could get payed for doing nothing most of the time::Excuse me?::Nothing", "LEAVE"}, bartenderItemsToDrop);
  scene04.addClickable(kid1);
  scene04.addClickable(kid2);
  scene04.addClickable(kid3);
  scene04.addClickable(bartender);
  Objective locker = new Objective("Locker", screenWidth * 3/4 - 250, screenHeight * 3/4 - 70, "data/objectives/locker1.png", "Key", this, "data/sound/Opening_locker.wav", new Collectable("Broom", screenWidth * 3/4 - 250 + 20, screenHeight * 3/4 - 70, "data/collectables/broom.png"), "data/objectives/locker2.png");
  Objective glass = new Objective("Glass", screenWidth * 3/4 + 100, screenHeight * 3/4 + 30, "data/objectives/glass.png", "Broom", this, "data/sound/glass_sound.mp3");
  scene04.addObjective(locker);
  scene04.addObjective(glass);


  sceneManager.addScene(scene01);
  sceneManager.addScene(scene02);
  sceneManager.addScene(scene03);
  sceneManager.addScene(scene04);


  MovieScene movieEndTrolleyScene = new MovieScene("FoodTrolley", "trolley.mp4", this);
  MovieScene movieEndGlassScene = new MovieScene("Glass", "glass.mp4", this);
  MovieScene movieEndBirdScene = new MovieScene("Bird", "bird.mp4", this);

  ArrayList<Button> buttonsStartMenu = new ArrayList<Button>();
  Button buttonQuit = new Button("Quit", 1180, 1775, 705, 820);
  buttonsStartMenu.add(buttonQuit);
  StaticScene endMenuScene = new StaticScene("EndMenu", "data/bgs/end_screen.png", buttonsStartMenu);

  sceneManager.addScene(movieEndTrolleyScene);
  sceneManager.addScene(movieEndGlassScene);
  sceneManager.addScene(movieEndBirdScene);
  sceneManager.addScene(endMenuScene);
}


void draw() {
  currScene = sceneManager.updateState(currScene);
  if (sceneManager.shouldLoadGameScenes) {
    loadGameScenes();
    sceneManager.shouldLoadGameScenes = false;
  }

  if (sceneManager.framesRemaining <= 0)
    soundManager.backgroundMusic.stop();

  currScene.draw();
  if (currScene.sceneName == "EndMenu") {
    //textAlign(LEFT, TOP);
    textSize(100);
    //textFont(titleFont);
    fill(#ffaa5e);
    text("Score: " + (sceneManager.countEventsDone * 100 + 240 - (sceneManager.framesRemaining / 60)), 1180, 1775);
  }
  if (currScene instanceof GameScene) {
    String name = ((GameScene)currScene).updateScene(sceneManager.countEventsDone);
    if (name != "") {
      sceneManager.countEventsDone++;
      sceneManager.eventsNames.add(name);
    }
    if (sceneManager.framesRemaining > 0) {
      sceneManager.framesRemaining--;
    }
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
    } else if (currScene instanceof StaticScene) {
      ((StaticScene)currScene).mouseClicked();
    }
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT && currScene instanceof GameScene) {
    ((GameScene)currScene).mouseReleased();
  }
}

void keyPressed() {
  if (key == ' ') {
    if (currScene instanceof MovieScene) {
      ((MovieScene)currScene).keyPressed();
    }
  }
}

void movieEvent(Movie m) {
  if (currScene instanceof MovieScene) {
    ((MovieScene)currScene).movieEvent(m);
  } /*else {
   println("Error: trying to play a movie from not a MovieScene");
   }*/
}
