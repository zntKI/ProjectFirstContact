ArrayList<ClickableItems> items = new ArrayList<ClickableItems>();
ArrayList<InventoryItems> inventory = new ArrayList<InventoryItems>();

int inventoryItemSize = 50;
int inventoryAmount = 0;

void setup()
{
  size(1000, 1000);
  
  items.add(new ClickableItems(1, 200, 200, 400));
  items.add(new ClickableItems(2, 150, 800, 400));
  items.add(new ClickableItems(3, 100, 500, 700));
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
}

void mousePressed()
{
  for(int i = 0; i < items.size(); i++){
    ClickableItems item = items.get(i);
    
    if(dist(mouseX, mouseY, item.posX, item.posY) <= item.size / 2){
      items.remove(i);
      inventory.add(new InventoryItems(item.whatColor, inventoryItemSize));
    }
  }
}
