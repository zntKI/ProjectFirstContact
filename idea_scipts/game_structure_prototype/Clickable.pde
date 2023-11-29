class Clickable extends Interactable { //<>//
  ArrayList<String> dialogueOptions;
  ArrayList<String> conditions;
  String[] responces;

  ArrayList<DialogueOption> currentDialogueOptionButtons;
  
  ArrayList<Collectable> itemsToDrop;

  //Variables for text
  private int textSize = 20;
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
    dialogueOptionsAreaY = height - dialogueOptionsAreaHeight + 60;


    this.dialogueOptions = new ArrayList<>(dialogueOptionsWithConditions.keySet());
    this.conditions = new ArrayList<>(dialogueOptionsWithConditions.values());

    currentDialogueOptionButtons = new ArrayList<DialogueOption>();
    for (int i = 0; i < dialogueOptionsWithConditions.size(); i++) {
      currentDialogueOptionButtons.add(new DialogueOption(dialogueOptions.get(i), spaceInFrontOfText,
        dialogueOptionsAreaY + spaceBeforeAndAfterText + (i * textSize) + (i * spaceBetweenText), textSize, responces[i]));
    }

    this.responces = responces;

    this.currentDialogueOptionButtons = new ArrayList<DialogueOption>();
  }
  
  public Clickable (String identifier, int x, int y, String gameObjectImageFile, LinkedHashMap<String, String> dialogueOptionsWithConditions, String[] responces,
                    ArrayList<Collectable> itemsToDrop) {
    this(identifier, x, y, gameObjectImageFile, dialogueOptionsWithConditions, responces);
    this.itemsToDrop = itemsToDrop;
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

  public void draw(PImage dialogueImage, PFont textFont) {
    image(dialogueImage, 0, dialogueOptionsAreaY, width, dialogueOptionsAreaHeight);
    fill(255);
    textFont(textFont);
    textSize(textSize);
    textAlign(LEFT, TOP);
    for (int i = 0; i < currentDialogueOptionButtons.size(); i++) {
      currentDialogueOptionButtons.get(i).draw();
    }
  }

  public void updateOptionsPos(String inventoryItemsIdentifiers) {
    currentDialogueOptionButtons = new ArrayList<DialogueOption>();
    int count = 0;
    
    if (inventoryItemsIdentifiers == "") {
      for (int i = 0; i < dialogueOptions.size(); i++) {
        String condition = conditions.get(i);
        if (!condition.contains("Coll")) {
          currentDialogueOptionButtons.add(new DialogueOption(dialogueOptions.get(i), spaceInFrontOfText,
            dialogueOptionsAreaY + spaceBeforeAndAfterText + (count * textSize) + (count * spaceBetweenText), textSize, responces[i]));

          count++;
        }
      }
    } else {
      for (int i = 0; i < dialogueOptions.size(); i++) {
        String condition = conditions.get(i);
        if ((condition.contains("Coll") && inventoryItemsIdentifiers.contains(condition.substring(condition.indexOf(':') + 2))) || condition == "") {
          currentDialogueOptionButtons.add(new DialogueOption(dialogueOptions.get(i), spaceInFrontOfText,
            dialogueOptionsAreaY + spaceBeforeAndAfterText + (count * textSize) + (count * spaceBetweenText), textSize, responces[i]));

          count++;
        }
      }
    }
    
    count = 0;
  }

  public void drawResponce() {
    boolean flag = false;
    for (DialogueOption option : currentDialogueOptionButtons) {
      if (option.getIsInResponce()) {
        option.drawResponce();
        flag = true;
        break;
      } else {
        flag = false;
      }
    }
    
    if (!flag) {
      isInResponce = false;
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
    for (DialogueOption option : currentDialogueOptionButtons) {
      if (option.mouseClicked()) {
        if (option.isGoodbye()) { //<>//
          isInDialogue = false;
          isInResponce = false;
        } else {
          isInResponce = true;
        }
      }
    }
  }
}
