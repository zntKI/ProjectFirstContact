import java.util.Stack;
import java.util.HashMap;

class SceneManager {
  private HashMap<String, Scene> scenes;
  private Stack<Scene> scenesStack;

  private MovementManager movementManager;

  public SceneManager(MovementManager movementManager) {
    scenes = new HashMap<String, Scene>();
    scenesStack = new Stack<Scene>();

    this.movementManager = movementManager;
  }

  public void addScene(Scene scene) {
    scenes.put(scene.getSceneName(), scene);
    if (scenesStack.size() == 0)
    {
      scenesStack.push(scene);
      updateMovementManager(scene);
    }
  }

  public void goToScene(String sceneName) throws Exception {
    if (scenes.containsKey(sceneName)) {
      Scene scene = scenes.get(sceneName);
      scenesStack.push(scene);
      updateMovementManager(scene);
    } else {
      throw new Exception("Scene not found with name: "+ sceneName + "." +
        "Make sure it was added to the sceneManager.");
    }
  }

  public void goToPreviousScene() {
    scenesStack.pop();
  }

  public Scene getCurrentScene() {
    return scenesStack.peek();
  }

  private void updateMovementManager(Scene scene) {
    if (scene instanceof GameScene) {
      GameScene gameScene = ((GameScene)scene);
      movementManager.updateImages(gameScene.getBgSky(), gameScene.getBgMountain(), gameScene.getTrainImage());
    }
  }
}
