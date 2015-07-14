class Move implements Act{
  
  EPoint p;
  float oldx;
  float oldy;
  float newx;
  float newy;
  
  Move(EPoint point, float ox, float oy) {
    p = point;
    oldx = ox;
    oldy = oy;
    newx = p.xpos;
    newy = p.ypos;
    redo = new Stack<Act>();
  }
  
  void undo() {
    p.setX(oldx);
    p.setY(oldy);
    p.update();
    redo.push(this);
  }
  
  void redo() {
    p.setX(newx);
    p.setY(newy);
    p.update();
    undo.push(this);
  }
}
