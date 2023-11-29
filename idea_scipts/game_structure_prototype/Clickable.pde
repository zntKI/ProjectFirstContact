class Clickable extends Interactable { //<>//
  ArrayList<DialogueOption> dialogueOptionButtons;
  String[] responces;

  //Variables for text
  private int textSize = 30;
  private int spaceBeforeAndAfterText = 100;
  private int spaceBetweenText = 15;
  private int spaceInFrontOfText = 150;
  private int dialogueOptionsAreaHeight;
  private int dialogueOptionsAreaY;

  private boolean isInDialogue = false;

  public Clickable (String identifier, int x, int y, String gameObjectImageFile, LinkedHashMap<String, String> dialogueOptionsWithConditions, String[] responces) {
    super(identifier, x, y, gameObjectImageFile);
    this.y -= oheight / 4;

    dialogueOptionsAreaHeight = (dialogueOptionsWithConditions.size() * textSize) + (dialogueOptionsWithConditions.size() - 1) * spaceBetweenText + 2 * spaceBeforeAndAfterText;
    dialogueOptionsAreaY = height - dialogueOptionsAreaHeight;


    ArrayList<String> dialogueOptions = new ArrayList<>(dialogueOptionsWithConditions.keySet());

    dialogueOptionButtons = new ArrayList<DialogueOption>();
    for (int i = 0; i < dialogueOptionsWithConditions.size(); i++) {
      dialogueOptionButtons.add(new DialogueOption(dialogueOptions.get(i), spaceInFrontOfText,
        dialogueOptionsAreaY + spaceBeforeAndAfterText + (i * textSize) + (i * spaceBetweenText), textSize));
    }

    this.responces = responces;
  }

  public boolean getIsInDialogue() {
    return isInDialogue;
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
    for (int i = 0; i < dialogueOptionButtons.size(); i++) {
      dialogueOptionButtons.get(i).draw();
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
}
