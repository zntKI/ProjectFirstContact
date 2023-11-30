public class CursorType {
  private String normalFilePath = "data/cursor/cross.png";
  private String handFilePath = "data/cursor/hand.png";
  private String dialogueFilePath = "data/cursor/dialogue.png";
  
  private PImage normalCursorImage;
  private PImage handCursorImage;
  private PImage dialogueCursorImage;
  
  //TODO: Add a point cursor type
  
  public CursorType () {
    normalCursorImage = loadImage(normalFilePath);
    normalCursorImage.resize(32, 0);
    handCursorImage = loadImage(handFilePath);
    handCursorImage.resize(32, 0);
    dialogueCursorImage = loadImage(dialogueFilePath);
    dialogueCursorImage.resize(32, 0);
  }

  public PImage getCursorImage(int index) {
    switch (index) {
    case 0:
      return normalCursorImage;
    case 1:
      return handCursorImage;
    case 2:
      return dialogueCursorImage;
    default:
      println("Error: Smth went wrong while changing CursorType");
      return null;
    }
  }
}
