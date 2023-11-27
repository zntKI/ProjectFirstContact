class Inventory{
  ArrayList<Collectable> inventoryItems = new ArrayList<Collectable>();
  int posx;
  int posy = 50;
  
  void draw(){
    for(int i = 0; i < inventoryItems.size(); i++){
      imageMode(CENTER);
      Collectable item = inventoryItems.get(i);
      posx = 50 + i * (item.owidth + 20);
      item.x = posx;
      item.y = posy;
      image(item.gameObjectImage, posx, posy);
      if(item.isGrabbed){
        
        image(item.gameObjectImage, mouseX, mouseY);
        
      }
      imageMode(CORNER);
    }
  }
  
  void addToInventory(Collectable item){
    inventoryItems.add(item);
    //item.updatePos();
  }
  
  void keyPressed(){
    for(Collectable item : inventoryItems){
      println(item.x);
      println(item.y);
      println(mouseX);
      println(mouseY);
    }
  }
}
