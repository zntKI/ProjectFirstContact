class ClickableItems
{
  int whatColor;
  float size;
  float posX;
  float posY;
  
  ClickableItems(int whatColor, float size, float posX, float posY)
  {
    this.whatColor = whatColor;
    this.size = size;
    this.posX = posX;
    this.posY = posY;
  }
  
  void show(){
    if(whatColor == 1){
      fill(255, 0, 0);
    } else if(whatColor == 2){
      fill(0, 255, 0);
    } else if(whatColor == 3){
      fill(0, 0, 255);
    }
    
    circle(posX, posY, size);
  }
}
