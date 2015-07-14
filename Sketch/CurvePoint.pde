class CurvePoint extends EPoint {
  /* Instance Variables:
      hide - determines whether or not the EPoint should be displayed
      dependents - EObjects that should be changed when EPoint is changed
      name - the object's name
      xpos - x coordinate of the point
      ypos - y coordinate of the point
      moveable - false; point cannot move anywhere in the plane
      curveMoveable - true; Point can move on the specific curve
      movingCurve - curve point moves along
  */
  
  ECurve movingCurve;
  
  /* Constructors:
      EPoint(xpos, ypos, ECurve, name) - creates point moveable along ECurve
  */
  
  CurvePoint(float x, float y, ECurve e, String n) {
    super(x,y,n);
    movingCurve = e;
    movingCurve.addDependent(this);
    setXY(x,y);
  }
  
  /* Inherited Methods:
      display() - displays the object
      addDependent() - adds a new EObject that is dependent on this
      hide() - hides object
      show() - shows object
      changeName(n) - changes name to n
      setX(c) - sets x coordinate to c
      setY(c) - sets y coordinate to c
  */
  
  void setXY(float x, float y) {
    EPoint a = closestPoint(movingCurve, x, y);
    xpos = a.xpos;
    ypos = a.ypos;
    for (EObject e : dependents) {
      e.update();
    }
  }
  
  void removePointers() {
    movingCurve.removeDependent(this);
  }
  
  void addPointers() {
    movingCurve.addDependent(this);
  }
  
  void update() {
    setXY(xpos, ypos);
    for (int i = 0; i < dependents.size(); i++) {
      dependents.get(i).update();
    }
  }
  
  void display() {
    if (!hide && exists) {
      if (!selected) {
        fill(255,255,0);
      } else {
        fill(127,127,0);
      }
      ellipse(convX(xpos), convY(ypos),10,10);
    }
  }
}
