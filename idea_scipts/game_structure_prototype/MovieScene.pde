import processing.video.*;

class MovieScene extends Scene {
  Movie videoToPlay;

  public MovieScene (String sceneName, String videoFile, PApplet parent) {
    super(sceneName);
    this.videoToPlay = new Movie(parent, videoFile);
  }

  @Override
    public void draw(int wwidth, int wheight) {
    videoToPlay.play();
    image(videoToPlay, 0, 0, wwidth, wheight);
  }

  public void movieEvent(Movie m) {
    m.read();
  }
}
