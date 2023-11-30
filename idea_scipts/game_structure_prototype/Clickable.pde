class Clickable extends Interactable { //<>// //<>// //<>// //<>//
  ArrayList<String> dialogueOptions;
  ArrayList<String> conditions;
  ArrayList<String> responces;

  ArrayList<DialogueOption> currentDialogueOptionButtons;

  ArrayList<Collectable> itemsToDrop;
  Collectable droppedItem = null;

  String itemToDeleteFromInventoryId = "";

  //Variables for text
  private int textSize = 20;
  private int spaceBeforeAndAfterText = 100;
  private int spaceBetweenText = 15;
  private int spaceInFrontOfText = 150;
  private int dialogueOptionsAreaHeight;
  private int dialogueOptionsAreaY;

  private boolean isInDialogue = false;
  private boolean firstTimeNotInResponce = false;
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
      String option = dialogueOptions.get(i);
      if (option.contains("_")) {
        currentDialogueOptionButtons.add(new DialogueOption(option.substring(0, option.indexOf("_")), spaceInFrontOfText,
          dialogueOptionsAreaY + spaceBeforeAndAfterText + (i * textSize) + (i * spaceBetweenText), textSize, responces[i]));
      } else {
        currentDialogueOptionButtons.add(new DialogueOption(option, spaceInFrontOfText,
          dialogueOptionsAreaY + spaceBeforeAndAfterText + (i * textSize) + (i * spaceBetweenText), textSize, responces[i]));
      }
    }

    this.responces = new ArrayList<String>();
    for (int i = 0; i < responces.length; i++) {
      this.responces.add(responces[i]);
    }

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

  public Collectable getDroppedItem() {
    return droppedItem;
  }

  public String getItemToDeleteFromInvId() {
    return itemToDeleteFromInventoryId;
  }
  
  public void updateItemToDeleteFromInv() {
    itemToDeleteFromInventoryId = "";
  }

  public void removeFromItemsToDrop() {
    itemsToDrop.remove(droppedItem);
    droppedItem = null;
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
          String option = dialogueOptions.get(i);
          if (option.contains("_")) {
            currentDialogueOptionButtons.add(new DialogueOption(option.substring(0, option.indexOf("_")), spaceInFrontOfText,
              dialogueOptionsAreaY + spaceBeforeAndAfterText + (count * textSize) + (count * spaceBetweenText), textSize, responces.get(i)));
          } else {
            currentDialogueOptionButtons.add(new DialogueOption(option, spaceInFrontOfText,
              dialogueOptionsAreaY + spaceBeforeAndAfterText + (count * textSize) + (count * spaceBetweenText), textSize, responces.get(i)));
          }

          count++;
        }
      }
    } else {
      for (int i = 0; i < dialogueOptions.size(); i++) {
        String condition = conditions.get(i);
        if ((condition.contains("Coll") && inventoryItemsIdentifiers.contains(condition.substring(condition.indexOf(':') + 2))) || condition == "") {
          String option = dialogueOptions.get(i);
          if (option.contains("_")) {
            currentDialogueOptionButtons.add(new DialogueOption(option.substring(0, option.indexOf("_")), spaceInFrontOfText,
              dialogueOptionsAreaY + spaceBeforeAndAfterText + (count * textSize) + (count * spaceBetweenText), textSize, responces.get(i)));
          } else {
            currentDialogueOptionButtons.add(new DialogueOption(option, spaceInFrontOfText,
              dialogueOptionsAreaY + spaceBeforeAndAfterText + (count * textSize) + (count * spaceBetweenText), textSize, responces.get(i)));
          }

          count++;
        }
      }
    }

    count = 0;
  }

  public void drawResponce() {
    String optionTextToRemove = "";
    for (int i = 0; i < currentDialogueOptionButtons.size(); i++) {
      DialogueOption option = currentDialogueOptionButtons.get(i);
      if (option.getIsInResponce()) {
        option.drawResponce();
        break;
      } else {
        if (option.firstTimeNotInResponce) {
          isInResponce = false;
          String optionTextStart = option.getText().substring(0, 5);
          String optionText = "";
          for (int j = 0; j < dialogueOptions.size(); j++) {
            if (dialogueOptions.get(i).contains(optionTextStart)) {
              optionText = dialogueOptions.get(i);
            }
          }
          if (this.identifier.equals("Officer") && optionText.contains("_Gun")) {
            for (int j = 0; j < dialogueOptions.size(); j++) {
              if (dialogueOptions.get(j).equals(optionText)) {
                for (Collectable collectable : itemsToDrop) {
                  if (collectable.getIdentifier().equals("Gun")) {
                    droppedItem = collectable;
                    break;
                  }
                }
                currentDialogueOptionButtons.remove(j);
                dialogueOptions.remove(j);
                conditions.remove(j);
                responces.remove(j);

                itemToDeleteFromInventoryId = "Donut";
              }
            }
          } else if (this.identifier.equals("Bartender") && optionText.contains("_Donut")) {
            for (int j = 0; j < dialogueOptions.size(); j++) {
              if (dialogueOptions.get(j).equals(optionText)) {
                for (Collectable collectable : itemsToDrop) {
                  if (collectable.getIdentifier().equals("Donut")) {
                    droppedItem = collectable;
                    break;
                  }
                }
                currentDialogueOptionButtons.remove(j);
                dialogueOptions.remove(j);
                conditions.remove(j);
                responces.remove(j);

                itemToDeleteFromInventoryId = "Money";
              }
            }
          } else if (this.identifier.equals("Bartender") && optionText.contains("_Sandwich")) {
            for (int j = 0; j < dialogueOptions.size(); j++) {
              if (dialogueOptions.get(j).equals(optionText)) {
                for (Collectable collectable : itemsToDrop) {
                  if (collectable.getIdentifier().equals("Sandwich")) {
                    droppedItem = collectable;
                    break;
                  }
                }
                currentDialogueOptionButtons.remove(j);
                dialogueOptions.remove(j);
                conditions.remove(j);
                responces.remove(j);

                itemToDeleteFromInventoryId = "Key";
              }
            }
          } else if (optionText.contains("_")) {
            String identifier = optionText.substring(optionText.indexOf('_') + 1);
            for (Collectable collectable : itemsToDrop) {
              String originalId = collectable.getIdentifier();
              if (identifier.equals(originalId)) {
                droppedItem = collectable;
                optionTextToRemove = optionText;
                break;
              }
            }
            break;
          }
          option.firstTimeNotInResponce = false;
        }
      }
    }

    if (!optionTextToRemove.equals("")) {
      for (int i = 0; i < dialogueOptions.size(); i++) {
        if (dialogueOptions.get(i).equals(optionTextToRemove)) {
          currentDialogueOptionButtons.remove(i);
          dialogueOptions.remove(i);
          conditions.remove(i);
          responces.remove(i);
        }
      }
    }
  }

  @Override
    public boolean mouseClicked(int playerX, int clickRange) {
    if ((mouseX > x - owidth / 2 && mouseX < x + owidth / 2) //<>//
      && (mouseY > y - oheight / 2 && mouseY < y + oheight / 2) && isAbleToBeClicked(playerX, clickRange)) {
      isInDialogue = true;
      return true;
    }
    return false;
  }

  public void mouseClickedOptions() {
    for (int i = 0; i < currentDialogueOptionButtons.size(); i++) {
      DialogueOption option = currentDialogueOptionButtons.get(i);
      if (option.mouseClicked()) {
        if (option.isGoodbye()) { //<>//
          isInDialogue = false;
          firstTimeNotInResponce = true;
          isInResponce = false;
        } else {
          isInResponce = true;
        }
      }
    }
  }
}
