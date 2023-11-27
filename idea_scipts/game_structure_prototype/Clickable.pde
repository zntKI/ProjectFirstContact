class Clickable extends Interactable {
  private int textSize = 40;
  private int spaceBetweenText = 15;
  private int spaceBeforeText = 15;
  private int dialogueOptionsAreaHeight;
  private int dialogueOptionsAreaY;

  private boolean isInDialogue = false;

  ArrayList<DialogueOption> dialogueOptionButtons;

  public Clickable (String identifier, int x, int y, String gameObjectImageFile, String[] dialogueOptions) {
    super(identifier, x, y, gameObjectImageFile);
    dialogueOptionsAreaHeight = (dialogueOptions.length * textSize) + ((dialogueOptions.length - 1) + 2) * spaceBetweenText;
    dialogueOptionsAreaY = height - dialogueOptionsAreaHeight;

    dialogueOptionButtons = new ArrayList<DialogueOption>();
    for (int i = 0; i < dialogueOptions.length; i++) {
      dialogueOptionButtons.add(new DialogueOption(dialogueOptions[i], spaceBeforeText,
                                dialogueOptionsAreaY + (i + 1) * spaceBetweenText + (i * textSize), textSize));
    }

    //TODO: Delete that when art is nicely done
    owidth = owidth / 4;
    oheight = oheight / 4;
    this.y -= oheight / 2;
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
    if (mouseIsHovering && hasHoverImage) {
      image(gameObjectImageHover, x, y, owidth, oheight);
    } else {
      image(gameObjectImage, x, y, owidth, oheight);
    }
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
    if ((mouseX > x - owidth / 2 && mouseX < x + owidth / 2)
      && (mouseY > y - oheight / 2 && mouseY < y + oheight / 2)) {
      isInDialogue = true;
      return true;
    }
    return false;
  }
}
