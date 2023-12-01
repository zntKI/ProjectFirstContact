class MovieScene extends Scene {
  Movie videoToPlay;

  public MovieScene (String sceneName, String videoFile, PApplet parent) {
    super(sceneName);
    this.videoToPlay = new Movie(parent, videoFile);
  }

  @Override
    public void draw() {
    videoToPlay.play();
    image(videoToPlay, 0, 0);
  }
  
  public boolean checkIfEnded() {
    return (int)videoToPlay.time() == (int)videoToPlay.duration();
  }

  public void movieEvent(Movie m) {
    m.read();
  }
}
