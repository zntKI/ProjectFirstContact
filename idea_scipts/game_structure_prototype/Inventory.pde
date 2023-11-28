class Inventory {
  private ArrayList<Collectable> inventoryItems;

  private int itemsSize = 100;
  private int spaceBetweenItems = itemsSize / 5;

  private Collectable lastGrabbedItem = null;
  private String currentItemGrabbed = "none";

  public Inventory () {
    inventoryItems = new ArrayList<Collectable>();
  }

  public int getItemsSize() {
    return itemsSize;
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

  public void addToInventory(Collectable item) { //<>//
    inventoryItems.add(item);
  }

  public int getXPosForNext() {
    return spaceBetweenItems * (inventoryItems.size() + 1) + itemsSize * inventoryItems.size() + itemsSize / 2;
  }

  public void mouseClicked() {
    for (Collectable object : inventoryItems) {
      boolean isClicked = object.mouseClicked();
      boolean isGrabbed = object.getIsGrabbed();
      if (isClicked && !isGrabbed) {
        object.updateIsGrabbed(true);
        if (lastGrabbedItem != null) {
          lastGrabbedItem.updateIsGrabbed(false);
        }
        lastGrabbedItem = object;
        currentItemGrabbed = object.identifier;
      } else if (isClicked && isGrabbed) {
        object.updateIsGrabbed(false);
        lastGrabbedItem = null;
        currentItemGrabbed = "none";
      }
    }
  }
}
