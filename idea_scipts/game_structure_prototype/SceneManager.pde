import java.util.Stack;
import java.util.HashMap;

class SceneManager {
  private DoublyLinkedList scenes;
  private Player player;

  public SceneManager(Player player) {
    scenes = new DoublyLinkedList();
    this.player = player;
  }

  public void addScene(Scene scene) {
    scenes.addNode(scene);
  }

  //TODO: Make the player stop at the end and the start of the train OR Make the train loopable(LoopDoublyLinkedList)
  public Scene updateState() {
    int playerX = player.getX();
    if (playerX <= 100) {
      if (scenes.goToPrevious()) {
        player.updatePosEndOfScreen(false);
      }
    } else if (playerX >= width - 100) {
      if (scenes.goToNext()) {
        player.updatePosEndOfScreen(true);
      }
    }
    return scenes.getCurrentScene();
  }

  public Scene goToScene(String sceneName) {
    Scene sceneToFind = scenes.getScene(sceneName);
    if (sceneToFind != null) {
      return sceneToFind;
    } else {
      println("Scene not found with name: "+ sceneName + "." +
        "Make sure it was added to the sceneManager.");
      return null;
    }
  }
}
