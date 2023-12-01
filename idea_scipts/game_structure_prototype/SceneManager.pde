import java.util.Stack;
import java.util.HashMap;

class SceneManager {
  private DoublyLinkedList scenes;
  private Player player;

  int framesRemaining = 100;
  int countEventsDone = 0;
  ArrayList<String> eventsNames = new ArrayList<String>();

  public boolean shouldLoadGameScenes = false;

  public SceneManager(Player player) {
    scenes = new DoublyLinkedList();
    this.player = player;
  }

  public void addScene(Scene scene) {
    scenes.addNode(scene);
  }

  //TODO: Make the player stop at the end and the start of the train OR Make the train loopable(LoopDoublyLinkedList)
  public Scene updateState(Scene currentScene) {
    if (countEventsDone == 3) {
      goToScene("EndMenu");
    }
    if (framesRemaining <= 0) {
      if (currentScene instanceof GameScene || (currentScene instanceof MovieScene && //<>//
      (((MovieScene)currentScene).checkIfEnded() || ((MovieScene)currentScene).checkIfStopped()))) {
        Scene sceneTemp = scenes.findEvent(eventsNames);
        if (sceneTemp.sceneName != "EndMenu") {
          eventsNames.add(sceneTemp.sceneName);
        }
        return sceneTemp;
      }
    }
    if (currentScene instanceof StaticScene) {
      String sceneState = ((StaticScene)currentScene).getState();
      if (sceneState == "Start") {
        if (scenes.goToNext()) {
          return scenes.getCurrentScene();
        }
      } else if (sceneState == "Quit") {
        exit();
        return currentScene;
      }
    } else if (currentScene instanceof MovieScene) {
      if (((MovieScene)currentScene).checkIfEnded() || ((MovieScene)currentScene).checkIfStopped()) {
        if (scenes.goToNext()) {
          return scenes.getCurrentScene();
        } else {
          shouldLoadGameScenes = true;
        }
      }
    } else if (currentScene instanceof GameScene) {
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
    //println("There was an Error in SceneManager.updateState");
    return currentScene;
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
