class SoundManager{
  SoundFile backgroundMusic;
  SoundFile trainSound;
  SoundFile pickup;
  SoundFile locker;
  SoundFile gunFire;
  
  SoundManager(PApplet parent, String backgroundMusic, String trainSound, String pickup, String locker, String gunFire){
    this.backgroundMusic = new SoundFile(parent, backgroundMusic);
    this.backgroundMusic.loop();
    this.trainSound = new SoundFile(parent, trainSound);
    this.trainSound.amp(0.25);
    this.trainSound.loop();
    this.pickup = new SoundFile(parent, pickup);
    this.pickup.amp(0.9);
    this.locker = new SoundFile(parent, locker);
    this.gunFire = new SoundFile(parent, gunFire);
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
