class DoublyLinkedList {
  class Node {
    Scene scene;
    Node previous;
    Node next;

    public Node(Scene scene) {
      this.scene = scene;
    }
  }

  private Node head, tail = null;
  private Node current = null;

  public void addNode(Scene scene) {
    //Create a new node
    Node newNode = new Node(scene);

    //if list is empty, head and tail points to newNode
    if (head == null) {
      head = tail = newNode;
      //head's previous will be null
      head.previous = null;
      //tail's next will be null
      tail.next = null;

      current = newNode;
    } else {
      //add newNode to the end of list. tail->next set to newNode
      tail.next = newNode;
      //newNode->previous set to tail
      newNode.previous = tail;
      //newNode becomes new tail
      tail = newNode;
      //tail's next point to null
      tail.next = null;
    }
  }

  public Scene getCurrentScene() {
    return current.scene;
  }

  public boolean goToPrevious() {
    if (current.previous != null) {
      current = current.previous;
      if (current.scene instanceof GameScene) {
        ((GameScene)current.scene).updateTrainCoordinates(false);
      }
      return true;
    }
    return false;
  }

  public boolean goToNext() {
    if (current.next != null) {
      current = current.next;
      if (current.scene instanceof GameScene) {
        ((GameScene)current.scene).updateTrainCoordinates(true);
      }
      return true;
    }
    return false;
  }

  public Scene findEvent(ArrayList<String> eventsNames) {
    int count = 0; //<>//
    Node currentNode = getNode("FoodTrolley");
    while (eventsNames.contains(currentNode.scene.getSceneName())) {
      if (count > 2) {
        current = currentNode;
        return current.scene;
      }
      currentNode = currentNode.next;
      count++;
    }
    current = currentNode;
    return current.scene;
  }
  
  private Node getNode(String sceneName) {
    Node currentNode = head;
    while (currentNode != null) {
      if (currentNode.scene.getSceneName() == sceneName) {
        return currentNode;
      }
      currentNode = currentNode.next;
    }
    return null;
  }

  public Scene getScene(String sceneName) {
    Node currentNode = head;
    while (currentNode != null) {
      if (currentNode.scene.getSceneName() == sceneName) {
        current = currentNode;
        return currentNode.scene;
      }
      currentNode = currentNode.next;
    }
    return null;
  }
}
