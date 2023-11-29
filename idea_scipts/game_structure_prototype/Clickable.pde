class Clickable extends Interactable { //<>//
  ArrayList<DialogueOption> dialogueOptionButtons;
  ArrayList<String> conditions;
  String[] responces;

  //Variables for text
  private int textSize = 30;
  private int spaceBeforeAndAfterText = 100;
  private int spaceBetweenText = 15;
  private int spaceInFrontOfText = 150;
  private int dialogueOptionsAreaHeight;
  private int dialogueOptionsAreaY;

  private boolean isInDialogue = false;
  private boolean isInResponce = false;

  public Clickable (String identifier, int x, int y, String gameObjectImageFile, LinkedHashMap<String, String> dialogueOptionsWithConditions, String[] responces) {
    super(identifier, x, y, gameObjectImageFile);
    this.y -= oheight / 4;

    dialogueOptionsAreaHeight = (dialogueOptionsWithConditions.size() * textSize) + (dialogueOptionsWithConditions.size() - 1) * spaceBetweenText + 2 * spaceBeforeAndAfterText;
    dialogueOptionsAreaY = height - dialogueOptionsAreaHeight;


    ArrayList<String> dialogueOptions = new ArrayList<>(dialogueOptionsWithConditions.keySet());
    ArrayList<String> dialogueOptionsConditions = new ArrayList<>(dialogueOptionsWithConditions.values());

    dialogueOptionButtons = new ArrayList<DialogueOption>();
    conditions = new ArrayList<String>();
    for (int i = 0; i < dialogueOptionsWithConditions.size(); i++) {
      dialogueOptionButtons.add(new DialogueOption(dialogueOptions.get(i), spaceInFrontOfText,
        dialogueOptionsAreaY + spaceBeforeAndAfterText + (i * textSize) + (i * spaceBetweenText), textSize, responces[i]));
      conditions.add(dialogueOptionsConditions.get(i));
    }

    this.responces = responces;
  }

  public boolean getIsInDialogue() {
    return isInDialogue;
  }

  public boolean getIsInResponce() {
    return isInResponce;
  }

  @Override
    public void draw() {

    imageMode(CENTER);
    image(gameObjectImage, x, y, owidth, oheight);
    imageMode(CORNER);
  }

  public void draw(PImage dialogueImage, PFont textFont, ArrayList<Collectable> inventoryItems) {
    image(dialogueImage, 0, dialogueOptionsAreaY, width, dialogueOptionsAreaHeight);
    fill(255);
    textFont(textFont);
    textSize(textSize);
    textAlign(LEFT, TOP);
    for (int i = 0; i < dialogueOptionButtons.size(); i++) {
      if (conditions.get(i) != "") {
        for (int j = 0; j < inventoryItems.size(); j++) {
          if (conditions.get(i).contains(inventoryItems.get(j).getIdentifier())) {
            dialogueOptionButtons.get(i).draw();
            break;
          }
        }
      } else {
        dialogueOptionButtons.get(i).draw();
      }
    }
  }

  public void drawResponce() {
    for (DialogueOption option : dialogueOptionButtons) {
      if (option.getIsInResponce()) {
        option.drawResponce();
      }
    }
  }

  @Override
    public boolean mouseClicked(int playerX, int clickRange) {
    if (mouseIsHovering && isAbleToBeClicked(playerX, clickRange)) {
      isInDialogue = true;
      return true;
    }
    return false;
  }

  public void mouseClickedOptions() {
    for (DialogueOption option : dialogueOptionButtons) {
      if (option.mouseClicked()) {
        if (option.isGoodbye()) {
          isInDialogue = false;
        }
        isInResponce = true;
      }
    }
  }
}
