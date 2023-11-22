class InventoryItems
{
  int whatColor;
  float size;
  
  InventoryItems(int whatColor, float size)
  {
    this.whatColor = whatColor;
    this.size = size;
  }
  
  void show(int posX)
  {
    if(whatColor == 1){
      fill(255, 0, 0);
    } else if(whatColor == 2){
      fill(0, 255, 0);
    } else if(whatColor == 3){
      fill(0, 0, 255);
    }
    
    circle(posX, 50, size);
  }
}
