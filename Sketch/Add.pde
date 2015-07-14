class Add implements Act {
  
  EObject item;
  
  Add(EObject s) {
    item = s;
    redo = new Stack<Act>();
  }
  
  void undo() {
    removeObject(item);
    item.removePointers();
    redo.push(this);
  }
  
  void redo() {
    addObject(item);
    item.addPointers();
    undo.push(this);
  }
  
  boolean onScreen(EObject item) {
    if (item instanceof EPoint) {
      if (points.indexOf((EPoint) item) != -1) { 
        return true;
      }
    } 
    if (item instanceof ELine) {
      if (lines.indexOf((ELine) item) != -1) { 
        return true;
      }
    }
    if (item instanceof ECircle) {
      if (circles.indexOf((ECircle) item) != -1) { 
        return true;
      }
    }
    return false;
  }
  
  void removeObject(EObject item) {
    for (EObject e: item.dependents) {
      if (onScreen(e)) {
        removeObject(e);
      }
    }
    if (item instanceof EPoint) {
      points.remove((EPoint) item);
    }
    else if (item instanceof ELine) {
      lines.remove((ELine) item);
    }
    else if (item instanceof ECircle) {
      circles.remove((ECircle) item);
    }
  }
  
  void addObject(EObject item) {
   for (EObject e: item.dependents) {
      if (!onScreen(e)) {
        addObject(e);
      }
    }
    if (item instanceof EPoint) {
        points.add((EPoint) item);
      }
      else if (item instanceof ELine) {
        lines.add((ELine) item);
      }
      else if (item instanceof ECircle) {
        circles.add((ECircle) item);
      }
  }
}
