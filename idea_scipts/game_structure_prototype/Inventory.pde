class Inventory { //<>//
  private ArrayList<Collectable> inventoryItems;

  private int itemsSize = 70;
  private int itemsY = 70;
  private int startX = 70;
  private int spaceBetweenItems = 20;

  private Collectable lastGrabbedItem = null;

  public Inventory () {
    inventoryItems = new ArrayList<Collectable>();
  }

  public int getItemsSize() {
    return itemsSize;
  }
  
  public int getItemsY() {
    return itemsY;
  }

  public Collectable getCurrentItemGrabbed() {
    return lastGrabbedItem;
  }

  public String getItemsIdentifiers() {
    String idenitifierConcat = "";
    for (Collectable object : inventoryItems) {
      idenitifierConcat += object.getIdentifier();
    }
    return idenitifierConcat;
  }

  public boolean canPickUpItem() {
    if (inventoryItems.size() == 0 || lastGrabbedItem == null) {
      return true;
    }
    return false;
  }

  public Collectable draw() { //<>//
    Collectable collectableGrabbed = null;
    for (Collectable object : inventoryItems) {
      if (object.getIsGrabbed()) {
        collectableGrabbed = object;
        continue;
      }
      object.draw();
    }

    return collectableGrabbed;
  }

  public void addToInventory(Collectable item) {
    inventoryItems.add(item);
  }

  public void removeFromInventory(Collectable item) {
    int count = 0;
    for (int i = inventoryItems.indexOf(item) + 1; i < inventoryItems.size(); i++) { //<>//
      inventoryItems.get(i).updatePosInventory(item.getX() + count * (itemsSize + spaceBetweenItems), itemsY, itemsSize);
      count++;
    }
    inventoryItems.remove(item);
    lastGrabbedItem = null;
  }

  public void removeFromInventory(String itemId) {
    Collectable item = null;
    for (Collectable collectable : inventoryItems) {
      if (collectable.getIdentifier().equals(itemId)) {
        item = collectable;
        removeFromInventory(item);
        break;
      }
    }
    if (item == null) {
      println("Smth went wrong with the Donut and Officer");
      return;
    }
  }

  public int getXPosForNext() {
    return startX + spaceBetweenItems * inventoryItems.size() + itemsSize * inventoryItems.size() + itemsSize / 2;
  }

  public void mouseClicked() {
    for (Collectable object : inventoryItems) {
      boolean isClicked = object.mouseClickedInventory();
      boolean isGrabbed = object.getIsGrabbed();
      if (isClicked && !isGrabbed) {
        object.updateIsGrabbed(true);
        if (lastGrabbedItem != null) {
          lastGrabbedItem.updateIsGrabbed(false);
        }
        lastGrabbedItem = object;
      } else if (isClicked && isGrabbed) {
        object.updateIsGrabbed(false);
        lastGrabbedItem = null;
      }
    }
  }

  public boolean mouseMoved() {
    for (Collectable object : inventoryItems) {
      if (object.mouseMoved() || object.getIsGrabbed()) {
        return true;
      }
    }
    return false;
  }
}
