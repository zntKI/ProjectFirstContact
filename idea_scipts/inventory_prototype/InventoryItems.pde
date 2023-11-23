class InventoryItems
{
  int whatColor;
  float size;
  float xtrSize = 0;
  float positionX;
  Boolean isGrabbed = false;
  
  InventoryItems(int whatColor, float size)
  {
    this.whatColor = whatColor;
    this.size = size;
  }
  
  void show(int posX)
  {
    positionX = posX;
    
    if(whatColor == 1){
      fill(255, 0, 0);
    } else if(whatColor == 2){
      fill(0, 255, 0);
    } else if(whatColor == 3){
      fill(0, 0, 255);
    }
    
    if(isGrabbed){
      xtrSize = 5;
    } else{
      xtrSize = 0;
    }
    
    circle(posX, 50, size + xtrSize);
    
    if(isGrabbed){
      circle(mouseX, mouseY, size);
    }
  }
}
