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
    } else {
      //add newNode to the end of list. tail->next set to newNode
      tail.next = newNode;
      //newNode->previous set to tail
      newNode.previous = tail;
      //newNode becomes new tail
      tail = newNode;
      //tail's next point to null
      tail.next = null;
      
      current = newNode;
    }
  }
  
  public Scene getCurrentScene() {
    return current.scene;
  }
  
  public void goToPrevious() {
    current = current.previous;
    if (current.scene instanceof GameScene) {
      ((GameScene)current.scene).updateTrainCoordinates(false);
    }
  }
  
  public void goToNext() {
    current = current.next;
    if (current.scene instanceof GameScene) {
      ((GameScene)current.scene).updateTrainCoordinates(true);
    }
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
