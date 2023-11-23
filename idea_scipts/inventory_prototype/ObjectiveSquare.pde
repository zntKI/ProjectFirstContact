class ObjectiveSquare
{
  float posX;
  float posY;
  int whatColor;
  
  ObjectiveSquare(int whatColor, float posX, float posY){
    this.posX = posX;
    this.posY = posY;
    this.whatColor = whatColor;
  }
  
  void show()
  {
    if(whatColor == 1){
      fill(255, 0, 0);
    }else if(whatColor == 2){
      fill(0, 255, 0);
    }else if(whatColor == 3){
      fill(0, 0, 255);
    }
    
    rectMode(CENTER);
    rect(posX, posY, 100, 100);
  }
}
