class SoundManager{
  SoundFile backgroundMusic;
  SoundFile trainSound;
  SoundFile pickup;
  
  SoundManager(PApplet parent, String backgroundMusic, String trainSound, String pickup){
    this.backgroundMusic = new SoundFile(parent, backgroundMusic);
    this.backgroundMusic.loop();
    this.trainSound = new SoundFile(parent, trainSound);
    this.trainSound.amp(0.15);
    this.trainSound.loop();
    this.pickup = new SoundFile(parent, pickup);
    this.pickup.amp(0.9);
  }
  
  void playBackgroundMusic(){
    if(millis() > 10000){
      backgroundMusic.stop();
    }
  }
  
  void playPickup(){
    pickup.play();
  }
}
