ArrayList<ClickableItems> items = new ArrayList<ClickableItems>();
ArrayList<InventoryItems> inventory = new ArrayList<InventoryItems>();
ArrayList<ObjectiveSquare> squares = new ArrayList<ObjectiveSquare>();

int inventoryItemSize = 50;
int inventoryAmount = 0;

int activeColor = 0;

void setup()
{
  size(1000, 1000);
  
  items.add(new ClickableItems(1, 200, 200, 400));
  items.add(new ClickableItems(2, 150, 800, 400));
  items.add(new ClickableItems(3, 100, 500, 700));
  
  squares.add(new ObjectiveSquare(1, 250, height - 100));
  squares.add(new ObjectiveSquare(2, 500, height - 100));
  squares.add(new ObjectiveSquare(3, 750, height - 100));
}

void draw()
{
  background(255);
  
  drawItems();
}

void drawItems()
{
  for(int i = 0; i < items.size(); i++){
    items.get(i).show();
  }
  
  for(int i = 0; i < inventory.size(); i++){
    inventory.get(i).show(50 + 75 * i);
  }
  
  for(int i = 0; i < squares.size(); i++){
    squares.get(i).show();
  }
}

void mousePressed()
{
  //Putting clicked items into the inventory.
  for(int i = 0; i < items.size(); i++){
    ClickableItems item = items.get(i);
    
    if(dist(mouseX, mouseY, item.posX, item.posY) <= item.size / 2){
      items.remove(i);
      inventory.add(new InventoryItems(item.whatColor, inventoryItemSize));
    }
  }
  
  //Clicking items in the inventory to use them.
  for(int i = 0; i < inventory.size(); i++){
    InventoryItems item = inventory.get(i);
    
    if(dist(mouseX, mouseY, item.positionX, 50) <= item.size / 2 && !item.isGrabbed){
      for(int j = 0; j < inventory.size(); j++){
        InventoryItems iTem = inventory.get(j);
        if(iTem.isGrabbed){
          iTem.isGrabbed = false;
          activeColor = 0;
        }
      }
      activeColor = item.whatColor;
      item.isGrabbed = true;
    }else if(dist(mouseX, mouseY, item.positionX, 50) <= item.size / 2 && item.isGrabbed){
      item.isGrabbed = false;
      activeColor = 0;
    }
  }
  
  //Using items on the squares.
  for(int i = 0; i < inventory.size(); i++){
    InventoryItems item = inventory.get(i);
    
    for(int j = 0; j < squares.size(); j++){
      ObjectiveSquare square = squares.get(j);
      
      if(mouseX > square.posX - 50 && mouseX < square.posX + 50 &&
      mouseY > square.posY - 50 && mouseY < square.posY + 50 &&
      activeColor == square.whatColor && activeColor == item.whatColor){
        inventory.remove(i);
        squares.remove(j);
        activeColor = 0;
      }
    }
  }
}
