abstract class Scene {
  protected String sceneName;
  
  protected Scene(String sceneName) {
    this.sceneName = sceneName;
  }
  
  protected abstract void draw();
  
  protected String getSceneName() {
    return this.sceneName;
  }
}
