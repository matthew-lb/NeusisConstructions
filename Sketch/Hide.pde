class Hide implements Act {

  EObject item;
  
  Hide(EObject s) {
    item = s;
    redo = new Stack<Act>();
  }
  
  void undo() {
    item.show();
    redo.push(this);
  }
  
  void redo() {
    item.hide();
    undo.push(this);
  }
  
  
}


