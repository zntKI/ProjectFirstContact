class Clickable extends Interactable {
  ArrayList<DialogueOption> dialogueOptionButtons;

  //Variables for text
  private int textSize = 40;
  private int spaceBetweenText = 15;
  private int spaceBeforeText = 15;
  private int dialogueOptionsAreaHeight;
  private int dialogueOptionsAreaY;

  private boolean isInDialogue = false;

  public Clickable (String identifier, int x, int y, String gameObjectImageFile, String[] dialogueOptions) {
    super(identifier, x, y, gameObjectImageFile);
    this.y -= oheight / 4;
    
    dialogueOptionsAreaHeight = (dialogueOptions.length * textSize) + ((dialogueOptions.length - 1) + 2) * spaceBetweenText;
    dialogueOptionsAreaY = height - dialogueOptionsAreaHeight;

    dialogueOptionButtons = new ArrayList<DialogueOption>();
    for (int i = 0; i < dialogueOptions.length; i++) {
      dialogueOptionButtons.add(new DialogueOption(dialogueOptions[i], spaceBeforeText,
        dialogueOptionsAreaY + (i + 1) * spaceBetweenText + (i * textSize), textSize));
    }
  }

  public boolean getIsInDialogue() {
    return isInDialogue;
  }

  @Override
    public void draw() {

    if (isInDialogue) {
      fill(0, 128);
      rect(0, 0, width, height);
    }

    imageMode(CENTER);
    image(gameObjectImage, x, y, owidth, oheight);
    imageMode(CORNER);

    if (isInDialogue) {
      fill(255);
      rect(0, dialogueOptionsAreaY, width, dialogueOptionsAreaHeight);
      fill(0);
      textSize(textSize);
      textAlign(LEFT, TOP);
      for (int i = 0; i < dialogueOptionButtons.size(); i++) {
        dialogueOptionButtons.get(i).draw();
      }
    }
  }

  @Override
    public boolean mouseClicked() {
    if (mouseIsHovering) {
      isInDialogue = true;
      return true;
    }
    return false;
  }
}
